
user/_prime:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <read_first_data>:
#include "kernel/types.h"
#include "user/user.h"


const uint INT_LEN=sizeof(int);
int read_first_data(const int lpipe[],int *pfirst){
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84ae                	mv	s1,a1
	if(read(lpipe[0],pfirst,INT_LEN)>0){
   c:	4611                	li	a2,4
   e:	4108                	lw	a0,0(a0)
  10:	00000097          	auipc	ra,0x0
  14:	44c080e7          	jalr	1100(ra) # 45c <read>
  18:	00a04863          	bgtz	a0,28 <read_first_data+0x28>
		printf("prime %d\n",*pfirst);
		return 0;
	}
	return 1;
  1c:	4505                	li	a0,1
}
  1e:	60e2                	ld	ra,24(sp)
  20:	6442                	ld	s0,16(sp)
  22:	64a2                	ld	s1,8(sp)
  24:	6105                	addi	sp,sp,32
  26:	8082                	ret
		printf("prime %d\n",*pfirst);
  28:	408c                	lw	a1,0(s1)
  2a:	00001517          	auipc	a0,0x1
  2e:	93650513          	addi	a0,a0,-1738 # 960 <malloc+0xe6>
  32:	00000097          	auipc	ra,0x0
  36:	78a080e7          	jalr	1930(ra) # 7bc <printf>
		return 0;
  3a:	4501                	li	a0,0
  3c:	b7cd                	j	1e <read_first_data+0x1e>

000000000000003e <transmit_data>:

void transmit_data(int lpipe[],int rpipe[],int first){
  3e:	7139                	addi	sp,sp,-64
  40:	fc06                	sd	ra,56(sp)
  42:	f822                	sd	s0,48(sp)
  44:	f426                	sd	s1,40(sp)
  46:	f04a                	sd	s2,32(sp)
  48:	ec4e                	sd	s3,24(sp)
  4a:	0080                	addi	s0,sp,64
  4c:	84aa                	mv	s1,a0
  4e:	89ae                	mv	s3,a1
  50:	8932                	mv	s2,a2
	int tmp=0;
  52:	fc042623          	sw	zero,-52(s0)
	while(read(lpipe[0],&tmp,INT_LEN)>0){
  56:	4611                	li	a2,4
  58:	fcc40593          	addi	a1,s0,-52
  5c:	4088                	lw	a0,0(s1)
  5e:	00000097          	auipc	ra,0x0
  62:	3fe080e7          	jalr	1022(ra) # 45c <read>
  66:	02a05163          	blez	a0,88 <transmit_data+0x4a>
		if(tmp%first!=0)
  6a:	fcc42783          	lw	a5,-52(s0)
  6e:	0327e7bb          	remw	a5,a5,s2
  72:	d3f5                	beqz	a5,56 <transmit_data+0x18>
			write(rpipe[1],&tmp,INT_LEN);
  74:	4611                	li	a2,4
  76:	fcc40593          	addi	a1,s0,-52
  7a:	0049a503          	lw	a0,4(s3)
  7e:	00000097          	auipc	ra,0x0
  82:	3e6080e7          	jalr	998(ra) # 464 <write>
  86:	bfc1                	j	56 <transmit_data+0x18>
	}
	close(lpipe[0]);
  88:	4088                	lw	a0,0(s1)
  8a:	00000097          	auipc	ra,0x0
  8e:	3e2080e7          	jalr	994(ra) # 46c <close>
	close(rpipe[1]);
  92:	0049a503          	lw	a0,4(s3)
  96:	00000097          	auipc	ra,0x0
  9a:	3d6080e7          	jalr	982(ra) # 46c <close>
}
  9e:	70e2                	ld	ra,56(sp)
  a0:	7442                	ld	s0,48(sp)
  a2:	74a2                	ld	s1,40(sp)
  a4:	7902                	ld	s2,32(sp)
  a6:	69e2                	ld	s3,24(sp)
  a8:	6121                	addi	sp,sp,64
  aa:	8082                	ret

00000000000000ac <primes>:

void primes(int lpipe[])
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f406                	sd	ra,40(sp)
  b0:	f022                	sd	s0,32(sp)
  b2:	ec26                	sd	s1,24(sp)
  b4:	1800                	addi	s0,sp,48
  b6:	84aa                	mv	s1,a0
	close(lpipe[1]);
  b8:	4148                	lw	a0,4(a0)
  ba:	00000097          	auipc	ra,0x0
  be:	3b2080e7          	jalr	946(ra) # 46c <close>
	int p[2];
	pipe(p);
  c2:	fd840513          	addi	a0,s0,-40
  c6:	00000097          	auipc	ra,0x0
  ca:	38e080e7          	jalr	910(ra) # 454 <pipe>
	
	int first_of_left;
	if(read_first_data(lpipe,&first_of_left)==0){
  ce:	fd440593          	addi	a1,s0,-44
  d2:	8526                	mv	a0,s1
  d4:	00000097          	auipc	ra,0x0
  d8:	f2c080e7          	jalr	-212(ra) # 0 <read_first_data>
  dc:	e529                	bnez	a0,126 <primes+0x7a>
		if(fork()==0)
  de:	00000097          	auipc	ra,0x0
  e2:	35e080e7          	jalr	862(ra) # 43c <fork>
  e6:	c915                	beqz	a0,11a <primes+0x6e>
			primes(p);
		close(p[0]);
  e8:	fd842503          	lw	a0,-40(s0)
  ec:	00000097          	auipc	ra,0x0
  f0:	380080e7          	jalr	896(ra) # 46c <close>
		transmit_data(lpipe,p,first_of_left);
  f4:	fd442603          	lw	a2,-44(s0)
  f8:	fd840593          	addi	a1,s0,-40
  fc:	8526                	mv	a0,s1
  fe:	00000097          	auipc	ra,0x0
 102:	f40080e7          	jalr	-192(ra) # 3e <transmit_data>
		wait(0);
 106:	4501                	li	a0,0
 108:	00000097          	auipc	ra,0x0
 10c:	344080e7          	jalr	836(ra) # 44c <wait>
		exit(0);
 110:	4501                	li	a0,0
 112:	00000097          	auipc	ra,0x0
 116:	332080e7          	jalr	818(ra) # 444 <exit>
			primes(p);
 11a:	fd840513          	addi	a0,s0,-40
 11e:	00000097          	auipc	ra,0x0
 122:	f8e080e7          	jalr	-114(ra) # ac <primes>
	}else{
		close(p[1]);
 126:	fdc42503          	lw	a0,-36(s0)
 12a:	00000097          	auipc	ra,0x0
 12e:	342080e7          	jalr	834(ra) # 46c <close>
		close(p[0]);
 132:	fd842503          	lw	a0,-40(s0)
 136:	00000097          	auipc	ra,0x0
 13a:	336080e7          	jalr	822(ra) # 46c <close>
		exit(0);
 13e:	4501                	li	a0,0
 140:	00000097          	auipc	ra,0x0
 144:	304080e7          	jalr	772(ra) # 444 <exit>

0000000000000148 <main>:
	}
}
int
main(int argc,char* argv[])
{
 148:	7179                	addi	sp,sp,-48
 14a:	f406                	sd	ra,40(sp)
 14c:	f022                	sd	s0,32(sp)
 14e:	ec26                	sd	s1,24(sp)
 150:	1800                	addi	s0,sp,48
	int p[2];
	pipe(p);
 152:	fd840513          	addi	a0,s0,-40
 156:	00000097          	auipc	ra,0x0
 15a:	2fe080e7          	jalr	766(ra) # 454 <pipe>
	for(int i=2;i<35;++i)
 15e:	4789                	li	a5,2
 160:	fcf42a23          	sw	a5,-44(s0)
 164:	02200493          	li	s1,34
		write(p[1],&i,INT_LEN);
 168:	4611                	li	a2,4
 16a:	fd440593          	addi	a1,s0,-44
 16e:	fdc42503          	lw	a0,-36(s0)
 172:	00000097          	auipc	ra,0x0
 176:	2f2080e7          	jalr	754(ra) # 464 <write>
	for(int i=2;i<35;++i)
 17a:	fd442783          	lw	a5,-44(s0)
 17e:	2785                	addiw	a5,a5,1
 180:	0007871b          	sext.w	a4,a5
 184:	fcf42a23          	sw	a5,-44(s0)
 188:	fee4d0e3          	bge	s1,a4,168 <main+0x20>
	if(fork()==0)
 18c:	00000097          	auipc	ra,0x0
 190:	2b0080e7          	jalr	688(ra) # 43c <fork>
 194:	e519                	bnez	a0,1a2 <main+0x5a>
		primes(p);
 196:	fd840513          	addi	a0,s0,-40
 19a:	00000097          	auipc	ra,0x0
 19e:	f12080e7          	jalr	-238(ra) # ac <primes>
	close(p[1]);
 1a2:	fdc42503          	lw	a0,-36(s0)
 1a6:	00000097          	auipc	ra,0x0
 1aa:	2c6080e7          	jalr	710(ra) # 46c <close>
	close(p[0]);
 1ae:	fd842503          	lw	a0,-40(s0)
 1b2:	00000097          	auipc	ra,0x0
 1b6:	2ba080e7          	jalr	698(ra) # 46c <close>
	wait(0);
 1ba:	4501                	li	a0,0
 1bc:	00000097          	auipc	ra,0x0
 1c0:	290080e7          	jalr	656(ra) # 44c <wait>
	exit(0);
 1c4:	4501                	li	a0,0
 1c6:	00000097          	auipc	ra,0x0
 1ca:	27e080e7          	jalr	638(ra) # 444 <exit>

00000000000001ce <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d4:	87aa                	mv	a5,a0
 1d6:	0585                	addi	a1,a1,1
 1d8:	0785                	addi	a5,a5,1
 1da:	fff5c703          	lbu	a4,-1(a1)
 1de:	fee78fa3          	sb	a4,-1(a5)
 1e2:	fb75                	bnez	a4,1d6 <strcpy+0x8>
    ;
  return os;
}
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	cb91                	beqz	a5,208 <strcmp+0x1e>
 1f6:	0005c703          	lbu	a4,0(a1)
 1fa:	00f71763          	bne	a4,a5,208 <strcmp+0x1e>
    p++, q++;
 1fe:	0505                	addi	a0,a0,1
 200:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 202:	00054783          	lbu	a5,0(a0)
 206:	fbe5                	bnez	a5,1f6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 208:	0005c503          	lbu	a0,0(a1)
}
 20c:	40a7853b          	subw	a0,a5,a0
 210:	6422                	ld	s0,8(sp)
 212:	0141                	addi	sp,sp,16
 214:	8082                	ret

0000000000000216 <strlen>:

uint
strlen(const char *s)
{
 216:	1141                	addi	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 21c:	00054783          	lbu	a5,0(a0)
 220:	cf91                	beqz	a5,23c <strlen+0x26>
 222:	0505                	addi	a0,a0,1
 224:	87aa                	mv	a5,a0
 226:	4685                	li	a3,1
 228:	9e89                	subw	a3,a3,a0
 22a:	00f6853b          	addw	a0,a3,a5
 22e:	0785                	addi	a5,a5,1
 230:	fff7c703          	lbu	a4,-1(a5)
 234:	fb7d                	bnez	a4,22a <strlen+0x14>
    ;
  return n;
}
 236:	6422                	ld	s0,8(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret
  for(n = 0; s[n]; n++)
 23c:	4501                	li	a0,0
 23e:	bfe5                	j	236 <strlen+0x20>

0000000000000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	1141                	addi	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 246:	ce09                	beqz	a2,260 <memset+0x20>
 248:	87aa                	mv	a5,a0
 24a:	fff6071b          	addiw	a4,a2,-1
 24e:	1702                	slli	a4,a4,0x20
 250:	9301                	srli	a4,a4,0x20
 252:	0705                	addi	a4,a4,1
 254:	972a                	add	a4,a4,a0
    cdst[i] = c;
 256:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25a:	0785                	addi	a5,a5,1
 25c:	fee79de3          	bne	a5,a4,256 <memset+0x16>
  }
  return dst;
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret

0000000000000266 <strchr>:

char*
strchr(const char *s, char c)
{
 266:	1141                	addi	sp,sp,-16
 268:	e422                	sd	s0,8(sp)
 26a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 26c:	00054783          	lbu	a5,0(a0)
 270:	cb99                	beqz	a5,286 <strchr+0x20>
    if(*s == c)
 272:	00f58763          	beq	a1,a5,280 <strchr+0x1a>
  for(; *s; s++)
 276:	0505                	addi	a0,a0,1
 278:	00054783          	lbu	a5,0(a0)
 27c:	fbfd                	bnez	a5,272 <strchr+0xc>
      return (char*)s;
  return 0;
 27e:	4501                	li	a0,0
}
 280:	6422                	ld	s0,8(sp)
 282:	0141                	addi	sp,sp,16
 284:	8082                	ret
  return 0;
 286:	4501                	li	a0,0
 288:	bfe5                	j	280 <strchr+0x1a>

000000000000028a <gets>:

