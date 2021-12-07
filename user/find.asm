
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "user/user.h"
#include "kernel/fs.h"

void
find(char *path,char *pattern)
{
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	23813823          	sd	s8,560(sp)
  2c:	0500                	addi	s0,sp,640
  2e:	892a                	mv	s2,a0
  30:	89ae                	mv	s3,a1
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  32:	4581                	li	a1,0
  34:	00000097          	auipc	ra,0x0
  38:	4c2080e7          	jalr	1218(ra) # 4f6 <open>
  3c:	06054063          	bltz	a0,9c <find+0x9c>
  40:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  42:	d8840593          	addi	a1,s0,-632
  46:	00000097          	auipc	ra,0x0
  4a:	4c8080e7          	jalr	1224(ra) # 50e <fstat>
  4e:	06054263          	bltz	a0,b2 <find+0xb2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  if(st.type!=T_DIR)
  52:	d9041703          	lh	a4,-624(s0)
  56:	4785                	li	a5,1
  58:	06f70d63          	beq	a4,a5,d2 <find+0xd2>
  {
    fprintf(2,"usage: find <DIRECTORY> <filename>\n");
  5c:	00001597          	auipc	a1,0x1
  60:	9a458593          	addi	a1,a1,-1628 # a00 <malloc+0x114>
  64:	4509                	li	a0,2
  66:	00000097          	auipc	ra,0x0
  6a:	79a080e7          	jalr	1946(ra) # 800 <fprintf>
      find(buf,pattern);
    }else if(strcmp(pattern,p)==0)
        printf("%s\n",buf);
  }
  close(fd);
}
  6e:	27813083          	ld	ra,632(sp)
  72:	27013403          	ld	s0,624(sp)
  76:	26813483          	ld	s1,616(sp)
  7a:	26013903          	ld	s2,608(sp)
  7e:	25813983          	ld	s3,600(sp)
  82:	25013a03          	ld	s4,592(sp)
  86:	24813a83          	ld	s5,584(sp)
  8a:	24013b03          	ld	s6,576(sp)
  8e:	23813b83          	ld	s7,568(sp)
  92:	23013c03          	ld	s8,560(sp)
  96:	28010113          	addi	sp,sp,640
  9a:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
  9c:	864a                	mv	a2,s2
  9e:	00001597          	auipc	a1,0x1
  a2:	93258593          	addi	a1,a1,-1742 # 9d0 <malloc+0xe4>
  a6:	4509                	li	a0,2
  a8:	00000097          	auipc	ra,0x0
  ac:	758080e7          	jalr	1880(ra) # 800 <fprintf>
    return;
  b0:	bf7d                	j	6e <find+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
  b2:	864a                	mv	a2,s2
  b4:	00001597          	auipc	a1,0x1
  b8:	93458593          	addi	a1,a1,-1740 # 9e8 <malloc+0xfc>
  bc:	4509                	li	a0,2
  be:	00000097          	auipc	ra,0x0
  c2:	742080e7          	jalr	1858(ra) # 800 <fprintf>
    close(fd);
  c6:	8526                	mv	a0,s1
  c8:	00000097          	auipc	ra,0x0
  cc:	416080e7          	jalr	1046(ra) # 4de <close>
    return;
  d0:	bf79                	j	6e <find+0x6e>
  if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
  d2:	854a                	mv	a0,s2
  d4:	00000097          	auipc	ra,0x0
  d8:	1b4080e7          	jalr	436(ra) # 288 <strlen>
  dc:	2541                	addiw	a0,a0,16
  de:	20000793          	li	a5,512
  e2:	0aa7ee63          	bltu	a5,a0,19e <find+0x19e>
  strcpy(buf, path);
  e6:	85ca                	mv	a1,s2
  e8:	db040513          	addi	a0,s0,-592
  ec:	00000097          	auipc	ra,0x0
  f0:	154080e7          	jalr	340(ra) # 240 <strcpy>
  p = buf+strlen(buf);
  f4:	db040513          	addi	a0,s0,-592
  f8:	00000097          	auipc	ra,0x0
  fc:	190080e7          	jalr	400(ra) # 288 <strlen>
 100:	02051913          	slli	s2,a0,0x20
 104:	02095913          	srli	s2,s2,0x20
 108:	db040793          	addi	a5,s0,-592
 10c:	993e                	add	s2,s2,a5
  *p++ = '/';
 10e:	00190a13          	addi	s4,s2,1
 112:	02f00793          	li	a5,47
 116:	00f90023          	sb	a5,0(s2)
    if(st.type==T_DIR&&strcmp(p,".")!=0&&strcmp(p,"..")!=0)
 11a:	4a85                	li	s5,1
        printf("%s\n",buf);
 11c:	00001b97          	auipc	s7,0x1
 120:	8c4b8b93          	addi	s7,s7,-1852 # 9e0 <malloc+0xf4>
    if(st.type==T_DIR&&strcmp(p,".")!=0&&strcmp(p,"..")!=0)
 124:	00001b17          	auipc	s6,0x1
 128:	91cb0b13          	addi	s6,s6,-1764 # a40 <malloc+0x154>
 12c:	00001c17          	auipc	s8,0x1
 130:	91cc0c13          	addi	s8,s8,-1764 # a48 <malloc+0x15c>
  while(read(fd, &de, sizeof(de)) == sizeof(de)){
 134:	4641                	li	a2,16
 136:	da040593          	addi	a1,s0,-608
 13a:	8526                	mv	a0,s1
 13c:	00000097          	auipc	ra,0x0
 140:	392080e7          	jalr	914(ra) # 4ce <read>
 144:	47c1                	li	a5,16
 146:	0af51663          	bne	a0,a5,1f2 <find+0x1f2>
  if(de.inum == 0){
 14a:	da045783          	lhu	a5,-608(s0)
 14e:	d3fd                	beqz	a5,134 <find+0x134>
    memmove(p, de.name, DIRSIZ);
 150:	4639                	li	a2,14
 152:	da240593          	addi	a1,s0,-606
 156:	8552                	mv	a0,s4
 158:	00000097          	auipc	ra,0x0
 15c:	2a8080e7          	jalr	680(ra) # 400 <memmove>
    p[DIRSIZ] = 0;
 160:	000907a3          	sb	zero,15(s2)
    if(stat(buf, &st) < 0){
 164:	d8840593          	addi	a1,s0,-632
 168:	db040513          	addi	a0,s0,-592
 16c:	00000097          	auipc	ra,0x0
 170:	204080e7          	jalr	516(ra) # 370 <stat>
 174:	02054e63          	bltz	a0,1b0 <find+0x1b0>
    if(st.type==T_DIR&&strcmp(p,".")!=0&&strcmp(p,"..")!=0)
 178:	d9041783          	lh	a5,-624(s0)
 17c:	05578563          	beq	a5,s5,1c6 <find+0x1c6>
    }else if(strcmp(pattern,p)==0)
 180:	85d2                	mv	a1,s4
 182:	854e                	mv	a0,s3
 184:	00000097          	auipc	ra,0x0
 188:	0d8080e7          	jalr	216(ra) # 25c <strcmp>
 18c:	f545                	bnez	a0,134 <find+0x134>
        printf("%s\n",buf);
 18e:	db040593          	addi	a1,s0,-592
 192:	855e                	mv	a0,s7
 194:	00000097          	auipc	ra,0x0
 198:	69a080e7          	jalr	1690(ra) # 82e <printf>
 19c:	bf61                	j	134 <find+0x134>
    printf("ls: path too long\n");
 19e:	00001517          	auipc	a0,0x1
 1a2:	88a50513          	addi	a0,a0,-1910 # a28 <malloc+0x13c>
 1a6:	00000097          	auipc	ra,0x0
 1aa:	688080e7          	jalr	1672(ra) # 82e <printf>
    return;
 1ae:	b5c1                	j	6e <find+0x6e>
      printf("ls: cannot stat %s\n", buf);
 1b0:	db040593          	addi	a1,s0,-592
 1b4:	00001517          	auipc	a0,0x1
 1b8:	83450513          	addi	a0,a0,-1996 # 9e8 <malloc+0xfc>
 1bc:	00000097          	auipc	ra,0x0
 1c0:	672080e7          	jalr	1650(ra) # 82e <printf>
      continue;
 1c4:	bf85                	j	134 <find+0x134>
    if(st.type==T_DIR&&strcmp(p,".")!=0&&strcmp(p,"..")!=0)
 1c6:	85da                	mv	a1,s6
 1c8:	8552                	mv	a0,s4
 1ca:	00000097          	auipc	ra,0x0
 1ce:	092080e7          	jalr	146(ra) # 25c <strcmp>
 1d2:	d55d                	beqz	a0,180 <find+0x180>
 1d4:	85e2                	mv	a1,s8
 1d6:	8552                	mv	a0,s4
 1d8:	00000097          	auipc	ra,0x0
 1dc:	084080e7          	jalr	132(ra) # 25c <strcmp>
 1e0:	d145                	beqz	a0,180 <find+0x180>
      find(buf,pattern);
 1e2:	85ce                	mv	a1,s3
 1e4:	db040513          	addi	a0,s0,-592
 1e8:	00000097          	auipc	ra,0x0
 1ec:	e18080e7          	jalr	-488(ra) # 0 <find>
 1f0:	b791                	j	134 <find+0x134>
  close(fd);
 1f2:	8526                	mv	a0,s1
 1f4:	00000097          	auipc	ra,0x0
 1f8:	2ea080e7          	jalr	746(ra) # 4de <close>
 1fc:	bd8d                	j	6e <find+0x6e>

00000000000001fe <main>:

int
main(int argc, char *argv[])
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e406                	sd	ra,8(sp)
 202:	e022                	sd	s0,0(sp)
 204:	0800                	addi	s0,sp,16
  if(argc != 3){
 206:	470d                	li	a4,3
 208:	02e50063          	beq	a0,a4,228 <main+0x2a>
    fprintf(2,"Parameter is not 3!\n");
 20c:	00001597          	auipc	a1,0x1
 210:	84458593          	addi	a1,a1,-1980 # a50 <malloc+0x164>
 214:	4509                	li	a0,2
 216:	00000097          	auipc	ra,0x0
 21a:	5ea080e7          	jalr	1514(ra) # 800 <fprintf>
    exit(1);
 21e:	4505                	li	a0,1
 220:	00000097          	auipc	ra,0x0
 224:	296080e7          	jalr	662(ra) # 4b6 <exit>
 228:	87ae                	mv	a5,a1
  }
  find(argv[1],argv[2]);
 22a:	698c                	ld	a1,16(a1)
 22c:	6788                	ld	a0,8(a5)
 22e:	00000097          	auipc	ra,0x0
 232:	dd2080e7          	jalr	-558(ra) # 0 <find>
  exit(0);
 236:	4501                	li	a0,0
 238:	00000097          	auipc	ra,0x0
 23c:	27e080e7          	jalr	638(ra) # 4b6 <exit>

0000000000000240 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 240:	1141                	addi	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 246:	87aa                	mv	a5,a0
 248:	0585                	addi	a1,a1,1
 24a:	0785                	addi	a5,a5,1
 24c:	fff5c703          	lbu	a4,-1(a1)
 250:	fee78fa3          	sb	a4,-1(a5)
 254:	fb75                	bnez	a4,248 <strcpy+0x8>
    ;
  return os;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 262:	00054783          	lbu	a5,0(a0)
 266:	cb91                	beqz	a5,27a <strcmp+0x1e>
 268:	0005c703          	lbu	a4,0(a1)
 26c:	00f71763          	bne	a4,a5,27a <strcmp+0x1e>
    p++, q++;
 270:	0505                	addi	a0,a0,1
 272:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 274:	00054783          	lbu	a5,0(a0)
 278:	fbe5                	bnez	a5,268 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 27a:	0005c503          	lbu	a0,0(a1)
}
 27e:	40a7853b          	subw	a0,a5,a0
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <strlen>:

uint
strlen(const char *s)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 28e:	00054783          	lbu	a5,0(a0)
 292:	cf91                	beqz	a5,2ae <strlen+0x26>
 294:	0505                	addi	a0,a0,1
 296:	87aa                	mv	a5,a0
 298:	4685                	li	a3,1
 29a:	9e89                	subw	a3,a3,a0
 29c:	00f6853b          	addw	a0,a3,a5
 2a0:	0785                	addi	a5,a5,1
 2a2:	fff7c703          	lbu	a4,-1(a5)
 2a6:	fb7d                	bnez	a4,29c <strlen+0x14>
    ;
  return n;
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
  for(n = 0; s[n]; n++)
 2ae:	4501                	li	a0,0
 2b0:	bfe5                	j	2a8 <strlen+0x20>

00000000000002b2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2b8:	ce09                	beqz	a2,2d2 <memset+0x20>
 2ba:	87aa                	mv	a5,a0
 2bc:	fff6071b          	addiw	a4,a2,-1
 2c0:	1702                	slli	a4,a4,0x20
 2c2:	9301                	srli	a4,a4,0x20
 2c4:	0705                	addi	a4,a4,1
 2c6:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2cc:	0785                	addi	a5,a5,1
 2ce:	fee79de3          	bne	a5,a4,2c8 <memset+0x16>
  }
  return dst;
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret

