
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include"kernel/types.h"
#include"user/user.h"

int
main(int argc,char* argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
	char buf = 'P';
   8:	05000793          	li	a5,80
   c:	fef407a3          	sb	a5,-17(s0)
	int c2p[2];
	int p2c[2];
	if(pipe(c2p)==-1||pipe(p2c)==-1)
  10:	fe040513          	addi	a0,s0,-32
  14:	00000097          	auipc	ra,0x0
  18:	410080e7          	jalr	1040(ra) # 424 <pipe>
  1c:	57fd                	li	a5,-1
  1e:	00f50b63          	beq	a0,a5,34 <main+0x34>
  22:	fd840513          	addi	a0,s0,-40
  26:	00000097          	auipc	ra,0x0
  2a:	3fe080e7          	jalr	1022(ra) # 424 <pipe>
  2e:	57fd                	li	a5,-1
  30:	02f51063          	bne	a0,a5,50 <main+0x50>
	{
		fprintf(2,"Pipe Error!\n");
  34:	00001597          	auipc	a1,0x1
  38:	8fc58593          	addi	a1,a1,-1796 # 930 <malloc+0xe6>
  3c:	4509                	li	a0,2
  3e:	00000097          	auipc	ra,0x0
  42:	720080e7          	jalr	1824(ra) # 75e <fprintf>
		exit(1);
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	3cc080e7          	jalr	972(ra) # 414 <exit>
	}
	int pid=fork();
  50:	00000097          	auipc	ra,0x0
  54:	3bc080e7          	jalr	956(ra) # 40c <fork>
	if(pid<0)
  58:	08054063          	bltz	a0,d8 <main+0xd8>
		close(c2p[1]);
		close(p2c[0]);
		close(p2c[1]);
		exit(1);
	}
	else if(pid==0)
  5c:	e561                	bnez	a0,124 <main+0x124>
	{
		close(p2c[1]);
  5e:	fdc42503          	lw	a0,-36(s0)
  62:	00000097          	auipc	ra,0x0
  66:	3da080e7          	jalr	986(ra) # 43c <close>
		close(c2p[0]);
  6a:	fe042503          	lw	a0,-32(s0)
  6e:	00000097          	auipc	ra,0x0
  72:	3ce080e7          	jalr	974(ra) # 43c <close>
		read(p2c[0],&buf,1);
  76:	4605                	li	a2,1
  78:	fef40593          	addi	a1,s0,-17
  7c:	fd842503          	lw	a0,-40(s0)
  80:	00000097          	auipc	ra,0x0
  84:	3ac080e7          	jalr	940(ra) # 42c <read>
		fprintf(1,"%d: received ping\n",getpid());
  88:	00000097          	auipc	ra,0x0
  8c:	40c080e7          	jalr	1036(ra) # 494 <getpid>
  90:	862a                	mv	a2,a0
  92:	00001597          	auipc	a1,0x1
  96:	8be58593          	addi	a1,a1,-1858 # 950 <malloc+0x106>
  9a:	4505                	li	a0,1
  9c:	00000097          	auipc	ra,0x0
  a0:	6c2080e7          	jalr	1730(ra) # 75e <fprintf>
		write(c2p[1],&buf,1);
  a4:	4605                	li	a2,1
  a6:	fef40593          	addi	a1,s0,-17
  aa:	fe442503          	lw	a0,-28(s0)
  ae:	00000097          	auipc	ra,0x0
  b2:	386080e7          	jalr	902(ra) # 434 <write>
		close(p2c[0]);
  b6:	fd842503          	lw	a0,-40(s0)
  ba:	00000097          	auipc	ra,0x0
  be:	382080e7          	jalr	898(ra) # 43c <close>
		close(c2p[1]);
  c2:	fe442503          	lw	a0,-28(s0)
  c6:	00000097          	auipc	ra,0x0
  ca:	376080e7          	jalr	886(ra) # 43c <close>
		exit(0);
  ce:	4501                	li	a0,0
  d0:	00000097          	auipc	ra,0x0
  d4:	344080e7          	jalr	836(ra) # 414 <exit>
		fprintf(2,"Fork Error!\n");
  d8:	00001597          	auipc	a1,0x1
  dc:	86858593          	addi	a1,a1,-1944 # 940 <malloc+0xf6>
  e0:	4509                	li	a0,2
  e2:	00000097          	auipc	ra,0x0
  e6:	67c080e7          	jalr	1660(ra) # 75e <fprintf>
		close(c2p[0]);
  ea:	fe042503          	lw	a0,-32(s0)
  ee:	00000097          	auipc	ra,0x0
  f2:	34e080e7          	jalr	846(ra) # 43c <close>
		close(c2p[1]);
  f6:	fe442503          	lw	a0,-28(s0)
  fa:	00000097          	auipc	ra,0x0
  fe:	342080e7          	jalr	834(ra) # 43c <close>
		close(p2c[0]);
 102:	fd842503          	lw	a0,-40(s0)
 106:	00000097          	auipc	ra,0x0
 10a:	336080e7          	jalr	822(ra) # 43c <close>
		close(p2c[1]);
 10e:	fdc42503          	lw	a0,-36(s0)
 112:	00000097          	auipc	ra,0x0
 116:	32a080e7          	jalr	810(ra) # 43c <close>
		exit(1);
 11a:	4505                	li	a0,1
 11c:	00000097          	auipc	ra,0x0
 120:	2f8080e7          	jalr	760(ra) # 414 <exit>
	}
	else{
		close(c2p[1]);
 124:	fe442503          	lw	a0,-28(s0)
 128:	00000097          	auipc	ra,0x0
 12c:	314080e7          	jalr	788(ra) # 43c <close>
		close(p2c[0]);
 130:	fd842503          	lw	a0,-40(s0)
 134:	00000097          	auipc	ra,0x0
 138:	308080e7          	jalr	776(ra) # 43c <close>
		write(p2c[1],&buf,1);
 13c:	4605                	li	a2,1
 13e:	fef40593          	addi	a1,s0,-17
 142:	fdc42503          	lw	a0,-36(s0)
 146:	00000097          	auipc	ra,0x0
 14a:	2ee080e7          	jalr	750(ra) # 434 <write>
		read(c2p[0],&buf,1);
 14e:	4605                	li	a2,1
 150:	fef40593          	addi	a1,s0,-17
 154:	fe042503          	lw	a0,-32(s0)
 158:	00000097          	auipc	ra,0x0
 15c:	2d4080e7          	jalr	724(ra) # 42c <read>
		fprintf(1,"%d: received pong\n",getpid());
 160:	00000097          	auipc	ra,0x0
 164:	334080e7          	jalr	820(ra) # 494 <getpid>
 168:	862a                	mv	a2,a0
 16a:	00000597          	auipc	a1,0x0
 16e:	7fe58593          	addi	a1,a1,2046 # 968 <malloc+0x11e>
 172:	4505                	li	a0,1
 174:	00000097          	auipc	ra,0x0
 178:	5ea080e7          	jalr	1514(ra) # 75e <fprintf>
		close(p2c[1]);
 17c:	fdc42503          	lw	a0,-36(s0)
 180:	00000097          	auipc	ra,0x0
 184:	2bc080e7          	jalr	700(ra) # 43c <close>
		close(c2p[0]);
 188:	fe042503          	lw	a0,-32(s0)
 18c:	00000097          	auipc	ra,0x0
 190:	2b0080e7          	jalr	688(ra) # 43c <close>
	}
	exit(0);
 194:	4501                	li	a0,0
 196:	00000097          	auipc	ra,0x0
 19a:	27e080e7          	jalr	638(ra) # 414 <exit>