char*
gets(char *buf, int max)
{
 28a:	711d                	addi	sp,sp,-96
 28c:	ec86                	sd	ra,88(sp)
 28e:	e8a2                	sd	s0,80(sp)
 290:	e4a6                	sd	s1,72(sp)
 292:	e0ca                	sd	s2,64(sp)
 294:	fc4e                	sd	s3,56(sp)
 296:	f852                	sd	s4,48(sp)
 298:	f456                	sd	s5,40(sp)
 29a:	f05a                	sd	s6,32(sp)
 29c:	ec5e                	sd	s7,24(sp)
 29e:	1080                	addi	s0,sp,96
 2a0:	8baa                	mv	s7,a0
 2a2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a4:	892a                	mv	s2,a0
 2a6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2a8:	4aa9                	li	s5,10
 2aa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ac:	89a6                	mv	s3,s1
 2ae:	2485                	addiw	s1,s1,1
 2b0:	0344d863          	bge	s1,s4,2e0 <gets+0x56>
    cc = read(0, &c, 1);
 2b4:	4605                	li	a2,1
 2b6:	faf40593          	addi	a1,s0,-81
 2ba:	4501                	li	a0,0
 2bc:	00000097          	auipc	ra,0x0
 2c0:	1a0080e7          	jalr	416(ra) # 45c <read>
    if(cc < 1)
 2c4:	00a05e63          	blez	a0,2e0 <gets+0x56>
    buf[i++] = c;
 2c8:	faf44783          	lbu	a5,-81(s0)
 2cc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2d0:	01578763          	beq	a5,s5,2de <gets+0x54>
 2d4:	0905                	addi	s2,s2,1
 2d6:	fd679be3          	bne	a5,s6,2ac <gets+0x22>
  for(i=0; i+1 < max; ){
 2da:	89a6                	mv	s3,s1
 2dc:	a011                	j	2e0 <gets+0x56>
 2de:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2e0:	99de                	add	s3,s3,s7
 2e2:	00098023          	sb	zero,0(s3)
  return buf;
}
 2e6:	855e                	mv	a0,s7
 2e8:	60e6                	ld	ra,88(sp)
 2ea:	6446                	ld	s0,80(sp)
 2ec:	64a6                	ld	s1,72(sp)
 2ee:	6906                	ld	s2,64(sp)
 2f0:	79e2                	ld	s3,56(sp)
 2f2:	7a42                	ld	s4,48(sp)
 2f4:	7aa2                	ld	s5,40(sp)
 2f6:	7b02                	ld	s6,32(sp)
 2f8:	6be2                	ld	s7,24(sp)
 2fa:	6125                	addi	sp,sp,96
 2fc:	8082                	ret

00000000000002fe <stat>:

int
stat(const char *n, struct stat *st)
{
 2fe:	1101                	addi	sp,sp,-32
 300:	ec06                	sd	ra,24(sp)
 302:	e822                	sd	s0,16(sp)
 304:	e426                	sd	s1,8(sp)
 306:	e04a                	sd	s2,0(sp)
 308:	1000                	addi	s0,sp,32
 30a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 30c:	4581                	li	a1,0
 30e:	00000097          	auipc	ra,0x0
 312:	176080e7          	jalr	374(ra) # 484 <open>
  if(fd < 0)
 316:	02054563          	bltz	a0,340 <stat+0x42>
 31a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 31c:	85ca                	mv	a1,s2
 31e:	00000097          	auipc	ra,0x0
 322:	17e080e7          	jalr	382(ra) # 49c <fstat>
 326:	892a                	mv	s2,a0
  close(fd);
 328:	8526                	mv	a0,s1
 32a:	00000097          	auipc	ra,0x0
 32e:	142080e7          	jalr	322(ra) # 46c <close>
  return r;
}
 332:	854a                	mv	a0,s2
 334:	60e2                	ld	ra,24(sp)
 336:	6442                	ld	s0,16(sp)
 338:	64a2                	ld	s1,8(sp)
 33a:	6902                	ld	s2,0(sp)
 33c:	6105                	addi	sp,sp,32
 33e:	8082                	ret
    return -1;
 340:	597d                	li	s2,-1
 342:	bfc5                	j	332 <stat+0x34>

0000000000000344 <atoi>:

int
atoi(const char *s)
{
 344:	1141                	addi	sp,sp,-16
 346:	e422                	sd	s0,8(sp)
 348:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34a:	00054603          	lbu	a2,0(a0)
 34e:	fd06079b          	addiw	a5,a2,-48
 352:	0ff7f793          	andi	a5,a5,255
 356:	4725                	li	a4,9
 358:	02f76963          	bltu	a4,a5,38a <atoi+0x46>
 35c:	86aa                	mv	a3,a0
  n = 0;
 35e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 360:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 362:	0685                	addi	a3,a3,1
 364:	0025179b          	slliw	a5,a0,0x2
 368:	9fa9                	addw	a5,a5,a0
 36a:	0017979b          	slliw	a5,a5,0x1
 36e:	9fb1                	addw	a5,a5,a2
 370:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 374:	0006c603          	lbu	a2,0(a3)
 378:	fd06071b          	addiw	a4,a2,-48
 37c:	0ff77713          	andi	a4,a4,255
 380:	fee5f1e3          	bgeu	a1,a4,362 <atoi+0x1e>
  return n;
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
  n = 0;
 38a:	4501                	li	a0,0
 38c:	bfe5                	j	384 <atoi+0x40>

000000000000038e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 394:	02b57663          	bgeu	a0,a1,3c0 <memmove+0x32>
    while(n-- > 0)
 398:	02c05163          	blez	a2,3ba <memmove+0x2c>
 39c:	fff6079b          	addiw	a5,a2,-1
 3a0:	1782                	slli	a5,a5,0x20
 3a2:	9381                	srli	a5,a5,0x20
 3a4:	0785                	addi	a5,a5,1
 3a6:	97aa                	add	a5,a5,a0
  dst = vdst;
 3a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3aa:	0585                	addi	a1,a1,1
 3ac:	0705                	addi	a4,a4,1
 3ae:	fff5c683          	lbu	a3,-1(a1)
 3b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3b6:	fee79ae3          	bne	a5,a4,3aa <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
    dst += n;
 3c0:	00c50733          	add	a4,a0,a2
    src += n;
 3c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3c6:	fec05ae3          	blez	a2,3ba <memmove+0x2c>
 3ca:	fff6079b          	addiw	a5,a2,-1
 3ce:	1782                	slli	a5,a5,0x20
 3d0:	9381                	srli	a5,a5,0x20
 3d2:	fff7c793          	not	a5,a5
 3d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3d8:	15fd                	addi	a1,a1,-1
 3da:	177d                	addi	a4,a4,-1
 3dc:	0005c683          	lbu	a3,0(a1)
 3e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3e4:	fee79ae3          	bne	a5,a4,3d8 <memmove+0x4a>
 3e8:	bfc9                	j	3ba <memmove+0x2c>

00000000000003ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e422                	sd	s0,8(sp)
 3ee:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3f0:	ca05                	beqz	a2,420 <memcmp+0x36>
 3f2:	fff6069b          	addiw	a3,a2,-1
 3f6:	1682                	slli	a3,a3,0x20
 3f8:	9281                	srli	a3,a3,0x20
 3fa:	0685                	addi	a3,a3,1
 3fc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3fe:	00054783          	lbu	a5,0(a0)
 402:	0005c703          	lbu	a4,0(a1)
 406:	00e79863          	bne	a5,a4,416 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 40a:	0505                	addi	a0,a0,1
    p2++;
 40c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 40e:	fed518e3          	bne	a0,a3,3fe <memcmp+0x14>
  }
  return 0;
 412:	4501                	li	a0,0
 414:	a019                	j	41a <memcmp+0x30>
      return *p1 - *p2;
 416:	40e7853b          	subw	a0,a5,a4
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret
  return 0;
 420:	4501                	li	a0,0
 422:	bfe5                	j	41a <memcmp+0x30>

0000000000000424 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 424:	1141                	addi	sp,sp,-16
 426:	e406                	sd	ra,8(sp)
 428:	e022                	sd	s0,0(sp)
 42a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 42c:	00000097          	auipc	ra,0x0
 430:	f62080e7          	jalr	-158(ra) # 38e <memmove>
}
 434:	60a2                	ld	ra,8(sp)
 436:	6402                	ld	s0,0(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret

000000000000043c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 43c:	4885                	li	a7,1
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <exit>:
.global exit
exit:
 li a7, SYS_exit
 444:	4889                	li	a7,2
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <wait>:
.global wait
wait:
 li a7, SYS_wait
 44c:	488d                	li	a7,3
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 454:	4891                	li	a7,4
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <read>:
.global read
read:
 li a7, SYS_read
 45c:	4895                	li	a7,5
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <write>:
.global write
write:
 li a7, SYS_write
 464:	48c1                	li	a7,16
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <close>:
.global close
close:
 li a7, SYS_close
 46c:	48d5                	li	a7,21
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <kill>:
.global kill
kill:
 li a7, SYS_kill
 474:	4899                	li	a7,6
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <exec>:
.global exec
exec:
 li a7, SYS_exec
 47c:	489d                	li	a7,7
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <open>:
.global open
open:
 li a7, SYS_open
 484:	48bd                	li	a7,15
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 48c:	48c5                	li	a7,17
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 494:	48c9                	li	a7,18
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 49c:	48a1                	li	a7,8
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <link>:
.global link
link:
 li a7, SYS_link
 4a4:	48cd                	li	a7,19
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ac:	48d1                	li	a7,20
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b4:	48a5                	li	a7,9
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 4bc:	48a9                	li	a7,10
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c4:	48ad                	li	a7,11
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4cc:	48b1                	li	a7,12
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d4:	48b5                	li	a7,13
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4dc:	48b9                	li	a7,14
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4e4:	1101                	addi	sp,sp,-32
 4e6:	ec06                	sd	ra,24(sp)
 4e8:	e822                	sd	s0,16(sp)
 4ea:	1000                	addi	s0,sp,32
 4ec:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4f0:	4605                	li	a2,1
 4f2:	fef40593          	addi	a1,s0,-17
 4f6:	00000097          	auipc	ra,0x0
 4fa:	f6e080e7          	jalr	-146(ra) # 464 <write>
}
 4fe:	60e2                	ld	ra,24(sp)
 500:	6442                	ld	s0,16(sp)
 502:	6105                	addi	sp,sp,32
 504:	8082                	ret