00000000000002d8 <strchr>:

char*
strchr(const char *s, char c)
{
 2d8:	1141                	addi	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	cb99                	beqz	a5,2f8 <strchr+0x20>
    if(*s == c)
 2e4:	00f58763          	beq	a1,a5,2f2 <strchr+0x1a>
  for(; *s; s++)
 2e8:	0505                	addi	a0,a0,1
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	fbfd                	bnez	a5,2e4 <strchr+0xc>
      return (char*)s;
  return 0;
 2f0:	4501                	li	a0,0
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  return 0;
 2f8:	4501                	li	a0,0
 2fa:	bfe5                	j	2f2 <strchr+0x1a>

00000000000002fc <gets>:

char*
gets(char *buf, int max)
{
 2fc:	711d                	addi	sp,sp,-96
 2fe:	ec86                	sd	ra,88(sp)
 300:	e8a2                	sd	s0,80(sp)
 302:	e4a6                	sd	s1,72(sp)
 304:	e0ca                	sd	s2,64(sp)
 306:	fc4e                	sd	s3,56(sp)
 308:	f852                	sd	s4,48(sp)
 30a:	f456                	sd	s5,40(sp)
 30c:	f05a                	sd	s6,32(sp)
 30e:	ec5e                	sd	s7,24(sp)
 310:	1080                	addi	s0,sp,96
 312:	8baa                	mv	s7,a0
 314:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 316:	892a                	mv	s2,a0
 318:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 31a:	4aa9                	li	s5,10
 31c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 31e:	89a6                	mv	s3,s1
 320:	2485                	addiw	s1,s1,1
 322:	0344d863          	bge	s1,s4,352 <gets+0x56>
    cc = read(0, &c, 1);
 326:	4605                	li	a2,1
 328:	faf40593          	addi	a1,s0,-81
 32c:	4501                	li	a0,0
 32e:	00000097          	auipc	ra,0x0
 332:	1a0080e7          	jalr	416(ra) # 4ce <read>
    if(cc < 1)
 336:	00a05e63          	blez	a0,352 <gets+0x56>
    buf[i++] = c;
 33a:	faf44783          	lbu	a5,-81(s0)
 33e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 342:	01578763          	beq	a5,s5,350 <gets+0x54>
 346:	0905                	addi	s2,s2,1
 348:	fd679be3          	bne	a5,s6,31e <gets+0x22>
  for(i=0; i+1 < max; ){
 34c:	89a6                	mv	s3,s1
 34e:	a011                	j	352 <gets+0x56>
 350:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 352:	99de                	add	s3,s3,s7
 354:	00098023          	sb	zero,0(s3)
  return buf;
}
 358:	855e                	mv	a0,s7
 35a:	60e6                	ld	ra,88(sp)
 35c:	6446                	ld	s0,80(sp)
 35e:	64a6                	ld	s1,72(sp)
 360:	6906                	ld	s2,64(sp)
 362:	79e2                	ld	s3,56(sp)
 364:	7a42                	ld	s4,48(sp)
 366:	7aa2                	ld	s5,40(sp)
 368:	7b02                	ld	s6,32(sp)
 36a:	6be2                	ld	s7,24(sp)
 36c:	6125                	addi	sp,sp,96
 36e:	8082                	ret

0000000000000370 <stat>:

int
stat(const char *n, struct stat *st)
{
 370:	1101                	addi	sp,sp,-32
 372:	ec06                	sd	ra,24(sp)
 374:	e822                	sd	s0,16(sp)
 376:	e426                	sd	s1,8(sp)
 378:	e04a                	sd	s2,0(sp)
 37a:	1000                	addi	s0,sp,32
 37c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37e:	4581                	li	a1,0
 380:	00000097          	auipc	ra,0x0
 384:	176080e7          	jalr	374(ra) # 4f6 <open>
  if(fd < 0)
 388:	02054563          	bltz	a0,3b2 <stat+0x42>
 38c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 38e:	85ca                	mv	a1,s2
 390:	00000097          	auipc	ra,0x0
 394:	17e080e7          	jalr	382(ra) # 50e <fstat>
 398:	892a                	mv	s2,a0
  close(fd);
 39a:	8526                	mv	a0,s1
 39c:	00000097          	auipc	ra,0x0
 3a0:	142080e7          	jalr	322(ra) # 4de <close>
  return r;
}
 3a4:	854a                	mv	a0,s2
 3a6:	60e2                	ld	ra,24(sp)
 3a8:	6442                	ld	s0,16(sp)
 3aa:	64a2                	ld	s1,8(sp)
 3ac:	6902                	ld	s2,0(sp)
 3ae:	6105                	addi	sp,sp,32
 3b0:	8082                	ret
    return -1;
 3b2:	597d                	li	s2,-1
 3b4:	bfc5                	j	3a4 <stat+0x34>

00000000000003b6 <atoi>:

int
atoi(const char *s)
{
 3b6:	1141                	addi	sp,sp,-16
 3b8:	e422                	sd	s0,8(sp)
 3ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3bc:	00054603          	lbu	a2,0(a0)
 3c0:	fd06079b          	addiw	a5,a2,-48
 3c4:	0ff7f793          	andi	a5,a5,255
 3c8:	4725                	li	a4,9
 3ca:	02f76963          	bltu	a4,a5,3fc <atoi+0x46>
 3ce:	86aa                	mv	a3,a0
  n = 0;
 3d0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3d2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3d4:	0685                	addi	a3,a3,1
 3d6:	0025179b          	slliw	a5,a0,0x2
 3da:	9fa9                	addw	a5,a5,a0
 3dc:	0017979b          	slliw	a5,a5,0x1
 3e0:	9fb1                	addw	a5,a5,a2
 3e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3e6:	0006c603          	lbu	a2,0(a3)
 3ea:	fd06071b          	addiw	a4,a2,-48
 3ee:	0ff77713          	andi	a4,a4,255
 3f2:	fee5f1e3          	bgeu	a1,a4,3d4 <atoi+0x1e>
  return n;
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret
  n = 0;
 3fc:	4501                	li	a0,0
 3fe:	bfe5                	j	3f6 <atoi+0x40>

0000000000000400 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 406:	02b57663          	bgeu	a0,a1,432 <memmove+0x32>
    while(n-- > 0)
 40a:	02c05163          	blez	a2,42c <memmove+0x2c>
 40e:	fff6079b          	addiw	a5,a2,-1
 412:	1782                	slli	a5,a5,0x20
 414:	9381                	srli	a5,a5,0x20
 416:	0785                	addi	a5,a5,1
 418:	97aa                	add	a5,a5,a0
  dst = vdst;
 41a:	872a                	mv	a4,a0
      *dst++ = *src++;
 41c:	0585                	addi	a1,a1,1
 41e:	0705                	addi	a4,a4,1
 420:	fff5c683          	lbu	a3,-1(a1)
 424:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 428:	fee79ae3          	bne	a5,a4,41c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 42c:	6422                	ld	s0,8(sp)
 42e:	0141                	addi	sp,sp,16
 430:	8082                	ret
    dst += n;
 432:	00c50733          	add	a4,a0,a2
    src += n;
 436:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 438:	fec05ae3          	blez	a2,42c <memmove+0x2c>
 43c:	fff6079b          	addiw	a5,a2,-1
 440:	1782                	slli	a5,a5,0x20
 442:	9381                	srli	a5,a5,0x20
 444:	fff7c793          	not	a5,a5
 448:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 44a:	15fd                	addi	a1,a1,-1
 44c:	177d                	addi	a4,a4,-1
 44e:	0005c683          	lbu	a3,0(a1)
 452:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 456:	fee79ae3          	bne	a5,a4,44a <memmove+0x4a>
 45a:	bfc9                	j	42c <memmove+0x2c>

000000000000045c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 45c:	1141                	addi	sp,sp,-16
 45e:	e422                	sd	s0,8(sp)
 460:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 462:	ca05                	beqz	a2,492 <memcmp+0x36>
 464:	fff6069b          	addiw	a3,a2,-1
 468:	1682                	slli	a3,a3,0x20
 46a:	9281                	srli	a3,a3,0x20
 46c:	0685                	addi	a3,a3,1
 46e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 470:	00054783          	lbu	a5,0(a0)
 474:	0005c703          	lbu	a4,0(a1)
 478:	00e79863          	bne	a5,a4,488 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 47c:	0505                	addi	a0,a0,1
    p2++;
 47e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 480:	fed518e3          	bne	a0,a3,470 <memcmp+0x14>
  }
  return 0;
 484:	4501                	li	a0,0
 486:	a019                	j	48c <memcmp+0x30>
      return *p1 - *p2;
 488:	40e7853b          	subw	a0,a5,a4
}
 48c:	6422                	ld	s0,8(sp)
 48e:	0141                	addi	sp,sp,16
 490:	8082                	ret
  return 0;
 492:	4501                	li	a0,0
 494:	bfe5                	j	48c <memcmp+0x30>

0000000000000496 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 496:	1141                	addi	sp,sp,-16
 498:	e406                	sd	ra,8(sp)
 49a:	e022                	sd	s0,0(sp)
 49c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 49e:	00000097          	auipc	ra,0x0
 4a2:	f62080e7          	jalr	-158(ra) # 400 <memmove>
}
 4a6:	60a2                	ld	ra,8(sp)
 4a8:	6402                	ld	s0,0(sp)
 4aa:	0141                	addi	sp,sp,16
 4ac:	8082                	ret