000000000000019e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e422                	sd	s0,8(sp)
 1a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a4:	87aa                	mv	a5,a0
 1a6:	0585                	addi	a1,a1,1
 1a8:	0785                	addi	a5,a5,1
 1aa:	fff5c703          	lbu	a4,-1(a1)
 1ae:	fee78fa3          	sb	a4,-1(a5)
 1b2:	fb75                	bnez	a4,1a6 <strcpy+0x8>
    ;
  return os;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb91                	beqz	a5,1d8 <strcmp+0x1e>
 1c6:	0005c703          	lbu	a4,0(a1)
 1ca:	00f71763          	bne	a4,a5,1d8 <strcmp+0x1e>
    p++, q++;
 1ce:	0505                	addi	a0,a0,1
 1d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	fbe5                	bnez	a5,1c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1d8:	0005c503          	lbu	a0,0(a1)
}
 1dc:	40a7853b          	subw	a0,a5,a0
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <strlen>:

uint
strlen(const char *s)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	cf91                	beqz	a5,20c <strlen+0x26>
 1f2:	0505                	addi	a0,a0,1
 1f4:	87aa                	mv	a5,a0
 1f6:	4685                	li	a3,1
 1f8:	9e89                	subw	a3,a3,a0
 1fa:	00f6853b          	addw	a0,a3,a5
 1fe:	0785                	addi	a5,a5,1
 200:	fff7c703          	lbu	a4,-1(a5)
 204:	fb7d                	bnez	a4,1fa <strlen+0x14>
    ;
  return n;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  for(n = 0; s[n]; n++)
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <strlen+0x20>

0000000000000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 216:	ce09                	beqz	a2,230 <memset+0x20>
 218:	87aa                	mv	a5,a0
 21a:	fff6071b          	addiw	a4,a2,-1
 21e:	1702                	slli	a4,a4,0x20
 220:	9301                	srli	a4,a4,0x20
 222:	0705                	addi	a4,a4,1
 224:	972a                	add	a4,a4,a0
    cdst[i] = c;
 226:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 22a:	0785                	addi	a5,a5,1
 22c:	fee79de3          	bne	a5,a4,226 <memset+0x16>
  }
  return dst;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret

0000000000000236 <strchr>:

char*
strchr(const char *s, char c)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cb99                	beqz	a5,256 <strchr+0x20>
    if(*s == c)
 242:	00f58763          	beq	a1,a5,250 <strchr+0x1a>
  for(; *s; s++)
 246:	0505                	addi	a0,a0,1
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbfd                	bnez	a5,242 <strchr+0xc>
      return (char*)s;
  return 0;
 24e:	4501                	li	a0,0
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret
  return 0;
 256:	4501                	li	a0,0
 258:	bfe5                	j	250 <strchr+0x1a>

