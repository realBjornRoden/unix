## openMPP
Open Multi-processing (OpenMP) is a technique of parallelizing a section(s) of C/C++/Fortran code.
[darwin aka macosx](https://www.openmp.org)
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

int main(int argc, char* argv[])
{
    int nthreads, tid;

    // Declare start of parallel region
    #pragma omp parallel private(nthreads, tid)
    {
        // thread number
        tid = omp_get_thread_num();
        printf("Thread = %d\n", tid);

        if (tid == 0) {
            // master process thread, get the number of parallell threads
            nthreads = omp_get_num_threads();
            printf("Number of threads = %d\n", nthreads);
        }
    }
}
```