00000000000004ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4ae:	4885                	li	a7,1
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b6:	4889                	li	a7,2
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <wait>:
.global wait
wait:
 li a7, SYS_wait
 4be:	488d                	li	a7,3
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c6:	4891                	li	a7,4
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <read>:
.global read
read:
 li a7, SYS_read
 4ce:	4895                	li	a7,5
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <write>:
.global write
write:
 li a7, SYS_write
 4d6:	48c1                	li	a7,16
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <close>:
.global close
close:
 li a7, SYS_close
 4de:	48d5                	li	a7,21
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e6:	4899                	li	a7,6
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ee:	489d                	li	a7,7
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <open>:
.global open
open:
 li a7, SYS_open
 4f6:	48bd                	li	a7,15
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4fe:	48c5                	li	a7,17
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 506:	48c9                	li	a7,18
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 50e:	48a1                	li	a7,8
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <link>:
.global link
link:
 li a7, SYS_link
 516:	48cd                	li	a7,19
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 51e:	48d1                	li	a7,20
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 526:	48a5                	li	a7,9
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <dup>:
.global dup
dup:
 li a7, SYS_dup
 52e:	48a9                	li	a7,10
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 536:	48ad                	li	a7,11
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 53e:	48b1                	li	a7,12
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 546:	48b5                	li	a7,13
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 54e:	48b9                	li	a7,14
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 556:	1101                	addi	sp,sp,-32
 558:	ec06                	sd	ra,24(sp)
 55a:	e822                	sd	s0,16(sp)
 55c:	1000                	addi	s0,sp,32
 55e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 562:	4605                	li	a2,1
 564:	fef40593          	addi	a1,s0,-17
 568:	00000097          	auipc	ra,0x0
 56c:	f6e080e7          	jalr	-146(ra) # 4d6 <write>
}
 570:	60e2                	ld	ra,24(sp)
 572:	6442                	ld	s0,16(sp)
 574:	6105                	addi	sp,sp,32
 576:	8082                	ret