000000000000025a <gets>:

char*
gets(char *buf, int max)
{
 25a:	711d                	addi	sp,sp,-96
 25c:	ec86                	sd	ra,88(sp)
 25e:	e8a2                	sd	s0,80(sp)
 260:	e4a6                	sd	s1,72(sp)
 262:	e0ca                	sd	s2,64(sp)
 264:	fc4e                	sd	s3,56(sp)
 266:	f852                	sd	s4,48(sp)
 268:	f456                	sd	s5,40(sp)
 26a:	f05a                	sd	s6,32(sp)
 26c:	ec5e                	sd	s7,24(sp)
 26e:	1080                	addi	s0,sp,96
 270:	8baa                	mv	s7,a0
 272:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 274:	892a                	mv	s2,a0
 276:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 278:	4aa9                	li	s5,10
 27a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 27c:	89a6                	mv	s3,s1
 27e:	2485                	addiw	s1,s1,1
 280:	0344d863          	bge	s1,s4,2b0 <gets+0x56>
    cc = read(0, &c, 1);
 284:	4605                	li	a2,1
 286:	faf40593          	addi	a1,s0,-81
 28a:	4501                	li	a0,0
 28c:	00000097          	auipc	ra,0x0
 290:	1a0080e7          	jalr	416(ra) # 42c <read>
    if(cc < 1)
 294:	00a05e63          	blez	a0,2b0 <gets+0x56>
    buf[i++] = c;
 298:	faf44783          	lbu	a5,-81(s0)
 29c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a0:	01578763          	beq	a5,s5,2ae <gets+0x54>
 2a4:	0905                	addi	s2,s2,1
 2a6:	fd679be3          	bne	a5,s6,27c <gets+0x22>
  for(i=0; i+1 < max; ){
 2aa:	89a6                	mv	s3,s1
 2ac:	a011                	j	2b0 <gets+0x56>
 2ae:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2b0:	99de                	add	s3,s3,s7
 2b2:	00098023          	sb	zero,0(s3)
  return buf;
}
 2b6:	855e                	mv	a0,s7
 2b8:	60e6                	ld	ra,88(sp)
 2ba:	6446                	ld	s0,80(sp)
 2bc:	64a6                	ld	s1,72(sp)
 2be:	6906                	ld	s2,64(sp)
 2c0:	79e2                	ld	s3,56(sp)
 2c2:	7a42                	ld	s4,48(sp)
 2c4:	7aa2                	ld	s5,40(sp)
 2c6:	7b02                	ld	s6,32(sp)
 2c8:	6be2                	ld	s7,24(sp)
 2ca:	6125                	addi	sp,sp,96
 2cc:	8082                	ret

00000000000002ce <stat>:

int
stat(const char *n, struct stat *st)
{
 2ce:	1101                	addi	sp,sp,-32
 2d0:	ec06                	sd	ra,24(sp)
 2d2:	e822                	sd	s0,16(sp)
 2d4:	e426                	sd	s1,8(sp)
 2d6:	e04a                	sd	s2,0(sp)
 2d8:	1000                	addi	s0,sp,32
 2da:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2dc:	4581                	li	a1,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	176080e7          	jalr	374(ra) # 454 <open>
  if(fd < 0)
 2e6:	02054563          	bltz	a0,310 <stat+0x42>
 2ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ec:	85ca                	mv	a1,s2
 2ee:	00000097          	auipc	ra,0x0
 2f2:	17e080e7          	jalr	382(ra) # 46c <fstat>
 2f6:	892a                	mv	s2,a0
  close(fd);
 2f8:	8526                	mv	a0,s1
 2fa:	00000097          	auipc	ra,0x0
 2fe:	142080e7          	jalr	322(ra) # 43c <close>
  return r;
}
 302:	854a                	mv	a0,s2
 304:	60e2                	ld	ra,24(sp)
 306:	6442                	ld	s0,16(sp)
 308:	64a2                	ld	s1,8(sp)
 30a:	6902                	ld	s2,0(sp)
 30c:	6105                	addi	sp,sp,32
 30e:	8082                	ret
    return -1;
 310:	597d                	li	s2,-1
 312:	bfc5                	j	302 <stat+0x34>

0000000000000314 <atoi>:

int
atoi(const char *s)
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31a:	00054603          	lbu	a2,0(a0)
 31e:	fd06079b          	addiw	a5,a2,-48
 322:	0ff7f793          	andi	a5,a5,255
 326:	4725                	li	a4,9
 328:	02f76963          	bltu	a4,a5,35a <atoi+0x46>
 32c:	86aa                	mv	a3,a0
  n = 0;
 32e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 330:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 332:	0685                	addi	a3,a3,1
 334:	0025179b          	slliw	a5,a0,0x2
 338:	9fa9                	addw	a5,a5,a0
 33a:	0017979b          	slliw	a5,a5,0x1
 33e:	9fb1                	addw	a5,a5,a2
 340:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 344:	0006c603          	lbu	a2,0(a3)
 348:	fd06071b          	addiw	a4,a2,-48
 34c:	0ff77713          	andi	a4,a4,255
 350:	fee5f1e3          	bgeu	a1,a4,332 <atoi+0x1e>
  return n;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret
  n = 0;
 35a:	4501                	li	a0,0
 35c:	bfe5                	j	354 <atoi+0x40>

000000000000035e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 35e:	1141                	addi	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 364:	02b57663          	bgeu	a0,a1,390 <memmove+0x32>
    while(n-- > 0)
 368:	02c05163          	blez	a2,38a <memmove+0x2c>
 36c:	fff6079b          	addiw	a5,a2,-1
 370:	1782                	slli	a5,a5,0x20
 372:	9381                	srli	a5,a5,0x20
 374:	0785                	addi	a5,a5,1
 376:	97aa                	add	a5,a5,a0
  dst = vdst;
 378:	872a                	mv	a4,a0
      *dst++ = *src++;
 37a:	0585                	addi	a1,a1,1
 37c:	0705                	addi	a4,a4,1
 37e:	fff5c683          	lbu	a3,-1(a1)
 382:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 386:	fee79ae3          	bne	a5,a4,37a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret
    dst += n;
 390:	00c50733          	add	a4,a0,a2
    src += n;
 394:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 396:	fec05ae3          	blez	a2,38a <memmove+0x2c>
 39a:	fff6079b          	addiw	a5,a2,-1
 39e:	1782                	slli	a5,a5,0x20
 3a0:	9381                	srli	a5,a5,0x20
 3a2:	fff7c793          	not	a5,a5
 3a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3a8:	15fd                	addi	a1,a1,-1
 3aa:	177d                	addi	a4,a4,-1
 3ac:	0005c683          	lbu	a3,0(a1)
 3b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3b4:	fee79ae3          	bne	a5,a4,3a8 <memmove+0x4a>
 3b8:	bfc9                	j	38a <memmove+0x2c>

00000000000003ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ba:	1141                	addi	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c0:	ca05                	beqz	a2,3f0 <memcmp+0x36>
 3c2:	fff6069b          	addiw	a3,a2,-1
 3c6:	1682                	slli	a3,a3,0x20
 3c8:	9281                	srli	a3,a3,0x20
 3ca:	0685                	addi	a3,a3,1
 3cc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3ce:	00054783          	lbu	a5,0(a0)
 3d2:	0005c703          	lbu	a4,0(a1)
 3d6:	00e79863          	bne	a5,a4,3e6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3da:	0505                	addi	a0,a0,1
    p2++;
 3dc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3de:	fed518e3          	bne	a0,a3,3ce <memcmp+0x14>
  }
  return 0;
 3e2:	4501                	li	a0,0
 3e4:	a019                	j	3ea <memcmp+0x30>
      return *p1 - *p2;
 3e6:	40e7853b          	subw	a0,a5,a4
}
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret
  return 0;
 3f0:	4501                	li	a0,0
 3f2:	bfe5                	j	3ea <memcmp+0x30>

