#include "mpi.h"
#include <iostream>
#include "string.h"
#include <unistd.h>

using namespace std;
int main (int argc, char *argv[])
{
	int id,numprocs;
	char message[27];
    strcpy(message, "just message" );
    int buff_size = 27; 
	int rank;
    int size;
    int tag = 0;
    MPI_Status status;

    MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);

    // while (true)
    // {
        double start = MPI_Wtime();
        int target_rank = (rank + 1) % size;
        MPI_Send(message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD);
        target_rank = (size + ( rank - 1) ) % size;
        
        MPI_Recv(&message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD, &status);
        double end = MPI_Wtime();
        cout << "Process " << rank  << ". Time: " << end - start << "\n"; 

        if (rank != size -1)
        {
            int target_rank = (rank + 1) % size;
            MPI_Send(message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD);
        }
    // }
    MPI_Finalize();
	return 0;
}