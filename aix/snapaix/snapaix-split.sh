###
### snapaix-split.sh
###
### Copyright June 2010 B.Roden (https://www.linkedin.com/in/roden/)
### 
### Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
### 
### The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
### 
### THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
### 
#
### Verify script as Open Sourced:
### md5 ${0##*/} > ${0##*/}.check 
### cmp ${0##*/}.md5 ${0##*/}.check 
### echo $? # if 0 OK otherwise it is not with output such as "snap-split.md5 snap-split.check differ: char 23, line 1"
#

### data directory => LPAR name
#
INPUT=${1:-data/general.snap}

### output directory
#
OUTDIR=${2:-out}

[[ -d "$OUTDIR" ]] || mkdir "$OUTDIR"

echo "***FILE $INPUT"

### Conceptual flow:
### 1: identify first line of the three line command header
### 2: identify second line of the three line command header, and format 
### 3: identify third line of the three line command header
### 4: write the content lines into the file from PHASE2
### AWK declaration flow: 3>1>2>4
# 
awk '
BEGIN{_N=1;_FILE="/dev/null";command_next=0}
END {close(_FILE_)}

/^\.\.\.\.\.$/&&command_next==2      {command_next=3;next} ### PHASE3
/^\.\.\.\.\.     $/&&command_next==2 {command_next=3;next} ### PHASE3
/^\.\.\.\.\.$/                       {command_next=1;next} ### PHASE1
/^\.\.\.\.\.     $/                  {command_next=1;next} ### PHASE1

/^\.\.\.\.\./&&command_next==1{                            ### PHASE2
	sub(".....    ","",$0)

	_N_ = _N

	_C=$0
	gsub(" ","_",_C)
	gsub("/","_",_C)
	sub(/_$/,"",_C)
	sub(/__$/,"",_C)

	_P=substr(FILENAME,0,index(FILENAME,".")-1)
	gsub("/","_",_P)

	_N = NR

	_FILE_ = _FILE
	_FILE = sprintf("%s/%s_%s.txt",ODIR,_P,_C)

	command_next=2
}

command_next==3 {                                          ### PHASE4
	printf "***SPLIT %0.6d\t%0.6d\t%s\n",_N_,_N,_FILE
	close(_FILE_)
	command_next=0
}

{
	print $0 >> _FILE
}
' ODIR="$OUTDIR" FILE="$INPUT" $INPUT
