// Copyright (c) 2021 B.Roden
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

// OpenMPI header
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

    // Gets the name of the processor (hostname)
    MPI_Get_processor_name(mpiproc_name, &mpiproc_len);

    printf("mpicommworld_rank:%d mpicommworld_size:%d mpiproc_name(hostname):%s\n", mpicommworld_rank, mpicommworld_size, mpiproc_name);

    // Terminates MPI execution environment
    MPI_Finalize();
}
