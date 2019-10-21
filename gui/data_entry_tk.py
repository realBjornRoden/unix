#
# data_entry.py
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

import os,sys,getopt
import json
from platform import system as platform
from argparse import Namespace as space

try: import tkinter as tk
except: sys.exit("***ENOIMPORT")
try: from tkinter import ttk
except: sys.exit("***ENOIMPORT")
from tkinter import font

# DEFINE
#
debug=0

# FUNCTIONS
#
def cbQuit(event=""):
 if event:
  if event.keysym == 'Escape': print('ESCAPE')
 root.quit()
 sys.exit("QUIT")


def cbOp(_op_="noop"):
 print("[" + _op_ + "]")
 statusBar['text'] = _op_

 if _op_ == "Quit":
  root.quit()
  sys.exit(_op_)

 if _op_ == "Save":
  data = ""
  for k in j['config']['entries']: 
   data += globals()[k['entry']].get()
  print("[" + data + "]")
  statusBar['text'] = data
 

def cbSubmit():
 data = ""
 for k in j['config']['entries']: 
  data += globals()[k['entry']].get()
 print("[" + data + "]")
 statusBar['text'] = data

# --------------------------------------------------------------------------------
# MAIN later do ==>> if __name__ == '__main__':

#
# READ JSON FORMATTED CONFIG FILE
#
_config = sys.argv[0]
_config = '.config_' + _config.split('.')[0]

try:
 fd = open(_config,"r")
 print("***OK [%s]"%(_config))
 try: j = json.load(fd)
 except: sys.exit("***ENOLOAD [%s]" % (_config))
except: sys.exit("***ENOCONFIG [%s]" % (_config))

#
# WINDOW
#
root = tk.Tk()
root['bg'] = j['config']['bg']
root.title(j['config']['title'])
_height = int(j['config']['height'])
_width = int(j['config']['width'])
root.geometry("%dx%d+0+0" % (_width, _height))

#
# Darwin Specials...
#
root.bind("<Escape>", cbQuit) # Hit ESC-key to exit
if platform() == 'Darwin': # Running an app in Terminal keeps focus in the Darwin (macos) Terminal, and dont bring the app to the front
 try:
  os.system('''/usr/bin/osascript -e 'tell app "Finder" to set frontmost of process "Python" to true' ''')
 except: pass # Wont work under virtualenv


#
# MENU BAR
#
menuBar = tk.Menu(root)
fileMenu = tk.Menu(menuBar, tearoff=0)
fileMenu.add_command(label="Open",  command=lambda: cbOp("Open"))
fileMenu.add_command(label="Save",  command=lambda: cbOp("Save"))
fileMenu.add_command(label="Close", command=lambda: cbOp("Close"))
fileMenu.add_separator()
fileMenu.add_command(label="Quit",  command=lambda: cbOp("Quit"))
editMenu = tk.Menu(menuBar, tearoff=0)
editMenu.add_command(label="Clear All",command=lambda: cbOp("Clear"))
menuBar.add_cascade(label="File", menu=fileMenu)
menuBar.add_cascade(label="Edit", menu=editMenu)
root.config(menu=menuBar)

#
# FRAME
#
frame = tk.Frame(root)
frame['bg'] = j['config']['bg']
frame.place(relx=0, rely=0, relwidth=1, relheight=1, anchor='nw')

_row=1
top_line= tk.Label(frame)
top_line['text'] = j['config']['sections'][0]['text']
top_line['font'] = j['config']['sections'][0]['font']
top_line.grid(row=_row,columnspan=3,sticky='n')

#
# LABELS
#
_row = 2
_col = 1
for k in j['config']['labels']: 
 globals()[k['label']] = tk.Label(frame)
 globals()[k['label']]['text'] = k['text']
 globals()[k['label']]['width'] = k['width']
 globals()[k['label']]['font'] = k['font']
 globals()[k['label']]['bg'] = k['bg']
 globals()[k['label']]['fg'] = k['fg']
 globals()[k['label']]['justify'] = 'left'
 globals()[k['label']]['anchor'] = 'w'
 globals()[k['label']].grid(row=_row,column=_col,sticky='w')
 _row=_row+1

#
# ENTRY
#
_row = 2
_col = 2
for k in j['config']['entries']: 
 globals()[k['entry']] = tk.Entry(frame)
 globals()[k['entry']]['width'] = k['width']
 globals()[k['entry']]['font'] = k['font']
 globals()[k['entry']]['bg'] = k['bg']
 globals()[k['entry']]['fg'] = k['fg']
 globals()[k['entry']]['justify'] = 'left'
 globals()[k['entry']].grid(row=_row,column=_col,sticky='w')
 _row=_row+1

#
# STATUS BAR
#
statusBar = tk.Label(root, text="processing", bd=1, relief='ridge', anchor='w')
statusBar.pack(side='bottom', fill='x')
statusBar['text'] = j['config']['status']['text']
statusBar['font'] = j['config']['status']['font']

root.mainloop()