0000000000000506 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 506:	7139                	addi	sp,sp,-64
 508:	fc06                	sd	ra,56(sp)
 50a:	f822                	sd	s0,48(sp)
 50c:	f426                	sd	s1,40(sp)
 50e:	f04a                	sd	s2,32(sp)
 510:	ec4e                	sd	s3,24(sp)
 512:	0080                	addi	s0,sp,64
 514:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 516:	c299                	beqz	a3,51c <printint+0x16>
 518:	0805c863          	bltz	a1,5a8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 51c:	2581                	sext.w	a1,a1
  neg = 0;
 51e:	4881                	li	a7,0
 520:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 524:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 526:	2601                	sext.w	a2,a2
 528:	00000517          	auipc	a0,0x0
 52c:	45050513          	addi	a0,a0,1104 # 978 <digits>
 530:	883a                	mv	a6,a4
 532:	2705                	addiw	a4,a4,1
 534:	02c5f7bb          	remuw	a5,a1,a2
 538:	1782                	slli	a5,a5,0x20
 53a:	9381                	srli	a5,a5,0x20
 53c:	97aa                	add	a5,a5,a0
 53e:	0007c783          	lbu	a5,0(a5)
 542:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 546:	0005879b          	sext.w	a5,a1
 54a:	02c5d5bb          	divuw	a1,a1,a2
 54e:	0685                	addi	a3,a3,1
 550:	fec7f0e3          	bgeu	a5,a2,530 <printint+0x2a>
  if(neg)
 554:	00088b63          	beqz	a7,56a <printint+0x64>
    buf[i++] = '-';
 558:	fd040793          	addi	a5,s0,-48
 55c:	973e                	add	a4,a4,a5
 55e:	02d00793          	li	a5,45
 562:	fef70823          	sb	a5,-16(a4)
 566:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 56a:	02e05863          	blez	a4,59a <printint+0x94>
 56e:	fc040793          	addi	a5,s0,-64
 572:	00e78933          	add	s2,a5,a4
 576:	fff78993          	addi	s3,a5,-1
 57a:	99ba                	add	s3,s3,a4
 57c:	377d                	addiw	a4,a4,-1
 57e:	1702                	slli	a4,a4,0x20
 580:	9301                	srli	a4,a4,0x20
 582:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 586:	fff94583          	lbu	a1,-1(s2)
 58a:	8526                	mv	a0,s1
 58c:	00000097          	auipc	ra,0x0
 590:	f58080e7          	jalr	-168(ra) # 4e4 <putc>
  while(--i >= 0)
 594:	197d                	addi	s2,s2,-1
 596:	ff3918e3          	bne	s2,s3,586 <printint+0x80>
}
 59a:	70e2                	ld	ra,56(sp)
 59c:	7442                	ld	s0,48(sp)
 59e:	74a2                	ld	s1,40(sp)
 5a0:	7902                	ld	s2,32(sp)
 5a2:	69e2                	ld	s3,24(sp)
 5a4:	6121                	addi	sp,sp,64
 5a6:	8082                	ret
    x = -xx;
 5a8:	40b005bb          	negw	a1,a1
    neg = 1;
 5ac:	4885                	li	a7,1
    x = -xx;
 5ae:	bf8d                	j	520 <printint+0x1a>

