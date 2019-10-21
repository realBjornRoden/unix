#
# runplot.sh
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
[[ -f $1 ]] || { echo "***ENOFILE $1"; exit 1; }
INPUT=$1
NODE=${INPUT##*/}
NODE=${NODE%%.*}
NODENAME=$(echo $NODE|cut -f1 -d_|tr '_' '-')

if [[ -d ${INPUT%%/*} ]]; then
	PNGOUTPUT=${INPUT%%/*}/$NODE.plot-0.png
else
	PNGOUTPUT=$NODE.plot-0.png
fi

START="$(head -1 $INPUT|awk -F, 'NR==1{printf "%s %s",$2,$3;exit}')"
STOP="$(tail -1 $INPUT|awk -F, 'NR==1{printf "%s %s",$2,$3;exit}')"
_START=${START// /,}
_STOP=${STOP// /,}

echo "***PROCESSING [$NODENAME $TAG $START $STOP]"

# --------------------------------------------------------------------------------
# X-TICS
#
XTICS=$(cut -f2-3 -d, $INPUT|sort -t, -u|sort -t, -nk 1.7,1.10 -nk 1.1,1.2 -nk 1.4,1.5 -nk 2.1,2.2 -nk 2.4,2.5 -nk 2.7,2.8|
	awk -F, '
		{
		DATES[$1,"03:00:00"]=sprintf("%s,%s",$1,"03:00:00")
		DATES[$1,"06:00:00"]=sprintf("%s,%s",$1,"06:00:00")
		DATES[$1,"09:00:00"]=sprintf("%s,%s",$1,"09:00:00")
		DATES[$1,"12:00:00"]=sprintf("%s,%s",$1,"12:00:00")
		DATES[$1,"15:00:00"]=sprintf("%s,%s",$1,"15:00:00")
		DATES[$1,"18:00:00"]=sprintf("%s,%s",$1,"18:00:00")
		DATES[$1,"21:00:00"]=sprintf("%s,%s",$1,"21:00:00")
		DATES[$1,"00:00:00"]=sprintf("%s,%s",$1,"00:00:00")
		}
		END{
			sub(" ",",",START)
			printf "\"%s\"",START
			for (i in DATES) printf ",\"%s\"",DATES[i]
			sub(" ",",",STOP)
			printf ",\"%s\"",STOP
		}' START="$START" STOP="$STOP")


# --------------------------------------------------------------------------------
# PLOT COMMAND FILE
#
cat <<-EOF > $NODE.rc
	clear
	set terminal png font "SansSerif,8" nocrop enhanced size 960,480 
	set key nobox left top inside horizontal
	set datafile separator comma
	set datafile commentschars "#"

	stats '$INPUT' using 2:5 nooutput

	set bmargin 7
	set tmargin 5
	set lmargin 8
	set rmargin 12
	set grid ytics behind
	set grid xtics behind
	set tics out

	set xdata time
	set timefmt "%m/%d/%Y %H:%M:%S"
	set xtics axis nomirror rotate
	set ytics axis nomirror out

	set xrange [ "$START" : "$STOP" ]
	set ytics format "%.0f"
	set timefmt "%m/%d/%Y,%H:%M:%S"
	set format x "%d/%m %H:%M" 
	set xtics ( $XTICS ) font "SansSerif,7"

	set title "$NODENAME \n $TAGNAME [ $START - $STOP ]" tc rgb "#1034a6" font "SansSerif,12"
	set label 1 font "SansSerif,7" gprintf(" max=%.0f",STATS_max_y) at "$_STOP",STATS_max_y front
	set arrow 1 nohead from "$_START",STATS_max_y to "$_STOP",STATS_max_y linewidth 1.0 linecolor rgb "#808080" front
	set label 2 font "SansSerif,7" gprintf(" mean=%.0f",STATS_mean_y) at "$_STOP",STATS_mean_y front
	set arrow 2 nohead from "$_START",STATS_mean_y to "$_STOP",STATS_mean_y linewidth 1.0 linecolor rgb "#808080" front
	set label 3 font "SansSerif,7" gprintf(" median=%.2f",STATS_median_y) at "$_STOP",STATS_median_y front
	set arrow 3 nohead from "$_START",STATS_median_y to "$_STOP",STATS_median_y linewidth 1.0 linecolor rgb "#808080" front
	set label 4 font "SansSerif,7" gprintf(" q3=%.2f",STATS_up_quartile_y) at "$_STOP",STATS_up_quartile_y front
	set arrow 4 nohead from "$_START",STATS_up_quartile_y to "$_STOP",STATS_up_quartile_y linewidth 1.0 linecolor rgb "#808080" front

	set output '$PNGOUTPUT'
	plot '$INPUT' using 2:5 with line linecolor rgb "#bf0000" t "runq"
EOF

# --------------------------------------------------------------------------------
# RUN PLOT
#
gnuplot -e "set terminal png" $NODE.rc >/dev/null || { echo "***EPLOT"; exit 1; }
[[ -f $NODE.rc ]] && rm -f $NODE.rc