0000000000000578 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 578:	7139                	addi	sp,sp,-64
 57a:	fc06                	sd	ra,56(sp)
 57c:	f822                	sd	s0,48(sp)
 57e:	f426                	sd	s1,40(sp)
 580:	f04a                	sd	s2,32(sp)
 582:	ec4e                	sd	s3,24(sp)
 584:	0080                	addi	s0,sp,64
 586:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 588:	c299                	beqz	a3,58e <printint+0x16>
 58a:	0805c863          	bltz	a1,61a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 58e:	2581                	sext.w	a1,a1
  neg = 0;
 590:	4881                	li	a7,0
 592:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 596:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 598:	2601                	sext.w	a2,a2
 59a:	00000517          	auipc	a0,0x0
 59e:	4d650513          	addi	a0,a0,1238 # a70 <digits>
 5a2:	883a                	mv	a6,a4
 5a4:	2705                	addiw	a4,a4,1
 5a6:	02c5f7bb          	remuw	a5,a1,a2
 5aa:	1782                	slli	a5,a5,0x20
 5ac:	9381                	srli	a5,a5,0x20
 5ae:	97aa                	add	a5,a5,a0
 5b0:	0007c783          	lbu	a5,0(a5)
 5b4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5b8:	0005879b          	sext.w	a5,a1
 5bc:	02c5d5bb          	divuw	a1,a1,a2
 5c0:	0685                	addi	a3,a3,1
 5c2:	fec7f0e3          	bgeu	a5,a2,5a2 <printint+0x2a>
  if(neg)
 5c6:	00088b63          	beqz	a7,5dc <printint+0x64>
    buf[i++] = '-';
 5ca:	fd040793          	addi	a5,s0,-48
 5ce:	973e                	add	a4,a4,a5
 5d0:	02d00793          	li	a5,45
 5d4:	fef70823          	sb	a5,-16(a4)
 5d8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5dc:	02e05863          	blez	a4,60c <printint+0x94>
 5e0:	fc040793          	addi	a5,s0,-64
 5e4:	00e78933          	add	s2,a5,a4
 5e8:	fff78993          	addi	s3,a5,-1
 5ec:	99ba                	add	s3,s3,a4
 5ee:	377d                	addiw	a4,a4,-1
 5f0:	1702                	slli	a4,a4,0x20
 5f2:	9301                	srli	a4,a4,0x20
 5f4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5f8:	fff94583          	lbu	a1,-1(s2)
 5fc:	8526                	mv	a0,s1
 5fe:	00000097          	auipc	ra,0x0
 602:	f58080e7          	jalr	-168(ra) # 556 <putc>
  while(--i >= 0)
 606:	197d                	addi	s2,s2,-1
 608:	ff3918e3          	bne	s2,s3,5f8 <printint+0x80>
}
 60c:	70e2                	ld	ra,56(sp)
 60e:	7442                	ld	s0,48(sp)
 610:	74a2                	ld	s1,40(sp)
 612:	7902                	ld	s2,32(sp)
 614:	69e2                	ld	s3,24(sp)
 616:	6121                	addi	sp,sp,64
 618:	8082                	ret
    x = -xx;
 61a:	40b005bb          	negw	a1,a1
    neg = 1;
 61e:	4885                	li	a7,1
    x = -xx;
 620:	bf8d                	j	592 <printint+0x1a>

