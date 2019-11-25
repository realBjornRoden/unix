#/* run as shell script: sh $0
set -x; c++ -o ${0%%.*} $0; exit
*/
//
// Copyright (c) 2019 B.Roden
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

// Scope: basic program structure, control structures, functions, arrays, pointers, file I/O, processs/threads, and basic concepts of object-oriented programming (classes, objects, function overloading) 

// Importing/Including
#include <iostream>
using namespace std;
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

// Definitions
#define ASCII_BASE '0'

// Declarations - Global Variable
int i=-1;

// Declarations - Class
class Rectangulum {
    union{ int width, x; };
    union{ int height, y; };
    union{ int depth, z; };
public:
    int set(int,int); int set(int,int,int);
    int get(int*,int*); int get(int*,int*,int*);
    int area(){return width*height;}
    int volume(){return width*height*depth;}
};
int Rectangulum::set(int x, int y) {
    try { width = x; height = y; } catch (int e) { return e; }
    return 0;
}
int Rectangulum::set(int x, int y, int z) {
    try { width = x; height = y; depth = z; } catch (int e) { return e; }
    return 0;
}
int Rectangulum::get(int *x, int *y) {
    try { *x = width; *y = height; } catch (int e) { return e; }
    return 0;
}
int Rectangulum::get(int *x, int *y, int *z) {
    try { *x = width; *y = height; *z = depth; } catch (int e) { return e; }
return 0;
}

// Functions
void logrecord(const char *format, ...)
{
    va_list args;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}

void cbTerminate(int i){logrecord("signal [%d %s]\n",i,(i==15)?"SIGTERM":"");exit(i);}

// Main
int main(int argc, char *argv[]) {
    cout << "***" << "START\n";

// Parameters
    if (argc>1) {
        cout << "argv[1] == \"" << argv[0] << "\" argv[1] == " << argv[1] << endl;
        i = (int)*argv[argc-1] - ASCII_BASE;                // only first char/byte of string
		i = static_cast<int>(*argv[argc-1]) - ASCII_BASE;   // only first char/byte of string
    i = atoi(argv[argc-1]);
    }

// External
    system("uname -a");

// Object - Data & Methods
    Rectangulum r;
    int x,y,z;

    r.set(3,4);
    r.get(&x,&y)?cout <<"r.get rc != 0\n":cout <<"r.get rc == 0\n";
    printf("values: x == %d y == %d\n",x,y);
    cout << "area: " << r.area() << endl;

    r.set(3,4,2);
    r.get(&x,&y,&z)?cout <<"r.get rc != 0\n":cout <<"r.get rc == 0\n";
    printf("values: x == %d y == %d z == %d\n",x,y,z);
    cout << "volume: " << r.volume() << endl;

// Control - Conditionals
    if (i>0) printf("1: i is %d>0\n",i);
    else if (i<0) printf("1: i is %d<0\n",i);
    else printf("1: i is %d==0\n",i);

    if (i>0||i<0) printf("2: i is %d!=0\n",i);

    (i!=0)?printf("3: i is %d!=0\n",i):printf("3: i is %d==0\n",i);

    switch(i) {
    case 1 ... 9999:
        printf("4: i is %d>0\n",i); break;
    case 0:
        printf("4: i is %d==0\n",i); break;
    default:
        printf("4: i is %d<0\n",i); break;
    }

// Control - Loops - Sequential
    const int k=3;

    for (int j=0;j<=k;j++) printf("for k==%d j==%d\n",k,j);

    int j=0;
    while (j<=k) printf("while k==%d j==%d\n",k,j++);

    j=0;
    do printf("do while k==%d j==%d\n",k,j); while (++j<=k);

// Control - Loops - Breakout variations
    j=0;
    do {
        if (j>k) break;
        printf("while w/break j==%d\n",j);
    } while (++j);

    j=0;
    do {
        if (j>k) {j=-1;continue;};
        printf("while w/continue j==%d\n",j);
    } while (++j);

    j=0;
    do {
        if (j>k) goto end_loop;
        printf("while w/goto j==%d\n",j);
    } while (++j);
    end_loop:

    try {
        j=0;
        do {
            if (j>k) throw 0;
             printf("while w/throw j==%d\n",j);
        } while (++j);
    } catch (int e){}

// Control - Thread/Process
    {
        pid_t  p1,p2; int rc = 0;
        if ((p1 = fork())<0) {
            printf("Fork failed %d\n",p1);
        } else if (p1 == 0){
            printf("In child process %d\n",p1);
        } else {
            printf("In parent process with child pid = %d\n",p1);
            p2 = wait(&rc);
            (WIFEXITED(rc))?printf("Child process pid %d exit status = %d\n",p2,WEXITSTATUS(rc)):NULL;
            exit(0);
        }
    }

// Control - Exceptions
    signal (SIGTERM, cbTerminate);

    int _e_;
    try {
        throw i;
    } catch (int e) {
        cout << "Exception e == " << e << "\n";
        _e_ = e;
        if (e!=9) goto terminate;
    }

    cout << "Bye\n"; exit(0);

    terminate:
        switch(_e_) {
            case 1: cout << "Terminate case 1\n"; break;
            default: cout << "Terminate default\n"; raise(SIGTERM);
        }
}

// I/O (File & Network)
