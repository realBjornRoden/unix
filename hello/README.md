# Hello World

### Assembly - Mach-O [hello.s](hello.s)
```
$ as hello.s -o hello.o                    
$ ld hello.o -e _main -o hello -lSystem -lc
$ ./hello
Hello World!
```
Source
```
.section __DATA,__data
str:
  .asciz "Hello World!\n"

.section __TEXT,__text
.globl _main
_main:
  movl $0x2000004, %eax
  movl $1, %edi
  movq str@GOTPCREL(%rip), %rsi
  movq $100, %rdx
  syscall

  movl $0, %ebx
  movl $0x2000001, %eax
  syscall
```
### C [hello.c](hello.c)
```
$ cc -o hello hello.c
$ ./hello
Hello World
```
Source
```
#include <stdio.h>
int main(){printf("Hello World\n");}
```

### C++ [hello.cpp](hello.cpp)
```
$ c++ -o hello hello.cpp
$ ./hello
Hello World
```
Source
```
#include <iostream>
int main() { std::cout << "Hello World\n"; }
```

### COBOL [hello.cob](hello.cob)
```
$ cobc -x hello.cob
$ ./hello
Hello World
```
Source (original format)
```
    IDENTIFICATION DIVISION.
    PROGRAM-ID. hello.

    PROCEDURE DIVISION.
    DISPLAY 'Hello World'.
    STOP RUN.
```

### Dockers [hello.dockers](hello.dockers)
```
$ sh hello.dockers 
Password:
Hello World
```
Source
```
#
# ksh or bash on POSIX 1003.1 aligned operating system enviornments/B.Roden@2019
#
IMAGE=alpine
sudo docker run --name helloWorld $IMAGE echo "Hello World" 2>/dev/null
[[ $? -ne 0 ]] && exit 1
INSTANCE=$(docker container ls -a 2>/dev/null|awk '/alpine/&&/helloWorld/{print $1}')
RC=$(docker inspect --format='{{.Config.Image}}' $INSTANCE 2>/dev/null|grep -c $IMAGE)
[[ $RC -gt 0 ]] && docker rm $INSTANCE >/dev/null 2>&1
RC=$(docker inspect --format='{{.Config.Image}}' $INSTANCE 2>/dev/null|grep -c $IMAGE)
###[[ $RC -gt 0 ]] || echo "REMOVED $INSTANCE of $IMAGE"
```

### ELM [hello.elm](hello.elm)
(in HTML browser; textbased with curl or lynx)
```
$ elm init          
Hello! Elm projects always start with an elm.json file. I can create them!

Now you may be wondering, what will be in this file? How do I add Elm files to
my project? How do I see it in the browser? How will my code grow? Do I need
more directories? What about tests? Etc.

Check out <https://elm-lang.org/0.19.0/init> for all the answers!

Knowing all that, would you like me to create an elm.json file now? [Y/n]: 
Okay, I created it. Now read that link!

$ elm make src/hello.elm 
Starting downloads...

  elm/url 1.0.0
  elm/virtual-dom 1.0.2
  elm/core 1.0.2
  elm/time 1.0.0
  elm/html 1.0.0
  elm/browser 1.0.1
  elm/json 1.1.3

Dependencies ready!                
Success! Compiled 1 module.                                          

$ python3 -m http.server &

$ curl -s http://0.0.0.0:8000/ | grep Hello
var author$project$Main$main = elm$html$Html$text('Hello World');
```
Source
```
import Html exposing (text)
main = text "Hello World"
```

### Flask [hello-flask.py](hello-flask.py)
(in HTML browser; textbased with curl or lynx)
```
$ env FLASK_APP=hello-flask.py flask run & 
$ curl -s http://127.0.0.1:5000/ | xargs echo
127.0.0.1 - - [01/Sep/2019 12:04:19] "GET / HTTP/1.1" 200 -
Hello World
$ fg
$ <CTRL+C>
```
Source
```
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World"
```

### Fortran [hello.f](hello.f)
```
$ gfortran -ffree-form hello.f -o hello
$ ./hello
Hello World
```
Source (free format)
```
program hello
print *,'Hello World'
end
```
Source (original format)
```
      program hello
      implicit none
c
      character*32 text
c
      text = 'Hello World'
      write (*,*) text
c
      end
```
Source (ancient format)
```
        WRITE (6, 100)
100     FORMAT (1H ,11HHello World)
        CALL EXIT
        END
```

### Golang [hello.go](hello.go)
```
$ go run hello.go
Hello World
```
Source
```
package main
import "fmt"
func main() {
	   fmt.Printf("Hello World\n")
}
```

### Haskell [hello.hs](hello.hs)
```
$ ghc hello.hs
[1 of 1] Compiling Main             ( hello.hs, hello.o )
Linking hello ...

$ ./hello
Hello World
```
Source
```
main = putStrLn "Hello World"
```

### HTML [hello.html](hello.html)
(in HTML browser; textbased with curl/lynx)
```
$ python3 -m http.server &
$ curl http://0.0.0.0:8000/hello.html
```
Source
```
<!DOCTYPE html>
<html> <head> <meta charset="utf-8"> <title>Hello World</title> </head>
<body>Hello World</body>
</html>
```

### JAVA [hello.java](hello.java)
```
$ java hello.java
Hello World

$ javac hello.java

$ java hello
Hello World
```
Source
```
class hello { 
	public static void main(String args[]) { 
		System.out.println("Hello World"); 
	} 
}
```

### JavaScript [hello.js](hello.js)
(in NODE)
```
$ node hello.js
Hello World
```
Source
```
console.log("Hello World");
```

### Pascal [hello.p](hello.p)
```
$ fpc hello.p
Free Pascal Compiler version 3.0.4 [2018/09/30] for x86_64
Copyright (c) 1993-2017 by Florian Klaempfl and others
Target OS: Darwin for x86_64
Compiling hello.p
Assembling (pipe) hello.s
Linking hello
5 lines compiled, 0.1 sec

$ ./hello
Hello World
```
Source
```
program hello;
begin
	writeln('Hello world');
end.
```

### PHP [hello.php](hello.php)
(in HTML browser; http server with php module)
```
$ curl http://127.0.0.1:80/hello.php; echo
127.0.0.1 - - [07/Oct/2019 07:14:04] "GET /hello.php HTTP/1.1" 200 -
Hello World
```
Source
```
<!DOCTYPE html>
<html> <head> <meta charset="utf-8"> <title>Hello World</title> </head>
<body> <?php echo '<p>Hello World</p>'; ?> </body> </html>
```

### Python [hello.py](hello.py)
```
$ python hello.py
Hello World

$ python3 hello.py
Hello World
```
Source
```
print("Hello World")
```

### Ruby [hello.rb](hello.rb)
```
$ ruby hello.rb
Hello World
```
Source
```
puts 'Hello World'
```

### Shell [hello.sh](hello.sh)
(Unix Bourne style shell and its derivaties, such as Korn, Bash, Z, etc)
```
$ sh hello.sh
Hello World

$ hello.sh
-bash: hello.sh: command not found

$ ./hello.sh
-bash: ./hello.sh: Permission denied

$ chmod +x ./hello.sh

$ ./hello.sh
Hello World
```
Source
```
echo "Hello World"
```

### SVG [hello.svg](hello.svg)
(in HTML browser)
Source
```
<svg  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <text x="0" y="14">Hello World</text>
</svg>
```

### Vala [hello.vala](hello.vala)
```
$ valac hello.vala
$ ./hello
Hello World
```
Source
```
void main () {
	print ("Hello World\n");
}
```
