#
# digest-lsattr-sea.sh
#
# Copyright (c) 2009,2019 B.Roden
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# lsattr -El ent*
#
# TODO
# review for single real adapter
# add lookup for sea virtual adapter

[[ -z "$1" ]] && { echo "***ENOARGS";exit 1; }
[[ -z "$2" ]] && { echo "***ENOARGS";exit 1; }
[[ -f "$1" ]] || { echo "***ENOFILE";exit 1; }
DIR=data
[[ -d "$DIR" ]] || { echo "***ENODIR";exit 1; }

INPUT=${1:-lsmap-Elent.txt}
NODE=$2

TMP1=1-$$.tmp
TMP2=2-$$.tmp
[[ -f $TMP1 ]] && rm -f $TMP1
[[ -f $TMP2 ]] && rm -f $TMP2


getseavirt() {
	NODE=$1
	[[ -z $DEBUG ]] || echo "***Processing SEA VIRTUAL for NODE [$NODE]"
}

getsea() {
	NODE=$1
	[[ -z $DEBUG ]] || echo "***Processing SEA for NODE [$NODE]"

	awk 'BEGIN{found=0;}

	/Network adapter: ent[0-99]/{adapter=$4;adapters[adapter]=adapter;found=1}
	# SEA
	found>0&&/ctl_chan/{ctl_chan[adapter]=$2;}
	found>0&&/pvid_adapter/{pvid_adapter[adapter]=$2;}
	found>0&&/real_adapter/{real_adapter[adapter]=$2;}
	found>0&&/virt_adapters/{virt_adapters[adapter]=$2;found=0;}
	END{
		for (i in adapters) {
			if (ctl_chan[i]) {
				printf "%s %s %s %s %s\n",adapters[i],ctl_chan[i],pvid_adapter[i],real_adapter[i],virt_adapters[i]
			}
		}
	}
	' VIOS="$NODE" $INPUT > $TMP1
}

getlagg()
{
	NODE=$1
	[[ -z $DEBUG ]] || echo "***Processing LAGG for NODE [$NODE]"

	while read sea ctl_chan pvid_adapter real_adapter virt_adapters;do

		awk 'BEGIN{found=0;}

		/Network adapter: '$real_adapter' /{adapter=$4;adapters[adapter]=adapter;found=1;;next;}
		# LAGG
		found>0&&/adapter_names.*EtherChannel/{adapter_names[adapter]=$2;next}
		found>0&&/backup_adapter/{if ($2~/ent/) {backup_adapter[adapter]=$2}else{backup_adapter[adapter]="none"};found=0;next;}
		found>0&&/^###/{backup_adapter[adapter]="none";found=0;}

		END{
			for (i in adapters) {
				if (adapter_names[i]) {
					printf "%s %s %s\n",adapters[i],adapter_names[i],backup_adapter[i]
				}
			}
		}' VIOS="$NODE" $INPUT
	done <$TMP1 > $TMP2
}

# --------------------------------------------------------------------------------

getsea $NODE
getlagg $NODE


while read sea ctl_chan pvid_adapter real_adapter virt_adapters;do

	[[ -z $DEBUG ]] || echo "***Processing DOT on NODE [$NODE]"

	awk '$1~/'$real_adapter'/{
		NODE=VIOS
		gsub("-","_",NODE);

		gvout = sprintf("data/sea_%s_%s.gv",VIOS,sea);
		txtout = sprintf("data/entmap_%s_%s.txt",VIOS,sea);

		n1=split(virt_adapters,virt_adapters2,",");
		n2=split($2,real_adapter2,",");

		printf "SEA: %s ctl %s pvid %s ",sea,ctl_chan,pvid_adapter > txtout
		printf " virt " >> txtout
		for (j in virt_adapters2) printf "%s ",virt_adapters2[j] >> txtout

		printf " real %s ",real_adapter >> txtout

		if (n2>1) { printf " lagg " >>txtout; for (j in real_adapter2) printf "%s ",real_adapter2[j] >> txtout; }

		printf "\n" >> txtout

		printf "digraph SEA { /* Directed Graph by B.Roden */\n" > gvout

		printf "node [shape=plaintext,style=filled,fillcolor=none,fixedsize=false,fontname=\"Helvetica\",fontsize=10];\n" >> gvout
		printf "%s  [label=\"VIOS\n%s\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",NODE,VIOS >> gvout
		printf "node [shape = doublecircle,style=solid,fixedsize=false,fontname=\"Helvetica\",fontsize=14];\n" >> gvout
		printf "%s  [label=\"SEA\n%s\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",sea,sea >> gvout
		printf "node [shape = circle,fixedsize=true,fontname=\"Helvetica\",fontsize=11];\n" >> gvout
		printf "%s -> %s  [label=\"ctrl\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",sea,ctl_chan >> gvout
		printf "%s -> %s  [label=\"real\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",sea,real_adapter >> gvout

		## Looping on Virtual
		for (j in virt_adapters2) printf "%s -> %s  [label=\"virt\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",sea,virt_adapters2[j] >> gvout

		## Looping on Physical
		if (n2>1) {
			for (j in real_adapter2) printf "%s -> %s [label=\"lagg\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",real_adapter,real_adapter2[j] >> gvout
		} else {
			if ($3!~/none/) printf "%s -> %s [label=\"backup\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",real_adapter,$3 >> gvout
		}
		printf "} /* END */\n" >> gvout

	}' sea=$sea ctl_chan=$ctl_chan pvid_adapter=$pvid_adapter real_adapter=$real_adapter virt_adapters=$virt_adapters VIOS=$NODE $TMP2
done < $TMP1

[[ -f $TMP1 ]] && rm -f $TMP1
[[ -f $TMP2 ]] && rm -f $TMP2

for i in $(ls $DIR/sea*.gv);do
	[[ -z $DEBUG ]] || echo "***Processing DOT to PNG on NODE [$NODE]"
	PNGOUT=${i%%.*}.png
	dot -v -Tpng -o $PNGOUT $i 2>/dev/null
	[[ $? -eq 0 ]] || { echo "***EDOTFAIL";exit 1; }
	echo $PNGOUT
	rm -f $i
done
