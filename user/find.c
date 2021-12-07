#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void
find(char *path,char *pattern)
{
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  if(st.type!=T_DIR)
  {
    fprintf(2,"usage: find <DIRECTORY> <filename>\n");
    return;
  }
  if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    printf("ls: path too long\n");
    return;
  }
  strcpy(buf, path);
  p = buf+strlen(buf);
  *p++ = '/';
  while(read(fd, &de, sizeof(de)) == sizeof(de)){
  if(de.inum == 0){
    continue;
    }
    memmove(p, de.name, DIRSIZ);
    p[DIRSIZ] = 0;
    if(stat(buf, &st) < 0){
      printf("ls: cannot stat %s\n", buf);
      continue;
    }
    if(st.type==T_DIR&&strcmp(p,".")!=0&&strcmp(p,"..")!=0)
    {
      find(buf,pattern);
    }else if(strcmp(pattern,p)==0)
        printf("%s\n",buf);
  }
  close(fd);
}

int
main(int argc, char *argv[])
{
  if(argc != 3){
    fprintf(2,"Parameter is not 3!\n");
    exit(1);
  }
  find(argv[1],argv[2]);
  exit(0);
}