00000000000003f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e406                	sd	ra,8(sp)
 3f8:	e022                	sd	s0,0(sp)
 3fa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3fc:	00000097          	auipc	ra,0x0
 400:	f62080e7          	jalr	-158(ra) # 35e <memmove>
}
 404:	60a2                	ld	ra,8(sp)
 406:	6402                	ld	s0,0(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret

000000000000040c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 40c:	4885                	li	a7,1
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <exit>:
.global exit
exit:
 li a7, SYS_exit
 414:	4889                	li	a7,2
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <wait>:
.global wait
wait:
 li a7, SYS_wait
 41c:	488d                	li	a7,3
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 424:	4891                	li	a7,4
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <read>:
.global read
read:
 li a7, SYS_read
 42c:	4895                	li	a7,5
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <write>:
.global write
write:
 li a7, SYS_write
 434:	48c1                	li	a7,16
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <close>:
.global close
close:
 li a7, SYS_close
 43c:	48d5                	li	a7,21
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <kill>:
.global kill
kill:
 li a7, SYS_kill
 444:	4899                	li	a7,6
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <exec>:
.global exec
exec:
 li a7, SYS_exec
 44c:	489d                	li	a7,7
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <open>:
.global open
open:
 li a7, SYS_open
 454:	48bd                	li	a7,15
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 45c:	48c5                	li	a7,17
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 464:	48c9                	li	a7,18
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 46c:	48a1                	li	a7,8
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <link>:
.global link
link:
 li a7, SYS_link
 474:	48cd                	li	a7,19
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 47c:	48d1                	li	a7,20
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 484:	48a5                	li	a7,9
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <dup>:
.global dup
dup:
 li a7, SYS_dup
 48c:	48a9                	li	a7,10
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 494:	48ad                	li	a7,11
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 49c:	48b1                	li	a7,12
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4a4:	48b5                	li	a7,13
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ac:	48b9                	li	a7,14
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b4:	1101                	addi	sp,sp,-32
 4b6:	ec06                	sd	ra,24(sp)
 4b8:	e822                	sd	s0,16(sp)
 4ba:	1000                	addi	s0,sp,32
 4bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c0:	4605                	li	a2,1
 4c2:	fef40593          	addi	a1,s0,-17
 4c6:	00000097          	auipc	ra,0x0
 4ca:	f6e080e7          	jalr	-146(ra) # 434 <write>
}
 4ce:	60e2                	ld	ra,24(sp)
 4d0:	6442                	ld	s0,16(sp)
 4d2:	6105                	addi	sp,sp,32
 4d4:	8082                	ret

