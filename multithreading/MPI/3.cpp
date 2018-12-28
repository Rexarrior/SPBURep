#include "mpi.h"
#include <iostream>
#include "string.h"
#include <unistd.h>

using namespace std;

void circle_first(int argc, char *argv[])
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

    while (true)
    {
        double start = MPI_Wtime();
        int target_rank = (rank + 1) % size;
        MPI_Send(message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD);
        target_rank = (size + ( rank - 1) ) % size;
        
        MPI_Recv(&message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD, &status);
        double end = MPI_Wtime();
        cout << "Process " << rank  << ". Time: " << end - start << "\n"; 

        usleep(2000);
    }
    MPI_Finalize();
}


void circle_second(int argc, char *argv[])
{
      int id,numprocs;
	char send_message[27];
	char rec_message[27];
    strcpy(send_message, "just message" );
    int buff_size = 27; 
	int rank;
    int size;
    int tag = 0;
    MPI_Status send_status;
    MPI_Status rec_status;

    MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);

    // while (true)
    {
        double start = MPI_Wtime();
        int target_rank = (rank + 1) % size;
        MPI_Request send_req;
        MPI_Isend(send_message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD, &send_req);
        int source_rank = (size + ( rank - 1) ) % size;
        
        MPI_Request rec_req; 
        MPI_Irecv(&rec_message, buff_size, MPI_CHAR, source_rank, tag, MPI_COMM_WORLD, &rec_req);
        cout << "Process " << rank  << ". Sending and receiving invoked. Waiting." << "\n"; 
        MPI_Wait(&send_req, &send_status);
        cout << "Process " << rank  << ". Sending achived." << "\n"; 
        MPI_Wait(&rec_req, &rec_status);
        cout << "Process " << rank  << ". Receiving achived. Message from " << rec_status.MPI_SOURCE << ". \n"; 
        double end = MPI_Wtime();
        cout << "Process " << rank  << ". Time: " << end - start << "\n"; 

        usleep(2000);
    }
    MPI_Finalize();
}




void master_slave(int argc, char *argv[])
{
    int id,numprocs;
	char message[27];
    strcpy(message, "just message" );
    int buff_size = 27; 
	int rank;
    int size;
    int tag = 0;
    int count = 0;
    MPI_Status status;

    MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);

    while (true)
    {
        if (rank == 0)
        {
            while (true)
            {
                MPI_Recv(&message, buff_size, MPI_CHAR, MPI_ANY_SOURCE, tag, MPI_COMM_WORLD, &status);
                int target_rank = status.MPI_SOURCE;
                cout << "Process " << rank  << ". Message from" << target_rank << " : " << message << "\n"; 

                sprintf(message, "200 ok )." );

                MPI_Send(message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD);
            }
        }
        else
        {
            int target_rank = 0;
            sprintf(message, "hello from %d num %d", rank, count++);

            MPI_Send(message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD);
            MPI_Recv(&message, buff_size, MPI_CHAR, target_rank, tag, MPI_COMM_WORLD, &status);
            cout << "Process " << rank  << ". Message from" << target_rank << " : " << message << "\n"; 

        }
        usleep(2000);
    }
    MPI_Finalize();
}



void all_to_all(int argc, char *argv[])
{
     int id,numprocs;
	char message[27];
    strcpy(message, "just message" );
    int buff_size = 27; 
	int rank;
    int size;
    int tag = 0;
    int count = 0;
    MPI_Status status;

    MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);

    while (true)
    {
        
    

        for (int i = 0; i < size; i++)
        {
            if (i != rank)
            {
                sprintf(message, "hello from %d to %d num %d", rank, i, count++);
                MPI_Send(message, buff_size, MPI_CHAR, i, tag, MPI_COMM_WORLD);
            }
        }
        for (int i = 0; i < size; i++)
        {
            if (i != rank)
            {
                MPI_Recv(&message, buff_size, MPI_CHAR, i, tag, MPI_COMM_WORLD, &status);
                cout << "Process " << rank  << ". Message from " << i << " : " << message << "\n"; 
            }
        }
        usleep(2000);
    }
    MPI_Finalize();
}



int main (int argc, char *argv[])
{
    // circle_first(argc, argv);
    // circle_second(argc, argv);
    // master_slave(argc, argv);
    all_to_all(argc, argv);
    
    // char v; 
    // cout << "Modes:\n c - circle first, sync; \n";
    // cout << "C - circle second, acync; \n";
    // cout << "m - master-slave; \n";
    // cout << "a - all-to-all; \n";
    // cout << "Enter mode:";
    // cin >> v; 

    // switch(v)
    // {
    //     case 'c': 
    //         cout << "c - circle first, sync; \n";
    //     	circle_first(argc, argv);
    //         break;
    //     case 'C':
    //         cout << "C - circle second, acync; \n";
    //     	circle_second(argc, argv);
    //         break;
    //     case 'm':
    //         cout << "m - master-slave; \n";
    //         master_slave(argc, argv);
    //         break;
    //     case 'a':
    //         cout << "a - all-to-all; \n";
    //         all_to_all(argc, argv);
    //         break;
    //     default:
    //         cout << "error: unknown mode\n"; 
    // }
	return 0;
}