## Message Passing Interface (MPI)
[MPI Forum](https://www.mpi-forum.org/) is the standardization forum for the [Message Passing Interface (MPI)](https://www.mpi-forum.org/docs/mpi-4.0/mpi40-report.pdf).<br>
[OpenMPI](https://www.open-mpi.org/) project is an open source Message Passing Interface (MPI).<br>
[MPICH](https://www.mpich.org/) is a high-performance and widely portable implementation of the Message Passing Interface (MPI) standard (MPI-1, MPI-2 and MPI-3).<br>

## Installing on macOS
```
$ brew install open-mpi
```
## Compiling & linking a program (hello_mpi.c)
```
$ mpicc -o hello_mpi hello_mpi.c
```
## Running (the runtime order depends on job scheduler, in this case on a single node)
```
$ mpirun hello_mpi              
mpicommworld_rank:3 mpicommworld_size:6
mpicommworld_rank:4 mpicommworld_size:6
mpicommworld_rank:5 mpicommworld_size:6
mpicommworld_rank:0 mpicommworld_size:6
mpicommworld_rank:1 mpicommworld_size:6
mpicommworld_rank:2 mpicommworld_size:6
```
## Sample multi-threaded programs (hello_mpi.c)
```
#include <mpi.h>
#include <stdio.h>

int
main(int argc, char** argv)
{
    // Initialize the MPI execution environment
    MPI_Init(NULL, NULL);

    int mpicommworld_rank;
    int mpicommworld_size;
    int mpiproc_len;
    char mpiproc_name[MPI_MAX_PROCESSOR_NAME];

    // Determine the size of the group associated with a communicator
    MPI_Comm_size(MPI_COMM_WORLD, &mpicommworld_size);

    // Determines the rank of the calling process in the communicator
    MPI_Comm_rank(MPI_COMM_WORLD, &mpicommworld_rank);

    // Gets the name of the processor
    MPI_Get_processor_name(mpiproc_name, &mpiproc_len);

    printf("mpicommworld_rank:%d mpicommworld_size:%d\n",mpicommworld_rank,mpicommworld_size);

    // Terminates MPI execution environment
    MPI_Finalize();
}
```