00000000000004d6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4d6:	7139                	addi	sp,sp,-64
 4d8:	fc06                	sd	ra,56(sp)
 4da:	f822                	sd	s0,48(sp)
 4dc:	f426                	sd	s1,40(sp)
 4de:	f04a                	sd	s2,32(sp)
 4e0:	ec4e                	sd	s3,24(sp)
 4e2:	0080                	addi	s0,sp,64
 4e4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e6:	c299                	beqz	a3,4ec <printint+0x16>
 4e8:	0805c863          	bltz	a1,578 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ec:	2581                	sext.w	a1,a1
  neg = 0;
 4ee:	4881                	li	a7,0
 4f0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4f4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4f6:	2601                	sext.w	a2,a2
 4f8:	00000517          	auipc	a0,0x0
 4fc:	49050513          	addi	a0,a0,1168 # 988 <digits>
 500:	883a                	mv	a6,a4
 502:	2705                	addiw	a4,a4,1
 504:	02c5f7bb          	remuw	a5,a1,a2
 508:	1782                	slli	a5,a5,0x20
 50a:	9381                	srli	a5,a5,0x20
 50c:	97aa                	add	a5,a5,a0
 50e:	0007c783          	lbu	a5,0(a5)
 512:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 516:	0005879b          	sext.w	a5,a1
 51a:	02c5d5bb          	divuw	a1,a1,a2
 51e:	0685                	addi	a3,a3,1
 520:	fec7f0e3          	bgeu	a5,a2,500 <printint+0x2a>
  if(neg)
 524:	00088b63          	beqz	a7,53a <printint+0x64>
    buf[i++] = '-';
 528:	fd040793          	addi	a5,s0,-48
 52c:	973e                	add	a4,a4,a5
 52e:	02d00793          	li	a5,45
 532:	fef70823          	sb	a5,-16(a4)
 536:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 53a:	02e05863          	blez	a4,56a <printint+0x94>
 53e:	fc040793          	addi	a5,s0,-64
 542:	00e78933          	add	s2,a5,a4
 546:	fff78993          	addi	s3,a5,-1
 54a:	99ba                	add	s3,s3,a4
 54c:	377d                	addiw	a4,a4,-1
 54e:	1702                	slli	a4,a4,0x20
 550:	9301                	srli	a4,a4,0x20
 552:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 556:	fff94583          	lbu	a1,-1(s2)
 55a:	8526                	mv	a0,s1
 55c:	00000097          	auipc	ra,0x0
 560:	f58080e7          	jalr	-168(ra) # 4b4 <putc>
  while(--i >= 0)
 564:	197d                	addi	s2,s2,-1
 566:	ff3918e3          	bne	s2,s3,556 <printint+0x80>
}
 56a:	70e2                	ld	ra,56(sp)
 56c:	7442                	ld	s0,48(sp)
 56e:	74a2                	ld	s1,40(sp)
 570:	7902                	ld	s2,32(sp)
 572:	69e2                	ld	s3,24(sp)
 574:	6121                	addi	sp,sp,64
 576:	8082                	ret
    x = -xx;
 578:	40b005bb          	negw	a1,a1
    neg = 1;
 57c:	4885                	li	a7,1
    x = -xx;
 57e:	bf8d                	j	4f0 <printint+0x1a>