0000000000000622 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 622:	7119                	addi	sp,sp,-128
 624:	fc86                	sd	ra,120(sp)
 626:	f8a2                	sd	s0,112(sp)
 628:	f4a6                	sd	s1,104(sp)
 62a:	f0ca                	sd	s2,96(sp)
 62c:	ecce                	sd	s3,88(sp)
 62e:	e8d2                	sd	s4,80(sp)
 630:	e4d6                	sd	s5,72(sp)
 632:	e0da                	sd	s6,64(sp)
 634:	fc5e                	sd	s7,56(sp)
 636:	f862                	sd	s8,48(sp)
 638:	f466                	sd	s9,40(sp)
 63a:	f06a                	sd	s10,32(sp)
 63c:	ec6e                	sd	s11,24(sp)
 63e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 640:	0005c903          	lbu	s2,0(a1)
 644:	18090f63          	beqz	s2,7e2 <vprintf+0x1c0>
 648:	8aaa                	mv	s5,a0
 64a:	8b32                	mv	s6,a2
 64c:	00158493          	addi	s1,a1,1
  state = 0;
 650:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 652:	02500a13          	li	s4,37
      if(c == 'd'){
 656:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 65a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 65e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 662:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 666:	00000b97          	auipc	s7,0x0
 66a:	40ab8b93          	addi	s7,s7,1034 # a70 <digits>
 66e:	a839                	j	68c <vprintf+0x6a>
        putc(fd, c);
 670:	85ca                	mv	a1,s2
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	ee2080e7          	jalr	-286(ra) # 556 <putc>
 67c:	a019                	j	682 <vprintf+0x60>
    } else if(state == '%'){
 67e:	01498f63          	beq	s3,s4,69c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 682:	0485                	addi	s1,s1,1
 684:	fff4c903          	lbu	s2,-1(s1)
 688:	14090d63          	beqz	s2,7e2 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 68c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 690:	fe0997e3          	bnez	s3,67e <vprintf+0x5c>
      if(c == '%'){
 694:	fd479ee3          	bne	a5,s4,670 <vprintf+0x4e>
        state = '%';
 698:	89be                	mv	s3,a5
 69a:	b7e5                	j	682 <vprintf+0x60>
      if(c == 'd'){
 69c:	05878063          	beq	a5,s8,6dc <vprintf+0xba>
      } else if(c == 'l') {
 6a0:	05978c63          	beq	a5,s9,6f8 <vprintf+0xd6>
      } else if(c == 'x') {
 6a4:	07a78863          	beq	a5,s10,714 <vprintf+0xf2>
      } else if(c == 'p') {
 6a8:	09b78463          	beq	a5,s11,730 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6ac:	07300713          	li	a4,115
 6b0:	0ce78663          	beq	a5,a4,77c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6b4:	06300713          	li	a4,99
 6b8:	0ee78e63          	beq	a5,a4,7b4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6bc:	11478863          	beq	a5,s4,7cc <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6c0:	85d2                	mv	a1,s4
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	e92080e7          	jalr	-366(ra) # 556 <putc>
        putc(fd, c);
 6cc:	85ca                	mv	a1,s2
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e86080e7          	jalr	-378(ra) # 556 <putc>
      }
      state = 0;
 6d8:	4981                	li	s3,0
 6da:	b765                	j	682 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6dc:	008b0913          	addi	s2,s6,8
 6e0:	4685                	li	a3,1
 6e2:	4629                	li	a2,10
 6e4:	000b2583          	lw	a1,0(s6)
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	e8e080e7          	jalr	-370(ra) # 578 <printint>
 6f2:	8b4a                	mv	s6,s2
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	b771                	j	682 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f8:	008b0913          	addi	s2,s6,8
 6fc:	4681                	li	a3,0
 6fe:	4629                	li	a2,10
 700:	000b2583          	lw	a1,0(s6)
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	e72080e7          	jalr	-398(ra) # 578 <printint>
 70e:	8b4a                	mv	s6,s2
      state = 0;
 710:	4981                	li	s3,0
 712:	bf85                	j	682 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 714:	008b0913          	addi	s2,s6,8
 718:	4681                	li	a3,0
 71a:	4641                	li	a2,16
 71c:	000b2583          	lw	a1,0(s6)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	e56080e7          	jalr	-426(ra) # 578 <printint>
 72a:	8b4a                	mv	s6,s2
      state = 0;
 72c:	4981                	li	s3,0
 72e:	bf91                	j	682 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 730:	008b0793          	addi	a5,s6,8
 734:	f8f43423          	sd	a5,-120(s0)
 738:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 73c:	03000593          	li	a1,48
 740:	8556                	mv	a0,s5
 742:	00000097          	auipc	ra,0x0
 746:	e14080e7          	jalr	-492(ra) # 556 <putc>
  putc(fd, 'x');
 74a:	85ea                	mv	a1,s10
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	e08080e7          	jalr	-504(ra) # 556 <putc>
 756:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 758:	03c9d793          	srli	a5,s3,0x3c
 75c:	97de                	add	a5,a5,s7
 75e:	0007c583          	lbu	a1,0(a5)
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	df2080e7          	jalr	-526(ra) # 556 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76c:	0992                	slli	s3,s3,0x4
 76e:	397d                	addiw	s2,s2,-1
 770:	fe0914e3          	bnez	s2,758 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 774:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 778:	4981                	li	s3,0
 77a:	b721                	j	682 <vprintf+0x60>
        s = va_arg(ap, char*);
 77c:	008b0993          	addi	s3,s6,8
 780:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 784:	02090163          	beqz	s2,7a6 <vprintf+0x184>
        while(*s != 0){
 788:	00094583          	lbu	a1,0(s2)
 78c:	c9a1                	beqz	a1,7dc <vprintf+0x1ba>
          putc(fd, *s);
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	dc6080e7          	jalr	-570(ra) # 556 <putc>
          s++;
 798:	0905                	addi	s2,s2,1
        while(*s != 0){
 79a:	00094583          	lbu	a1,0(s2)
 79e:	f9e5                	bnez	a1,78e <vprintf+0x16c>
        s = va_arg(ap, char*);
 7a0:	8b4e                	mv	s6,s3
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bdf9                	j	682 <vprintf+0x60>
          s = "(null)";
 7a6:	00000917          	auipc	s2,0x0
 7aa:	2c290913          	addi	s2,s2,706 # a68 <malloc+0x17c>
        while(*s != 0){
 7ae:	02800593          	li	a1,40
 7b2:	bff1                	j	78e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7b4:	008b0913          	addi	s2,s6,8
 7b8:	000b4583          	lbu	a1,0(s6)
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	d98080e7          	jalr	-616(ra) # 556 <putc>
 7c6:	8b4a                	mv	s6,s2
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	bd65                	j	682 <vprintf+0x60>
        putc(fd, c);
 7cc:	85d2                	mv	a1,s4
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	d86080e7          	jalr	-634(ra) # 556 <putc>
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	b565                	j	682 <vprintf+0x60>
        s = va_arg(ap, char*);
 7dc:	8b4e                	mv	s6,s3
      state = 0;
 7de:	4981                	li	s3,0
 7e0:	b54d                	j	682 <vprintf+0x60>
    }
  }
}
 7e2:	70e6                	ld	ra,120(sp)
 7e4:	7446                	ld	s0,112(sp)
 7e6:	74a6                	ld	s1,104(sp)
 7e8:	7906                	ld	s2,96(sp)
 7ea:	69e6                	ld	s3,88(sp)
 7ec:	6a46                	ld	s4,80(sp)
 7ee:	6aa6                	ld	s5,72(sp)
 7f0:	6b06                	ld	s6,64(sp)
 7f2:	7be2                	ld	s7,56(sp)
 7f4:	7c42                	ld	s8,48(sp)
 7f6:	7ca2                	ld	s9,40(sp)
 7f8:	7d02                	ld	s10,32(sp)
 7fa:	6de2                	ld	s11,24(sp)
 7fc:	6109                	addi	sp,sp,128
 7fe:	8082                	ret

0000000000000800 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 800:	715d                	addi	sp,sp,-80
 802:	ec06                	sd	ra,24(sp)
 804:	e822                	sd	s0,16(sp)
 806:	1000                	addi	s0,sp,32
 808:	e010                	sd	a2,0(s0)
 80a:	e414                	sd	a3,8(s0)
 80c:	e818                	sd	a4,16(s0)
 80e:	ec1c                	sd	a5,24(s0)
 810:	03043023          	sd	a6,32(s0)
 814:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 818:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 81c:	8622                	mv	a2,s0
 81e:	00000097          	auipc	ra,0x0
 822:	e04080e7          	jalr	-508(ra) # 622 <vprintf>
}
 826:	60e2                	ld	ra,24(sp)
 828:	6442                	ld	s0,16(sp)
 82a:	6161                	addi	sp,sp,80
 82c:	8082                	ret

000000000000082e <printf>:

void
printf(const char *fmt, ...)
{
 82e:	711d                	addi	sp,sp,-96
 830:	ec06                	sd	ra,24(sp)
 832:	e822                	sd	s0,16(sp)
 834:	1000                	addi	s0,sp,32
 836:	e40c                	sd	a1,8(s0)
 838:	e810                	sd	a2,16(s0)
 83a:	ec14                	sd	a3,24(s0)
 83c:	f018                	sd	a4,32(s0)
 83e:	f41c                	sd	a5,40(s0)
 840:	03043823          	sd	a6,48(s0)
 844:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 848:	00840613          	addi	a2,s0,8
 84c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 850:	85aa                	mv	a1,a0
 852:	4505                	li	a0,1
 854:	00000097          	auipc	ra,0x0
 858:	dce080e7          	jalr	-562(ra) # 622 <vprintf>
}
 85c:	60e2                	ld	ra,24(sp)
 85e:	6442                	ld	s0,16(sp)
 860:	6125                	addi	sp,sp,96
 862:	8082                	ret

0000000000000864 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 864:	1141                	addi	sp,sp,-16
 866:	e422                	sd	s0,8(sp)
 868:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 86a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86e:	00000797          	auipc	a5,0x0
 872:	21a7b783          	ld	a5,538(a5) # a88 <freep>
 876:	a805                	j	8a6 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 878:	4618                	lw	a4,8(a2)
 87a:	9db9                	addw	a1,a1,a4
 87c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 880:	6398                	ld	a4,0(a5)
 882:	6318                	ld	a4,0(a4)
 884:	fee53823          	sd	a4,-16(a0)
 888:	a091                	j	8cc <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 88a:	ff852703          	lw	a4,-8(a0)
 88e:	9e39                	addw	a2,a2,a4
 890:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 892:	ff053703          	ld	a4,-16(a0)
 896:	e398                	sd	a4,0(a5)
 898:	a099                	j	8de <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89a:	6398                	ld	a4,0(a5)
 89c:	00e7e463          	bltu	a5,a4,8a4 <free+0x40>
 8a0:	00e6ea63          	bltu	a3,a4,8b4 <free+0x50>
{
 8a4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	fed7fae3          	bgeu	a5,a3,89a <free+0x36>
 8aa:	6398                	ld	a4,0(a5)
 8ac:	00e6e463          	bltu	a3,a4,8b4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	fee7eae3          	bltu	a5,a4,8a4 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8b4:	ff852583          	lw	a1,-8(a0)
 8b8:	6390                	ld	a2,0(a5)
 8ba:	02059713          	slli	a4,a1,0x20
 8be:	9301                	srli	a4,a4,0x20
 8c0:	0712                	slli	a4,a4,0x4
 8c2:	9736                	add	a4,a4,a3
 8c4:	fae60ae3          	beq	a2,a4,878 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8c8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8cc:	4790                	lw	a2,8(a5)
 8ce:	02061713          	slli	a4,a2,0x20
 8d2:	9301                	srli	a4,a4,0x20
 8d4:	0712                	slli	a4,a4,0x4
 8d6:	973e                	add	a4,a4,a5
 8d8:	fae689e3          	beq	a3,a4,88a <free+0x26>
  } else
    p->s.ptr = bp;
 8dc:	e394                	sd	a3,0(a5)
  freep = p;
 8de:	00000717          	auipc	a4,0x0
 8e2:	1af73523          	sd	a5,426(a4) # a88 <freep>
}
 8e6:	6422                	ld	s0,8(sp)
 8e8:	0141                	addi	sp,sp,16
 8ea:	8082                	ret

