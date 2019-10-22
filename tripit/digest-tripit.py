#
# digest-tripit.py
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
#-------------------------------------------------------------------------------- 
# <start_date>YYYY-MM-DD</start_date>
# <end_date>YYYY-MM-DD</end_date>
# <display_name>City, Country, Month Year</display_name>
#-------------------------------------------------------------------------------- 
import sys,os
from xml.dom import minidom as md

def getChildrenByTagName(node, tagName):
    for child in node.childNodes:
        if child.nodeType==child.ELEMENT_NODE and (tagName=='*' or child.tagName==tagName):
            yield child

if len(sys.argv) < 2: sys.exit('***ENOARG')
if not os.path.isfile(sys.argv[1]): sys.exit('***ENOFILE')
if not os.access(sys.argv[1],os.R_OK): sys.exit('***ENOREAD')

document = md.parse(sys.argv[1])

for trip in document.getElementsByTagName('Trip'):
    trip_id = list(getChildrenByTagName(trip,'id'))[0]
    trip_name = list(getChildrenByTagName(trip,'display_name'))[0]
    trip_start = list(getChildrenByTagName(trip,'start_date'))[0]
    trip_end = list(getChildrenByTagName(trip,'end_date'))[0]
    print(trip_id.firstChild.data,";",trip_name.firstChild.data,";",trip_start.firstChild.data,";",trip_end.firstChild.data)