00000000000005b0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b0:	7119                	addi	sp,sp,-128
 5b2:	fc86                	sd	ra,120(sp)
 5b4:	f8a2                	sd	s0,112(sp)
 5b6:	f4a6                	sd	s1,104(sp)
 5b8:	f0ca                	sd	s2,96(sp)
 5ba:	ecce                	sd	s3,88(sp)
 5bc:	e8d2                	sd	s4,80(sp)
 5be:	e4d6                	sd	s5,72(sp)
 5c0:	e0da                	sd	s6,64(sp)
 5c2:	fc5e                	sd	s7,56(sp)
 5c4:	f862                	sd	s8,48(sp)
 5c6:	f466                	sd	s9,40(sp)
 5c8:	f06a                	sd	s10,32(sp)
 5ca:	ec6e                	sd	s11,24(sp)
 5cc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ce:	0005c903          	lbu	s2,0(a1)
 5d2:	18090f63          	beqz	s2,770 <vprintf+0x1c0>
 5d6:	8aaa                	mv	s5,a0
 5d8:	8b32                	mv	s6,a2
 5da:	00158493          	addi	s1,a1,1
  state = 0;
 5de:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5e0:	02500a13          	li	s4,37
      if(c == 'd'){
 5e4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5e8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5ec:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5f0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5f4:	00000b97          	auipc	s7,0x0
 5f8:	384b8b93          	addi	s7,s7,900 # 978 <digits>
 5fc:	a839                	j	61a <vprintf+0x6a>
        putc(fd, c);
 5fe:	85ca                	mv	a1,s2
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	ee2080e7          	jalr	-286(ra) # 4e4 <putc>
 60a:	a019                	j	610 <vprintf+0x60>
    } else if(state == '%'){
 60c:	01498f63          	beq	s3,s4,62a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 610:	0485                	addi	s1,s1,1
 612:	fff4c903          	lbu	s2,-1(s1)
 616:	14090d63          	beqz	s2,770 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 61a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 61e:	fe0997e3          	bnez	s3,60c <vprintf+0x5c>
      if(c == '%'){
 622:	fd479ee3          	bne	a5,s4,5fe <vprintf+0x4e>
        state = '%';
 626:	89be                	mv	s3,a5
 628:	b7e5                	j	610 <vprintf+0x60>
      if(c == 'd'){
 62a:	05878063          	beq	a5,s8,66a <vprintf+0xba>
      } else if(c == 'l') {
 62e:	05978c63          	beq	a5,s9,686 <vprintf+0xd6>
      } else if(c == 'x') {
 632:	07a78863          	beq	a5,s10,6a2 <vprintf+0xf2>
      } else if(c == 'p') {
 636:	09b78463          	beq	a5,s11,6be <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 63a:	07300713          	li	a4,115
 63e:	0ce78663          	beq	a5,a4,70a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 642:	06300713          	li	a4,99
 646:	0ee78e63          	beq	a5,a4,742 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 64a:	11478863          	beq	a5,s4,75a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 64e:	85d2                	mv	a1,s4
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	e92080e7          	jalr	-366(ra) # 4e4 <putc>
        putc(fd, c);
 65a:	85ca                	mv	a1,s2
 65c:	8556                	mv	a0,s5
 65e:	00000097          	auipc	ra,0x0
 662:	e86080e7          	jalr	-378(ra) # 4e4 <putc>
      }
      state = 0;
 666:	4981                	li	s3,0
 668:	b765                	j	610 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 66a:	008b0913          	addi	s2,s6,8
 66e:	4685                	li	a3,1
 670:	4629                	li	a2,10
 672:	000b2583          	lw	a1,0(s6)
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	e8e080e7          	jalr	-370(ra) # 506 <printint>
 680:	8b4a                	mv	s6,s2
      state = 0;
 682:	4981                	li	s3,0
 684:	b771                	j	610 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 686:	008b0913          	addi	s2,s6,8
 68a:	4681                	li	a3,0
 68c:	4629                	li	a2,10
 68e:	000b2583          	lw	a1,0(s6)
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	e72080e7          	jalr	-398(ra) # 506 <printint>
 69c:	8b4a                	mv	s6,s2
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	bf85                	j	610 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6a2:	008b0913          	addi	s2,s6,8
 6a6:	4681                	li	a3,0
 6a8:	4641                	li	a2,16
 6aa:	000b2583          	lw	a1,0(s6)
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e56080e7          	jalr	-426(ra) # 506 <printint>
 6b8:	8b4a                	mv	s6,s2
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bf91                	j	610 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6be:	008b0793          	addi	a5,s6,8
 6c2:	f8f43423          	sd	a5,-120(s0)
 6c6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6ca:	03000593          	li	a1,48
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e14080e7          	jalr	-492(ra) # 4e4 <putc>
  putc(fd, 'x');
 6d8:	85ea                	mv	a1,s10
 6da:	8556                	mv	a0,s5
 6dc:	00000097          	auipc	ra,0x0
 6e0:	e08080e7          	jalr	-504(ra) # 4e4 <putc>
 6e4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e6:	03c9d793          	srli	a5,s3,0x3c
 6ea:	97de                	add	a5,a5,s7
 6ec:	0007c583          	lbu	a1,0(a5)
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	df2080e7          	jalr	-526(ra) # 4e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6fa:	0992                	slli	s3,s3,0x4
 6fc:	397d                	addiw	s2,s2,-1
 6fe:	fe0914e3          	bnez	s2,6e6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 702:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 706:	4981                	li	s3,0
 708:	b721                	j	610 <vprintf+0x60>
        s = va_arg(ap, char*);
 70a:	008b0993          	addi	s3,s6,8
 70e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 712:	02090163          	beqz	s2,734 <vprintf+0x184>
        while(*s != 0){
 716:	00094583          	lbu	a1,0(s2)
 71a:	c9a1                	beqz	a1,76a <vprintf+0x1ba>
          putc(fd, *s);
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	dc6080e7          	jalr	-570(ra) # 4e4 <putc>
          s++;
 726:	0905                	addi	s2,s2,1
        while(*s != 0){
 728:	00094583          	lbu	a1,0(s2)
 72c:	f9e5                	bnez	a1,71c <vprintf+0x16c>
        s = va_arg(ap, char*);
 72e:	8b4e                	mv	s6,s3
      state = 0;
 730:	4981                	li	s3,0
 732:	bdf9                	j	610 <vprintf+0x60>
          s = "(null)";
 734:	00000917          	auipc	s2,0x0
 738:	23c90913          	addi	s2,s2,572 # 970 <malloc+0xf6>
        while(*s != 0){
 73c:	02800593          	li	a1,40
 740:	bff1                	j	71c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 742:	008b0913          	addi	s2,s6,8
 746:	000b4583          	lbu	a1,0(s6)
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	d98080e7          	jalr	-616(ra) # 4e4 <putc>
 754:	8b4a                	mv	s6,s2
      state = 0;
 756:	4981                	li	s3,0
 758:	bd65                	j	610 <vprintf+0x60>
        putc(fd, c);
 75a:	85d2                	mv	a1,s4
 75c:	8556                	mv	a0,s5
 75e:	00000097          	auipc	ra,0x0
 762:	d86080e7          	jalr	-634(ra) # 4e4 <putc>
      state = 0;
 766:	4981                	li	s3,0
 768:	b565                	j	610 <vprintf+0x60>
        s = va_arg(ap, char*);
 76a:	8b4e                	mv	s6,s3
      state = 0;
 76c:	4981                	li	s3,0
 76e:	b54d                	j	610 <vprintf+0x60>
    }
  }
}
 770:	70e6                	ld	ra,120(sp)
 772:	7446                	ld	s0,112(sp)
 774:	74a6                	ld	s1,104(sp)
 776:	7906                	ld	s2,96(sp)
 778:	69e6                	ld	s3,88(sp)
 77a:	6a46                	ld	s4,80(sp)
 77c:	6aa6                	ld	s5,72(sp)
 77e:	6b06                	ld	s6,64(sp)
 780:	7be2                	ld	s7,56(sp)
 782:	7c42                	ld	s8,48(sp)
 784:	7ca2                	ld	s9,40(sp)
 786:	7d02                	ld	s10,32(sp)
 788:	6de2                	ld	s11,24(sp)
 78a:	6109                	addi	sp,sp,128
 78c:	8082                	ret

000000000000078e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 78e:	715d                	addi	sp,sp,-80
 790:	ec06                	sd	ra,24(sp)
 792:	e822                	sd	s0,16(sp)
 794:	1000                	addi	s0,sp,32
 796:	e010                	sd	a2,0(s0)
 798:	e414                	sd	a3,8(s0)
 79a:	e818                	sd	a4,16(s0)
 79c:	ec1c                	sd	a5,24(s0)
 79e:	03043023          	sd	a6,32(s0)
 7a2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7a6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7aa:	8622                	mv	a2,s0
 7ac:	00000097          	auipc	ra,0x0
 7b0:	e04080e7          	jalr	-508(ra) # 5b0 <vprintf>
}
 7b4:	60e2                	ld	ra,24(sp)
 7b6:	6442                	ld	s0,16(sp)
 7b8:	6161                	addi	sp,sp,80
 7ba:	8082                	ret

00000000000007bc <printf>:

void
printf(const char *fmt, ...)
{
 7bc:	711d                	addi	sp,sp,-96
 7be:	ec06                	sd	ra,24(sp)
 7c0:	e822                	sd	s0,16(sp)
 7c2:	1000                	addi	s0,sp,32
 7c4:	e40c                	sd	a1,8(s0)
 7c6:	e810                	sd	a2,16(s0)
 7c8:	ec14                	sd	a3,24(s0)
 7ca:	f018                	sd	a4,32(s0)
 7cc:	f41c                	sd	a5,40(s0)
 7ce:	03043823          	sd	a6,48(s0)
 7d2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7d6:	00840613          	addi	a2,s0,8
 7da:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7de:	85aa                	mv	a1,a0
 7e0:	4505                	li	a0,1
 7e2:	00000097          	auipc	ra,0x0
 7e6:	dce080e7          	jalr	-562(ra) # 5b0 <vprintf>
}
 7ea:	60e2                	ld	ra,24(sp)
 7ec:	6442                	ld	s0,16(sp)
 7ee:	6125                	addi	sp,sp,96
 7f0:	8082                	ret

00000000000007f2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f2:	1141                	addi	sp,sp,-16
 7f4:	e422                	sd	s0,8(sp)
 7f6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7f8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fc:	00000797          	auipc	a5,0x0
 800:	1947b783          	ld	a5,404(a5) # 990 <freep>
 804:	a805                	j	834 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 806:	4618                	lw	a4,8(a2)
 808:	9db9                	addw	a1,a1,a4
 80a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 80e:	6398                	ld	a4,0(a5)
 810:	6318                	ld	a4,0(a4)
 812:	fee53823          	sd	a4,-16(a0)
 816:	a091                	j	85a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 818:	ff852703          	lw	a4,-8(a0)
 81c:	9e39                	addw	a2,a2,a4
 81e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 820:	ff053703          	ld	a4,-16(a0)
 824:	e398                	sd	a4,0(a5)
 826:	a099                	j	86c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 828:	6398                	ld	a4,0(a5)
 82a:	00e7e463          	bltu	a5,a4,832 <free+0x40>
 82e:	00e6ea63          	bltu	a3,a4,842 <free+0x50>
{
 832:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 834:	fed7fae3          	bgeu	a5,a3,828 <free+0x36>
 838:	6398                	ld	a4,0(a5)
 83a:	00e6e463          	bltu	a3,a4,842 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83e:	fee7eae3          	bltu	a5,a4,832 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 842:	ff852583          	lw	a1,-8(a0)
 846:	6390                	ld	a2,0(a5)
 848:	02059713          	slli	a4,a1,0x20
 84c:	9301                	srli	a4,a4,0x20
 84e:	0712                	slli	a4,a4,0x4
 850:	9736                	add	a4,a4,a3
 852:	fae60ae3          	beq	a2,a4,806 <free+0x14>
    bp->s.ptr = p->s.ptr;
 856:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 85a:	4790                	lw	a2,8(a5)
 85c:	02061713          	slli	a4,a2,0x20
 860:	9301                	srli	a4,a4,0x20
 862:	0712                	slli	a4,a4,0x4
 864:	973e                	add	a4,a4,a5
 866:	fae689e3          	beq	a3,a4,818 <free+0x26>
  } else
    p->s.ptr = bp;
 86a:	e394                	sd	a3,0(a5)
  freep = p;
 86c:	00000717          	auipc	a4,0x0
 870:	12f73223          	sd	a5,292(a4) # 990 <freep>
}
 874:	6422                	ld	s0,8(sp)
 876:	0141                	addi	sp,sp,16
 878:	8082                	ret

