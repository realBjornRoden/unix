#
# Copyright (c) 2019 B.Roden
#
# MIT License
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

# Scope: basic program structure, control structures, functions, arrays, pointers, file I/O, processs/threads, and basic concepts of object-oriented programming (classes, objects, function overloading)
# https://docs.python.org/3.7/library/index.html

# Importing/Including
import os,sys,signal,threading,getopt
import http.client
import ftplib

try: from platform import system as platform
except: sys.exit("***ENOIMPORT" % "platform")

# Definitions

# Global Variables
i:int

# Classes

# Functions
def logrecord(format,*argv):
 print(format % argv);

def cbTerminate(i,_):
 if i == 15: s = "SIGTERM"
 logrecord("signal [%d %s]",i,s)
 sys.exit(i)


# Main
if __name__ == "__main__":
 print("***START")

# Parameters
 if len(sys.argv) > 1:
  for i in range(len(sys.argv)): print("arg[%d]=%s" % (i,sys.argv[i]))
  i = int(sys.argv[1])

# External
 os.system('''uname -a''')

# Data Structures

# Conditionals
 if (i>0):   print("1: i is %d>0" % i)
 elif (i<0): print("1: i is %d<0" % i)
 else:       print("1: i is %d==0" % i)

 if (i>0 or i<0): print("2: i is %d!=0" % i)

 i_is_not_zero_rule = [i>0, i<0]
 if (not all(i_is_not_zero_rule)): print("2b: i is %d!=0" % i)

 print("3: i is %d!=0" % i) if (i != 0) else print("3: i is %d==0" % i)

 if (i > 0 and i < 10000):
  print("4: i is %d>0" % i)
 elif (i == 1):
  print("4: i is %d==0" % i)
 else:
  print("4: i is %d<0" % i)

# Loops - Sequential
 k=3
 for j in range(0,k+1): print("for k==%d j==%d" % (k,j))

 j=0
 while (j<=k):
  print("while k==%d j==%d" % (k,j))
  j+=1

## N/A do..until
 j=0
 while True:
  print("do while k==%d j==%d" % (k,j))
  j+=1
  if (j > k): break

# Loops - Breakout variations

 j=0
 while True:
  if (j > k): break
  print("while w/break k==%d j==%d" % (k,j))
  j+=1

 j=0
 while j >= 0:
  if (j>k):
   j=-1
   continue
  print("while w/continue k==%d j==%d" % (k,j))
  j+=1

## N/A do..until

 try:
  j=0
  while True:
   print("while w/throw k==%d j==%d" % (k,j))
   j+=1
   if (j>k): raise 0
 except: pass

# Control - Thread/Process
 p1 = os.fork()
 if p1 < 0:
  print("Fork failed %d"%p1)
 elif p1 == 0:
  print("In child process %d"%p1)
 else:
  print("In parent process child pid = %d"%p1);
  p2,rc = os.wait()
  print("Child process pid %d exit status = %d"%(p2,rc))
  sys.exit(0)

# Exceptions
 signal.signal(signal.SIGTERM, cbTerminate)

 try: 0/i
 except:
  print("Terminate 0")
  signal.pthread_kill(threading.get_ident(),signal.SIGTERM)
 else:
  print("Terminate %d" % i)

# I/O (File)
 try:
  with open(sys.argv[2],"r+") as fd:
   try: file_data = fd.read()
   except: sys.exit('***EREAD')
   else:
    print("Read \"%s\" from %s"%(file_data,sys.argv[2]))
    try: rc = fd.write("hello")
    except: sys.exit('***EWRITE ' + sys.argv[2] + rc)
    else: print("Wrote %d byte to %s"%(rc,sys.argv[2]))
   try: rc = fd.close()
   except: sys.exit('***ECLOSE ' + sys.argv[2] + rc)
 except: sys.exit('***EOPEN ' + sys.argv[2])

# I/O (TCP/HTTP)
 cd = http.client.HTTPSConnection("www.google.com")
 cd.request("GET", "/")
 rc = cd.getresponse()
 print(rc.status, rc.reason)
 html_data = rc.read()
 print("Read http data = \"%80.80s ...\""%html_data)

 try: ftp = ftplib.FTP(host="ftp1.at.proftpd.org",timeout=3)
 except: sys.exit('***EFTP')
 else:
  try: print(ftp.login())
  except: sys.exit('***EFTPLOGIN')
  else:
   try: ftp.retrlines('LIST')
   except: sys.exit('***EFTPLIST')
   else:
    print(ftp.cwd('distrib'))
    try: ftp.retrlines('LIST')
    except: sys.exit('***EFTPLIST')


