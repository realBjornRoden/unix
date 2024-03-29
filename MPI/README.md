## Message Passing Interface (MPI) for Massively Parallel (MP) High Performance Computing (HPC)
[MPI Forum](https://www.mpi-forum.org/) is the standardization forum for the [Message Passing Interface (MPI)](https://www.mpi-forum.org/docs/mpi-4.0/mpi40-report.pdf).<br>
[OpenMPI](https://www.open-mpi.org/) project is an open source Message Passing Interface (MPI).<br>
[MPICH](https://www.mpich.org/) is a high-performance and widely portable implementation of the Message Passing Interface (MPI) standard (MPI-1, MPI-2 and MPI-3).<br>

## Installing on macOS (either or)
```
# OpenMPI
$ brew install open-mpi

# MPICH (will require unlinking of open-mpi, if it is installed)
$ brew install mpich
```
## Compiling & linking a program with OpenMPI (hello_mpi.c)
```
$ mpicc -o hello_mpi hello_mpi.c
```
## Running with OpenMPI (the runtime order depends on job scheduler, in this case on a single node)
```
$ mpirun hello_mpi              
mpicommworld_rank:1 mpicommworld_size:6 mpiproc_name(hostname):MacBook.
mpicommworld_rank:0 mpicommworld_size:6 mpiproc_name(hostname):MacBook.
mpicommworld_rank:3 mpicommworld_size:6 mpiproc_name(hostname):MacBook.
mpicommworld_rank:4 mpicommworld_size:6 mpiproc_name(hostname):MacBook.
mpicommworld_rank:5 mpicommworld_size:6 mpiproc_name(hostname):MacBook.
mpicommworld_rank:2 mpicommworld_size:6 mpiproc_name(hostname):MacBook.
```
## Sample MPI multi-threaded programs (hello_mpi.c)
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

    printf("mpicommworld_rank:%d mpicommworld_size:%d mpiproc_name(hostname):%s\n", mpicommworld_rank, mpicommworld_size, mpiproc_name);

    // Terminates MPI execution environment
    MPI_Finalize();
}
```
