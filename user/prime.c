#include "kernel/types.h"
#include "user/user.h"


const uint INT_LEN=sizeof(int);
int read_first_data(const int lpipe[],int *pfirst){
	if(read(lpipe[0],pfirst,INT_LEN)>0){
		printf("prime %d\n",*pfirst);
		return 0;
	}
	return 1;
}

void transmit_data(int lpipe[],int rpipe[],int first){
	int tmp=0;
	while(read(lpipe[0],&tmp,INT_LEN)>0){
		if(tmp%first!=0)
			write(rpipe[1],&tmp,INT_LEN);
	}
	close(lpipe[0]);
	close(rpipe[1]);
}

void primes(int lpipe[])
{
	close(lpipe[1]);
	int p[2];
	pipe(p);
	
	int first_of_left;
	if(read_first_data(lpipe,&first_of_left)==0){
		if(fork()==0)
			primes(p);
		close(p[0]);
		transmit_data(lpipe,p,first_of_left);
		wait(0);
		exit(0);
	}else{
		close(p[1]);
		close(p[0]);
		exit(0);
	}
}
int
main(int argc,char* argv[])
{
	int p[2];
	pipe(p);
	for(int i=2;i<35;++i)
		write(p[1],&i,INT_LEN);
	if(fork()==0)
		primes(p);
	close(p[1]);
	close(p[0]);
	wait(0);
	exit(0);
}
