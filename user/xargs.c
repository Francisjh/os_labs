#include"kernel/types.h"
#include"kernel/param.h"

#include"user/user.h"

#define MAX_LEN 512

int
main(int argc,char* argv[])
{
	if(argc-1>=MAXARG){
		fprintf(2,"xargs:too many arguments.\n");
		exit(1);
	}
	char line[MAX_LEN];
	char *p = line;
	char *x_argv[MAXARG];
	
	int i;
	for(i=1;i<argc;++i){
		x_argv[i-1]=argv[i];
	}
	
	int rsz=sizeof(char);
	while(rsz==sizeof(char)){
		int word_begin=0;
		int word_end=0;
		int arg_cnt=i-1;
		for(;;){
			rsz=read(0,p,sizeof(char));
			if(++word_end>=MAX_LEN){
				fprintf(2,"xargs: arguments too long.\n");
				exit(1);
			}
			if(*p==' '||*p=='\n'||rsz!=sizeof(char)){
				*p=0;
				x_argv[arg_cnt++]=&line[word_begin];
				word_begin=word_end;
				if(arg_cnt>=MAXARG){
					fprintf(2,"xargs: too many arguments.\n");
					exit(1);
				}
				if(*p=='\n'||rsz!=sizeof(char)){
					break;
				}
			}
			++p;
		}
		if(fork()==0){
			exec(argv[1],x_argv);
		}
		wait(0);
	}
	exit(0);
}
