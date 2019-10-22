#
# format-dates.sh
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
# ------------------------------------------------------------------------------

[[ -z $1 ]] && { echo "***ENOARG"; exit 1; }
[[ -f $1 ]] || { echo "***ENOFILE"; exit 1; }
[[ -d data ]] || { echo "***ENODIR"; exit 1; }
INPUT=${1:-travel.csv}

# extract the dates and format output into MM YYYY on separate lines for each
# generate cal data for each MM YYYY

awk -F\; '{
	s=substr($3,2,7)
	e=substr($4,2,7)
	if (s==e){
		M=substr(s,6,2)
		Y=substr(s,1,4)
		s=sprintf("{ echo \"\n%s\n%s\n%s\n\" >> data/cal-%s-%s.txt;cal %s %s >> data/cal-%s-%s.txt; }",$2,$3,$4,M,Y,M,Y,M,Y)
		system(s)
	} else {
		M=substr(s,6,2)
		Y=substr(s,1,4)
		M2=substr(e,6,2)
		Y2=substr(e,1,4)
		s=sprintf("{ echo \"\n%s\n%s\n%s\n\" >> data/cal-%s-%s.txt;cal %s %s >> data/cal-%s-%s.txt; }",$2,$3,$4,M,Y,M,Y,M,Y)
		system(s)
		s=sprintf("{ echo \"\n%s\n%s\n%s\n\" >> data/cal-%s-%s.txt;cal %s %s >> data/cal-%s-%s.txt; }",$2,$3,$4,M2,Y2,M2,Y2,M2,Y2)
		system(s)
	}
}' $INPUT