000000000000087a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 87a:	7139                	addi	sp,sp,-64
 87c:	fc06                	sd	ra,56(sp)
 87e:	f822                	sd	s0,48(sp)
 880:	f426                	sd	s1,40(sp)
 882:	f04a                	sd	s2,32(sp)
 884:	ec4e                	sd	s3,24(sp)
 886:	e852                	sd	s4,16(sp)
 888:	e456                	sd	s5,8(sp)
 88a:	e05a                	sd	s6,0(sp)
 88c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88e:	02051493          	slli	s1,a0,0x20
 892:	9081                	srli	s1,s1,0x20
 894:	04bd                	addi	s1,s1,15
 896:	8091                	srli	s1,s1,0x4
 898:	0014899b          	addiw	s3,s1,1
 89c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 89e:	00000517          	auipc	a0,0x0
 8a2:	0f253503          	ld	a0,242(a0) # 990 <freep>
 8a6:	c515                	beqz	a0,8d2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8aa:	4798                	lw	a4,8(a5)
 8ac:	02977f63          	bgeu	a4,s1,8ea <malloc+0x70>
 8b0:	8a4e                	mv	s4,s3
 8b2:	0009871b          	sext.w	a4,s3
 8b6:	6685                	lui	a3,0x1
 8b8:	00d77363          	bgeu	a4,a3,8be <malloc+0x44>
 8bc:	6a05                	lui	s4,0x1
 8be:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c6:	00000917          	auipc	s2,0x0
 8ca:	0ca90913          	addi	s2,s2,202 # 990 <freep>
  if(p == (char*)-1)
 8ce:	5afd                	li	s5,-1
 8d0:	a88d                	j	942 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8d2:	00000797          	auipc	a5,0x0
 8d6:	0c678793          	addi	a5,a5,198 # 998 <base>
 8da:	00000717          	auipc	a4,0x0
 8de:	0af73b23          	sd	a5,182(a4) # 990 <freep>
 8e2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8e4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8e8:	b7e1                	j	8b0 <malloc+0x36>
      if(p->s.size == nunits)
 8ea:	02e48b63          	beq	s1,a4,920 <malloc+0xa6>
        p->s.size -= nunits;
 8ee:	4137073b          	subw	a4,a4,s3
 8f2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f4:	1702                	slli	a4,a4,0x20
 8f6:	9301                	srli	a4,a4,0x20
 8f8:	0712                	slli	a4,a4,0x4
 8fa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8fc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 900:	00000717          	auipc	a4,0x0
 904:	08a73823          	sd	a0,144(a4) # 990 <freep>
      return (void*)(p + 1);
 908:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 90c:	70e2                	ld	ra,56(sp)
 90e:	7442                	ld	s0,48(sp)
 910:	74a2                	ld	s1,40(sp)
 912:	7902                	ld	s2,32(sp)
 914:	69e2                	ld	s3,24(sp)
 916:	6a42                	ld	s4,16(sp)
 918:	6aa2                	ld	s5,8(sp)
 91a:	6b02                	ld	s6,0(sp)
 91c:	6121                	addi	sp,sp,64
 91e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 920:	6398                	ld	a4,0(a5)
 922:	e118                	sd	a4,0(a0)
 924:	bff1                	j	900 <malloc+0x86>
  hp->s.size = nu;
 926:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 92a:	0541                	addi	a0,a0,16
 92c:	00000097          	auipc	ra,0x0
 930:	ec6080e7          	jalr	-314(ra) # 7f2 <free>
  return freep;
 934:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 938:	d971                	beqz	a0,90c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93c:	4798                	lw	a4,8(a5)
 93e:	fa9776e3          	bgeu	a4,s1,8ea <malloc+0x70>
    if(p == freep)
 942:	00093703          	ld	a4,0(s2)
 946:	853e                	mv	a0,a5
 948:	fef719e3          	bne	a4,a5,93a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 94c:	8552                	mv	a0,s4
 94e:	00000097          	auipc	ra,0x0
 952:	b7e080e7          	jalr	-1154(ra) # 4cc <sbrk>
  if(p == (char*)-1)
 956:	fd5518e3          	bne	a0,s5,926 <malloc+0xac>
        return 0;
 95a:	4501                	li	a0,0
 95c:	bf45                	j	90c <malloc+0x92>