0000000000000580 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 580:	7119                	addi	sp,sp,-128
 582:	fc86                	sd	ra,120(sp)
 584:	f8a2                	sd	s0,112(sp)
 586:	f4a6                	sd	s1,104(sp)
 588:	f0ca                	sd	s2,96(sp)
 58a:	ecce                	sd	s3,88(sp)
 58c:	e8d2                	sd	s4,80(sp)
 58e:	e4d6                	sd	s5,72(sp)
 590:	e0da                	sd	s6,64(sp)
 592:	fc5e                	sd	s7,56(sp)
 594:	f862                	sd	s8,48(sp)
 596:	f466                	sd	s9,40(sp)
 598:	f06a                	sd	s10,32(sp)
 59a:	ec6e                	sd	s11,24(sp)
 59c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 59e:	0005c903          	lbu	s2,0(a1)
 5a2:	18090f63          	beqz	s2,740 <vprintf+0x1c0>
 5a6:	8aaa                	mv	s5,a0
 5a8:	8b32                	mv	s6,a2
 5aa:	00158493          	addi	s1,a1,1
  state = 0;
 5ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b0:	02500a13          	li	s4,37
      if(c == 'd'){
 5b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5b8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5bc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5c0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5c4:	00000b97          	auipc	s7,0x0
 5c8:	3c4b8b93          	addi	s7,s7,964 # 988 <digits>
 5cc:	a839                	j	5ea <vprintf+0x6a>
        putc(fd, c);
 5ce:	85ca                	mv	a1,s2
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	ee2080e7          	jalr	-286(ra) # 4b4 <putc>
 5da:	a019                	j	5e0 <vprintf+0x60>
    } else if(state == '%'){
 5dc:	01498f63          	beq	s3,s4,5fa <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5e0:	0485                	addi	s1,s1,1
 5e2:	fff4c903          	lbu	s2,-1(s1)
 5e6:	14090d63          	beqz	s2,740 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5ea:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5ee:	fe0997e3          	bnez	s3,5dc <vprintf+0x5c>
      if(c == '%'){
 5f2:	fd479ee3          	bne	a5,s4,5ce <vprintf+0x4e>
        state = '%';
 5f6:	89be                	mv	s3,a5
 5f8:	b7e5                	j	5e0 <vprintf+0x60>
      if(c == 'd'){
 5fa:	05878063          	beq	a5,s8,63a <vprintf+0xba>
      } else if(c == 'l') {
 5fe:	05978c63          	beq	a5,s9,656 <vprintf+0xd6>
      } else if(c == 'x') {
 602:	07a78863          	beq	a5,s10,672 <vprintf+0xf2>
      } else if(c == 'p') {
 606:	09b78463          	beq	a5,s11,68e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 60a:	07300713          	li	a4,115
 60e:	0ce78663          	beq	a5,a4,6da <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 612:	06300713          	li	a4,99
 616:	0ee78e63          	beq	a5,a4,712 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 61a:	11478863          	beq	a5,s4,72a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61e:	85d2                	mv	a1,s4
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	e92080e7          	jalr	-366(ra) # 4b4 <putc>
        putc(fd, c);
 62a:	85ca                	mv	a1,s2
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	e86080e7          	jalr	-378(ra) # 4b4 <putc>
      }
      state = 0;
 636:	4981                	li	s3,0
 638:	b765                	j	5e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 63a:	008b0913          	addi	s2,s6,8
 63e:	4685                	li	a3,1
 640:	4629                	li	a2,10
 642:	000b2583          	lw	a1,0(s6)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e8e080e7          	jalr	-370(ra) # 4d6 <printint>
 650:	8b4a                	mv	s6,s2
      state = 0;
 652:	4981                	li	s3,0
 654:	b771                	j	5e0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 656:	008b0913          	addi	s2,s6,8
 65a:	4681                	li	a3,0
 65c:	4629                	li	a2,10
 65e:	000b2583          	lw	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e72080e7          	jalr	-398(ra) # 4d6 <printint>
 66c:	8b4a                	mv	s6,s2
      state = 0;
 66e:	4981                	li	s3,0
 670:	bf85                	j	5e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 672:	008b0913          	addi	s2,s6,8
 676:	4681                	li	a3,0
 678:	4641                	li	a2,16
 67a:	000b2583          	lw	a1,0(s6)
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	e56080e7          	jalr	-426(ra) # 4d6 <printint>
 688:	8b4a                	mv	s6,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bf91                	j	5e0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 68e:	008b0793          	addi	a5,s6,8
 692:	f8f43423          	sd	a5,-120(s0)
 696:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 69a:	03000593          	li	a1,48
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	e14080e7          	jalr	-492(ra) # 4b4 <putc>
  putc(fd, 'x');
 6a8:	85ea                	mv	a1,s10
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e08080e7          	jalr	-504(ra) # 4b4 <putc>
 6b4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b6:	03c9d793          	srli	a5,s3,0x3c
 6ba:	97de                	add	a5,a5,s7
 6bc:	0007c583          	lbu	a1,0(a5)
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	df2080e7          	jalr	-526(ra) # 4b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ca:	0992                	slli	s3,s3,0x4
 6cc:	397d                	addiw	s2,s2,-1
 6ce:	fe0914e3          	bnez	s2,6b6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6d2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b721                	j	5e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 6da:	008b0993          	addi	s3,s6,8
 6de:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6e2:	02090163          	beqz	s2,704 <vprintf+0x184>
        while(*s != 0){
 6e6:	00094583          	lbu	a1,0(s2)
 6ea:	c9a1                	beqz	a1,73a <vprintf+0x1ba>
          putc(fd, *s);
 6ec:	8556                	mv	a0,s5
 6ee:	00000097          	auipc	ra,0x0
 6f2:	dc6080e7          	jalr	-570(ra) # 4b4 <putc>
          s++;
 6f6:	0905                	addi	s2,s2,1
        while(*s != 0){
 6f8:	00094583          	lbu	a1,0(s2)
 6fc:	f9e5                	bnez	a1,6ec <vprintf+0x16c>
        s = va_arg(ap, char*);
 6fe:	8b4e                	mv	s6,s3
      state = 0;
 700:	4981                	li	s3,0
 702:	bdf9                	j	5e0 <vprintf+0x60>
          s = "(null)";
 704:	00000917          	auipc	s2,0x0
 708:	27c90913          	addi	s2,s2,636 # 980 <malloc+0x136>
        while(*s != 0){
 70c:	02800593          	li	a1,40
 710:	bff1                	j	6ec <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 712:	008b0913          	addi	s2,s6,8
 716:	000b4583          	lbu	a1,0(s6)
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	d98080e7          	jalr	-616(ra) # 4b4 <putc>
 724:	8b4a                	mv	s6,s2
      state = 0;
 726:	4981                	li	s3,0
 728:	bd65                	j	5e0 <vprintf+0x60>
        putc(fd, c);
 72a:	85d2                	mv	a1,s4
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	d86080e7          	jalr	-634(ra) # 4b4 <putc>
      state = 0;
 736:	4981                	li	s3,0
 738:	b565                	j	5e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 73a:	8b4e                	mv	s6,s3
      state = 0;
 73c:	4981                	li	s3,0
 73e:	b54d                	j	5e0 <vprintf+0x60>
    }
  }
}
 740:	70e6                	ld	ra,120(sp)
 742:	7446                	ld	s0,112(sp)
 744:	74a6                	ld	s1,104(sp)
 746:	7906                	ld	s2,96(sp)
 748:	69e6                	ld	s3,88(sp)
 74a:	6a46                	ld	s4,80(sp)
 74c:	6aa6                	ld	s5,72(sp)
 74e:	6b06                	ld	s6,64(sp)
 750:	7be2                	ld	s7,56(sp)
 752:	7c42                	ld	s8,48(sp)
 754:	7ca2                	ld	s9,40(sp)
 756:	7d02                	ld	s10,32(sp)
 758:	6de2                	ld	s11,24(sp)
 75a:	6109                	addi	sp,sp,128
 75c:	8082                	ret

000000000000075e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 75e:	715d                	addi	sp,sp,-80
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	addi	s0,sp,32
 766:	e010                	sd	a2,0(s0)
 768:	e414                	sd	a3,8(s0)
 76a:	e818                	sd	a4,16(s0)
 76c:	ec1c                	sd	a5,24(s0)
 76e:	03043023          	sd	a6,32(s0)
 772:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 776:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 77a:	8622                	mv	a2,s0
 77c:	00000097          	auipc	ra,0x0
 780:	e04080e7          	jalr	-508(ra) # 580 <vprintf>
}
 784:	60e2                	ld	ra,24(sp)
 786:	6442                	ld	s0,16(sp)
 788:	6161                	addi	sp,sp,80
 78a:	8082                	ret

000000000000078c <printf>:

void
printf(const char *fmt, ...)
{
 78c:	711d                	addi	sp,sp,-96
 78e:	ec06                	sd	ra,24(sp)
 790:	e822                	sd	s0,16(sp)
 792:	1000                	addi	s0,sp,32
 794:	e40c                	sd	a1,8(s0)
 796:	e810                	sd	a2,16(s0)
 798:	ec14                	sd	a3,24(s0)
 79a:	f018                	sd	a4,32(s0)
 79c:	f41c                	sd	a5,40(s0)
 79e:	03043823          	sd	a6,48(s0)
 7a2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a6:	00840613          	addi	a2,s0,8
 7aa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ae:	85aa                	mv	a1,a0
 7b0:	4505                	li	a0,1
 7b2:	00000097          	auipc	ra,0x0
 7b6:	dce080e7          	jalr	-562(ra) # 580 <vprintf>
}
 7ba:	60e2                	ld	ra,24(sp)
 7bc:	6442                	ld	s0,16(sp)
 7be:	6125                	addi	sp,sp,96
 7c0:	8082                	ret

00000000000007c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c2:	1141                	addi	sp,sp,-16
 7c4:	e422                	sd	s0,8(sp)
 7c6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7cc:	00000797          	auipc	a5,0x0
 7d0:	1d47b783          	ld	a5,468(a5) # 9a0 <freep>
 7d4:	a805                	j	804 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7d6:	4618                	lw	a4,8(a2)
 7d8:	9db9                	addw	a1,a1,a4
 7da:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7de:	6398                	ld	a4,0(a5)
 7e0:	6318                	ld	a4,0(a4)
 7e2:	fee53823          	sd	a4,-16(a0)
 7e6:	a091                	j	82a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7e8:	ff852703          	lw	a4,-8(a0)
 7ec:	9e39                	addw	a2,a2,a4
 7ee:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7f0:	ff053703          	ld	a4,-16(a0)
 7f4:	e398                	sd	a4,0(a5)
 7f6:	a099                	j	83c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f8:	6398                	ld	a4,0(a5)
 7fa:	00e7e463          	bltu	a5,a4,802 <free+0x40>
 7fe:	00e6ea63          	bltu	a3,a4,812 <free+0x50>
{
 802:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 804:	fed7fae3          	bgeu	a5,a3,7f8 <free+0x36>
 808:	6398                	ld	a4,0(a5)
 80a:	00e6e463          	bltu	a3,a4,812 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80e:	fee7eae3          	bltu	a5,a4,802 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 812:	ff852583          	lw	a1,-8(a0)
 816:	6390                	ld	a2,0(a5)
 818:	02059713          	slli	a4,a1,0x20
 81c:	9301                	srli	a4,a4,0x20
 81e:	0712                	slli	a4,a4,0x4
 820:	9736                	add	a4,a4,a3
 822:	fae60ae3          	beq	a2,a4,7d6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 826:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 82a:	4790                	lw	a2,8(a5)
 82c:	02061713          	slli	a4,a2,0x20
 830:	9301                	srli	a4,a4,0x20
 832:	0712                	slli	a4,a4,0x4
 834:	973e                	add	a4,a4,a5
 836:	fae689e3          	beq	a3,a4,7e8 <free+0x26>
  } else
    p->s.ptr = bp;
 83a:	e394                	sd	a3,0(a5)
  freep = p;
 83c:	00000717          	auipc	a4,0x0
 840:	16f73223          	sd	a5,356(a4) # 9a0 <freep>
}
 844:	6422                	ld	s0,8(sp)
 846:	0141                	addi	sp,sp,16
 848:	8082                	ret

