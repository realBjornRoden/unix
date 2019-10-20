#!/bin/ksh
#
# digest-tags.sh
#
# Copyright (c) 2019 B.Roden
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
INDIR=${1:-data}
[[ -d $INDIR ]] || { echo "***ENODIR $INDIR"; exit 1; }
OUTDIR=${2:-data3}
[[ -d $OUTDIR ]] || mkdir $OUTDIR || { echo "***EMKDIR $OUTDIR"; exit 1; }
SUFFIX=${3:-csv}
PREFIX=${4}

EXCLUDE="AAA|CPU[0-9]|JFS|DISKR|DISKW|DISKS|DISKB|DISKX"

for FILE in $INDIR/${PREFIX}*.${SUFFIX};do
	[[ -f $FILE ]] || { echo "***ENOFILE $FILE"; exit 1; }
	cut -f1 -d, $FILE | sort -u | grep -v ZZZZ | grep -vE "$EXCLUDE" |
	while read TAG;do
		typeset -l tag=$TAG
		OUTPUT=${FILE##*/}
		OUTPUT=${OUTPUT%.*}.$tag.txt
		echo "***PROCESSING dir $INDIR file $FILE for tag $TAG output $OUTPUT"
		grep "^${TAG}," $FILE >$OUTDIR/$OUTPUT
		[[ $? -eq 0 ]] || { echo "***EGREP"; exit 1; }
	done
done
