#
# digest-data.py
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
import sys, getopt, os.path
try: import textfsm
except: sys.exit('***ENOTEXTFSM')

if len(sys.argv) < 3: sys.exit('***ENOARG inputfile templatefile')
for i in range(len(sys.argv)): 
 if not os.path.isfile(sys.argv[i]): sys.exit('***ENOFILE ' + sys.argv[i])
 if not os.access(sys.argv[i],os.R_OK): sys.exit('***ENOREAD ' + sys.argv[i])

try:
 with open(sys.argv[1], encoding='utf-8') as fd:
  try: file_data = fd.read()
  except: sys.exit('***EREAD')
except: sys.exit('***EOPEN' + sys.argv[1])

try:
 with open(sys.argv[2]) as fd:
  try: parser = textfsm.TextFSM(fd)
  except: sys.exit('***ETEXTFSM')
except: sys.exit('***EOPEN' + sys.argv[2])

try: result = parser.ParseText(file_data)
except: sys.exit('***EPARSETEXT')

try:
   os.environ["HEADER"]
   print(parser.header)
except: pass

for row in result:
   print(row)
