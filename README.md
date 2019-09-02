# Hello World

### C hello.c
```
$ cc -o hello hello.c

$ ./hello
Hello World
```
### COBOL hello.cob
```
$ cobc -x hello.cob
$ ./hello
Hello World
```

### Dockers hello.dockers
```
$ sh hello.dockers 
Password:
Hello World
```

### Flask hello-flask.py
(in HTML browser; textbased with lynx or curl)
```
$ env FLASK_APP=hello-flask.py flask run & 
$ lynx http://127.0.0.1:5000/
$ curl -s http://127.0.0.1:5000/ | xargs echo
127.0.0.1 - - [01/Sep/2019 12:04:19] "GET / HTTP/1.1" 200 -
Hello, World!
$ fg
$ <CTRL+C>
```

### Golang hello.go
```
$ go run hello.go
Hello World
```

### Haskell hello.hs
```
$ ghc hello.hs
[1 of 1] Compiling Main             ( hello.hs, hello.o )
Linking hello ...

$ ./hello
Hello World
```

### HTML hello.html
(in HTML browser; textbased with lynx)
```
$ lynx hello.html
```

### JAVA hello.java
```
$ java hello.java
Hello World

$ javac hello.java

$ java hello
Hello World
```

### JavaScript hello.js
(in NODE)
```
$ node hello.js
Hello World
```

### PHP hello.php
(in HTML browser; http server with php)


### Python hello.py
```
$ python hello.py
Hello World

$ python3 hello.py
Hello World
```

### Ruby hello.rb
```
$ ruby hello.rb
Hello World
```

### Shell hello.sh
(Unix Bourne style shell and derivaties)
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

### SVG hello.svg
(in HTML browser)
```
