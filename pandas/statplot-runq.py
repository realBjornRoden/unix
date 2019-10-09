###
### statplot-runq.py
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
### echo $? # if 0 OK otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"
#
### Prereq:
### Install pandas,numpy,matplotlib
#
### Run:
### python3 statplot-runq.py  <PROC.csv>
#

import sys, getopt, os.path, re

import pandas
import numpy
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import matplotlib.dates as dates

#
# https://matplotlib.org/3.1.0/api/_as_gen/matplotlib.lines.Line2D.html#matplotlib.lines.Line2D
#

# FORMAT
# Processes LPAR	Runnable	Swap-in	pswitch	syscall	read	write	fork	exec	sem	msg	asleep_bufio	asleep_rawio	asleep_diocio
# 2019-08-21 00:02:09	4.61	0.00	25514	66978	3102	1894	21	36	0	0	0	1	1


def setPlot(ax,title,ylabel):
	SMALL_SIZE = 1
	MEDIUM_SIZE = 1
	BIGGER_SIZE = 22

	ax.rc('font', size=SMALL_SIZE)          # controls default text sizes
	ax.rc('axes', titlesize=SMALL_SIZE)     # fontsize of the axes title
	ax.rc('axes', labelsize=MEDIUM_SIZE)    # fontsize of the x and y labels
	ax.rc('xtick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
	ax.rc('ytick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
	ax.rc('legend', fontsize=SMALL_SIZE)    # legend fontsize
	ax.rc('figure', titlesize=BIGGER_SIZE)  # fontsize of the figure title
	ax.suptitle(title)
	ax.ylabel(ylabel)
	ax.grid(True,which='major', axis='x')



def setAnnotation(ax,text,y):
	ax.annotate(text,
		xy=(0, 0),
		xytext=(1.01, y),
		fontsize=10,
		xycoords=('axes fraction','data'),
		horizontalalignment='left',
		verticalalignment='center')



def main():
	filepath = sys.argv[1]
	print ("FILE: %s" % filepath)
	tag = 'runq'

	try: data = pandas.read_csv(filepath,index_col=0)
	except IOError as e: sys.exit('***EPANDAS read_csv: %s' % e)

	n = len(data)

	mean = data.iloc[0:n,0:1].mean().values
	stddev = data.iloc[0:n,0:1].std().values
	median = data.iloc[0:n,0:1].median().values
	max = data.iloc[0:n,0:1].max().values
	q50 = data.iloc[0:n,0:1].quantile(0.50).values
	q68 = data.iloc[0:n,0:1].quantile(0.68).values
	q75 = data.iloc[0:n,0:1].quantile(0.75).values
	q89 = data.iloc[0:n,0:1].quantile(0.89).values
	q95 = data.iloc[0:n,0:1].quantile(0.95).values
	q99 = data.iloc[0:n,0:1].quantile(0.99).values

	print("mean: %s" % mean)
	print("stddev: %s" % stddev)
	print("median: %s" % median)
	print("quantile 50%%: %s" % q50)
	print("quantile 68%%: %s" % q68)
	print("quantile 75%%: %s" % q75)
	print("quantile 89%%: %s" % q89)
	print("quantile 95%%: %s" % q95)
	print("quantile 99%%: %s" % q99)
	print("max: %s" % max)

	fig,ax = plt.subplots()
	setPlot(plt,'Running Processes',tag)

	plt.setp(ax.get_xticklabels(), rotation=30, ha="right")
	ax.yaxis.set_major_locator(ticker.MultipleLocator(5))
	ax.xaxis.set_major_locator(ticker.MultipleLocator(n/10))

	plt.axhline(y=mean, linewidth=1.5,color='darkgrey', linestyle='-')
	plt.axhline(y=median, linewidth=1.5,color='darkgrey', linestyle='-')
	plt.axhline(y=q89, linewidth=1.5,color='darkgrey', linestyle='-')
	plt.axhline(y=q95, linewidth=1.5,color='darkgrey', linestyle='-')
	plt.axhline(y=q99, linewidth=1.5,color='darkgrey', linestyle='-')
	plt.axhline(y=max, linewidth=1.5,color='black', linestyle='-')

	setAnnotation(ax,'mean',mean)
	setAnnotation(ax,'median',median)
	setAnnotation(ax,'q89%',q89)
	setAnnotation(ax,'q95%',q95)
	setAnnotation(ax,'q99%',q99)
	setAnnotation(ax,'max',max)

	plt.plot(data.iloc[0:n,0:1],linewidth=1.0,color="darkred")

	s = input('Continue to show and file plot [Y|n]...')
	if re.search('^$|[yY]|yes|Yes|YES',s):
		plt.savefig("%s.png"%tag,dpi=600)
		plt.show()
	plt.close()


if __name__ == "__main__":
# check args...
	if len(sys.argv) < 2: sys.exit('***ENOARG')
	if not os.path.isfile(sys.argv[1]): sys.exit('***ENOFILE')
	if not os.access(sys.argv[1],os.R_OK): sys.exit('***ENOREAD')

	print('***BEGIN')
	main()
	print('***END')
