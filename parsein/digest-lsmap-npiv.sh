#
# digest-lsmap-npiv.sh
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
#
# lsmap -all -npiv

DEBUG=

[[ -z "$1" ]] && { echo "***ENOARGS";exit 1; }
[[ -z "$2" ]] && { echo "***ENOARGS";exit 1; }
[[ -f "$1" ]] || { echo "***ENOFILE";exit 1; }

INPUT=${1:-lsmap--all-npiv.txt}
NODE=$2
DIR=data

awk 'BEGIN{ FS = "[: \t]+"; i=0; found=0 }
/^vfchost/{
	if ($4>"") {
		found=1
		vfchost[i]=$1
		physloc[i]=$2
		clntid[i]=$3
		clntname[i]=$4
		clntos[i]=$5
		split(physloc[i],tmp,"[.-]")
		srvslot[i]=substr(tmp[5],2)
		if (DEBUG) print vfchost[i],physloc[i],clntid[i],(clntname[i]>"")?clntname[i]:"NOT MAPPED",srvslot[i],clntos[i]
	}
}
/^FC name:/&&found>0{
	if ($3!~/FC/) {
		fcname[i]=$3
		fcloc[i]=$7
		if (DEBUG) print fcname[i],fcloc[i]
	}
}
/^VFC client name:/&&found>0{
	if ($4!~/VFC/) {
		vfcname[i]=$4
		vfcloc[i]=$8
		split(vfcloc[i],tmp,"[.-]")
		clntslot[i]=substr(tmp[5],2)
		if (DEBUG) print vfcname[i],vfcloc[i],clntslot[i]
	}
	i++
	found=0
}
END{
	gsub(/-/,"_",NODE)
	VIOS=substr(NODE,0,15)
	report = sprintf("%s/vfcmap-%s.txt",DIR,VIOS);
	print "vfchost","physloc","clntid","clntname","fcname","fcloc", "vfcname","vfcloc", "srvslot","clntslot" > report;
	for (j=0;j<i;j++) {
		print vfchost[j],substr(physloc[j],index(physloc[j],"-")+1),clntid[j],clntname[j], fcname[j],fcloc[j], vfcname[j],substr(vfcloc[j],index(vfcloc[j],"-")+1), srvslot[j],clntslot[j],clntos[i] >> report;
		fcname2[fcname[j]]=fcname[j]
	}
	close(report);

	print "digraph VFC { /* Directed Graph by B.Roden */"
	for (k in fcname2) {
		print "node [shape=box,style=solid,fixedsize=false,fontname=\"Helvetica\",fontsize=10];"
		for (j=0;j<i;j++) {
			if (fcname[j] == fcname2[k]) {
				#print vfchost[j],clntid[j],clntname[j], vfcname[j], srvslot[j],clntslot[j]
				gsub(/-/,"_",clntname[j])
				printf "%s -> %s  [label=\"%s-%s\",headlabel=\"%s-%s\",minlen=\"5\",tailport=\"s\",headport=\"n\",arrowhead=none,fontname=\"Helvetica\",fontsize=10];\n",fcname2[k],clntname[j],vfchost[j],srvslot[j],clntslot[j],vfcname[j]

			}
		}
	}
	print "}"
}' DEBUG=$DEBUG NODE="$NODE" DIR="$DIR" $INPUT > $DIR/$NODE.gv
[[ $? -eq 0 ]] || { echo "***EAWKTFAIL";exit 1; }

[[ -f "$DIR/$NODE.gv" ]] || { echo "***ENOFILE";exit 1; }

dot -v -Tpng -o $DIR/vfcmap-$NODE.png $DIR/$NODE.gv 2>/dev/null
[[ $? -eq 0 ]] || { echo "***EDOTFAIL";exit 1; }

[[ -z "$DEBUG" ]] && rm -f $DIR/$NODE.gv

echo vfcmap-$NODE.png vfcmap-$NODE.txt $NODE.gv
