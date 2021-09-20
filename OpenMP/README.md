## openMPP
[Open Multi-processing (OpenMP)](https://www.openmp.org) is an API model used to parallelize section(s) of code for shared-memory multiprocessing programming in C, C++ and Fortran ([OpenMP 5.1 API Syntax Reference Guide](https://www.openmp.org/wp-content/uploads/OpenMPRefCard-5.1-web.pdf)).
## Installing on macOS
```
$ brew install gcc
$ brew install libomp
$ gcc --version 2>/dev/null|grep version
Apple clang version 12.0.5 (clang-1205.0.22.9)
```
## Compiling & linking a program (hello_mp.c)
```
$ gcc -Xpreprocessor -fopenmp -lomp hello_mp.c -o hello_mp
```
## Running after specifying 4 threads
```
$ export OMP_NUM_THREADS=4
$ ./hello
Welcome to GFG from thread = 0
Number of threads = 4
Welcome to GFG from thread = 2
Welcome to GFG from thread = 1
Welcome to GFG from thread = 3
```
## Sample multi-threaded programs (hello_mp.c)
```
// OpenMP header
#include <omp.h>

#include <stdio.h>
#include <stdlib.h>

int
main(int argc, char* argv[])
{
    int tid;

    // Begin parallel region, define thread private variable(s)
    #pragma omp parallel private(tid)
    {   
        // The current thread number
        tid = omp_get_thread_num(); 
        printf("thread no = %d\n", tid);
        
        // If in the master thread
        if (tid == 0) printf("no of threads = %d\n", omp_get_num_threads());
    }
}
```