00000000000008ec <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ec:	7139                	addi	sp,sp,-64
 8ee:	fc06                	sd	ra,56(sp)
 8f0:	f822                	sd	s0,48(sp)
 8f2:	f426                	sd	s1,40(sp)
 8f4:	f04a                	sd	s2,32(sp)
 8f6:	ec4e                	sd	s3,24(sp)
 8f8:	e852                	sd	s4,16(sp)
 8fa:	e456                	sd	s5,8(sp)
 8fc:	e05a                	sd	s6,0(sp)
 8fe:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 900:	02051493          	slli	s1,a0,0x20
 904:	9081                	srli	s1,s1,0x20
 906:	04bd                	addi	s1,s1,15
 908:	8091                	srli	s1,s1,0x4
 90a:	0014899b          	addiw	s3,s1,1
 90e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 910:	00000517          	auipc	a0,0x0
 914:	17853503          	ld	a0,376(a0) # a88 <freep>
 918:	c515                	beqz	a0,944 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91c:	4798                	lw	a4,8(a5)
 91e:	02977f63          	bgeu	a4,s1,95c <malloc+0x70>
 922:	8a4e                	mv	s4,s3
 924:	0009871b          	sext.w	a4,s3
 928:	6685                	lui	a3,0x1
 92a:	00d77363          	bgeu	a4,a3,930 <malloc+0x44>
 92e:	6a05                	lui	s4,0x1
 930:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 934:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 938:	00000917          	auipc	s2,0x0
 93c:	15090913          	addi	s2,s2,336 # a88 <freep>
  if(p == (char*)-1)
 940:	5afd                	li	s5,-1
 942:	a88d                	j	9b4 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 944:	00000797          	auipc	a5,0x0
 948:	14c78793          	addi	a5,a5,332 # a90 <base>
 94c:	00000717          	auipc	a4,0x0
 950:	12f73e23          	sd	a5,316(a4) # a88 <freep>
 954:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 956:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 95a:	b7e1                	j	922 <malloc+0x36>
      if(p->s.size == nunits)
 95c:	02e48b63          	beq	s1,a4,992 <malloc+0xa6>
        p->s.size -= nunits;
 960:	4137073b          	subw	a4,a4,s3
 964:	c798                	sw	a4,8(a5)
        p += p->s.size;
 966:	1702                	slli	a4,a4,0x20
 968:	9301                	srli	a4,a4,0x20
 96a:	0712                	slli	a4,a4,0x4
 96c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 972:	00000717          	auipc	a4,0x0
 976:	10a73b23          	sd	a0,278(a4) # a88 <freep>
      return (void*)(p + 1);
 97a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 97e:	70e2                	ld	ra,56(sp)
 980:	7442                	ld	s0,48(sp)
 982:	74a2                	ld	s1,40(sp)
 984:	7902                	ld	s2,32(sp)
 986:	69e2                	ld	s3,24(sp)
 988:	6a42                	ld	s4,16(sp)
 98a:	6aa2                	ld	s5,8(sp)
 98c:	6b02                	ld	s6,0(sp)
 98e:	6121                	addi	sp,sp,64
 990:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 992:	6398                	ld	a4,0(a5)
 994:	e118                	sd	a4,0(a0)
 996:	bff1                	j	972 <malloc+0x86>
  hp->s.size = nu;
 998:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 99c:	0541                	addi	a0,a0,16
 99e:	00000097          	auipc	ra,0x0
 9a2:	ec6080e7          	jalr	-314(ra) # 864 <free>
  return freep;
 9a6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9aa:	d971                	beqz	a0,97e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ae:	4798                	lw	a4,8(a5)
 9b0:	fa9776e3          	bgeu	a4,s1,95c <malloc+0x70>
    if(p == freep)
 9b4:	00093703          	ld	a4,0(s2)
 9b8:	853e                	mv	a0,a5
 9ba:	fef719e3          	bne	a4,a5,9ac <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9be:	8552                	mv	a0,s4
 9c0:	00000097          	auipc	ra,0x0
 9c4:	b7e080e7          	jalr	-1154(ra) # 53e <sbrk>
  if(p == (char*)-1)
 9c8:	fd5518e3          	bne	a0,s5,998 <malloc+0xac>
        return 0;
 9cc:	4501                	li	a0,0
 9ce:	bf45                	j	97e <malloc+0x92>