000000000000084a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84a:	7139                	addi	sp,sp,-64
 84c:	fc06                	sd	ra,56(sp)
 84e:	f822                	sd	s0,48(sp)
 850:	f426                	sd	s1,40(sp)
 852:	f04a                	sd	s2,32(sp)
 854:	ec4e                	sd	s3,24(sp)
 856:	e852                	sd	s4,16(sp)
 858:	e456                	sd	s5,8(sp)
 85a:	e05a                	sd	s6,0(sp)
 85c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 85e:	02051493          	slli	s1,a0,0x20
 862:	9081                	srli	s1,s1,0x20
 864:	04bd                	addi	s1,s1,15
 866:	8091                	srli	s1,s1,0x4
 868:	0014899b          	addiw	s3,s1,1
 86c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 86e:	00000517          	auipc	a0,0x0
 872:	13253503          	ld	a0,306(a0) # 9a0 <freep>
 876:	c515                	beqz	a0,8a2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 878:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87a:	4798                	lw	a4,8(a5)
 87c:	02977f63          	bgeu	a4,s1,8ba <malloc+0x70>
 880:	8a4e                	mv	s4,s3
 882:	0009871b          	sext.w	a4,s3
 886:	6685                	lui	a3,0x1
 888:	00d77363          	bgeu	a4,a3,88e <malloc+0x44>
 88c:	6a05                	lui	s4,0x1
 88e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 892:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 896:	00000917          	auipc	s2,0x0
 89a:	10a90913          	addi	s2,s2,266 # 9a0 <freep>
  if(p == (char*)-1)
 89e:	5afd                	li	s5,-1
 8a0:	a88d                	j	912 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8a2:	00000797          	auipc	a5,0x0
 8a6:	10678793          	addi	a5,a5,262 # 9a8 <base>
 8aa:	00000717          	auipc	a4,0x0
 8ae:	0ef73b23          	sd	a5,246(a4) # 9a0 <freep>
 8b2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8b8:	b7e1                	j	880 <malloc+0x36>
      if(p->s.size == nunits)
 8ba:	02e48b63          	beq	s1,a4,8f0 <malloc+0xa6>
        p->s.size -= nunits;
 8be:	4137073b          	subw	a4,a4,s3
 8c2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c4:	1702                	slli	a4,a4,0x20
 8c6:	9301                	srli	a4,a4,0x20
 8c8:	0712                	slli	a4,a4,0x4
 8ca:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8cc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d0:	00000717          	auipc	a4,0x0
 8d4:	0ca73823          	sd	a0,208(a4) # 9a0 <freep>
      return (void*)(p + 1);
 8d8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8dc:	70e2                	ld	ra,56(sp)
 8de:	7442                	ld	s0,48(sp)
 8e0:	74a2                	ld	s1,40(sp)
 8e2:	7902                	ld	s2,32(sp)
 8e4:	69e2                	ld	s3,24(sp)
 8e6:	6a42                	ld	s4,16(sp)
 8e8:	6aa2                	ld	s5,8(sp)
 8ea:	6b02                	ld	s6,0(sp)
 8ec:	6121                	addi	sp,sp,64
 8ee:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8f0:	6398                	ld	a4,0(a5)
 8f2:	e118                	sd	a4,0(a0)
 8f4:	bff1                	j	8d0 <malloc+0x86>
  hp->s.size = nu;
 8f6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8fa:	0541                	addi	a0,a0,16
 8fc:	00000097          	auipc	ra,0x0
 900:	ec6080e7          	jalr	-314(ra) # 7c2 <free>
  return freep;
 904:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 908:	d971                	beqz	a0,8dc <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90c:	4798                	lw	a4,8(a5)
 90e:	fa9776e3          	bgeu	a4,s1,8ba <malloc+0x70>
    if(p == freep)
 912:	00093703          	ld	a4,0(s2)
 916:	853e                	mv	a0,a5
 918:	fef719e3          	bne	a4,a5,90a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 91c:	8552                	mv	a0,s4
 91e:	00000097          	auipc	ra,0x0
 922:	b7e080e7          	jalr	-1154(ra) # 49c <sbrk>
  if(p == (char*)-1)
 926:	fd5518e3          	bne	a0,s5,8f6 <malloc+0xac>
        return 0;
 92a:	4501                	li	a0,0
 92c:	bf45                	j	8dc <malloc+0x92>
