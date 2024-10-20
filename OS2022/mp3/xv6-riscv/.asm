
user/_thrdtest4:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thrdstop_handler_resume_main_id>:

int main_id = -1;
int second_id = -1;

void thrdstop_handler_resume_main_id(void *arg)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	fca43c23          	sd	a0,-40(s0)
    printf("%d\n", main_id);
       c:	00002797          	auipc	a5,0x2
      10:	0fc78793          	addi	a5,a5,252 # 2108 <main_id>
      14:	439c                	lw	a5,0(a5)
      16:	85be                	mv	a1,a5
      18:	00002517          	auipc	a0,0x2
      1c:	f4850513          	addi	a0,a0,-184 # 1f60 <schedule_rm+0x2b0>
      20:	00001097          	auipc	ra,0x1
      24:	b64080e7          	jalr	-1180(ra) # b84 <printf>
    thrdresume(main_id); // jump to line 23
      28:	00002797          	auipc	a5,0x2
      2c:	0e078793          	addi	a5,a5,224 # 2108 <main_id>
      30:	439c                	lw	a5,0(a5)
      32:	853e                	mv	a0,a5
      34:	00000097          	auipc	ra,0x0
      38:	6b2080e7          	jalr	1714(ra) # 6e6 <thrdresume>
    int *v = (int *)arg;
      3c:	fd843783          	ld	a5,-40(s0)
      40:	fef43423          	sd	a5,-24(s0)
    ++v; // not executed
      44:	fe843783          	ld	a5,-24(s0)
      48:	0791                	addi	a5,a5,4
      4a:	fef43423          	sd	a5,-24(s0)
}
      4e:	0001                	nop
      50:	70a2                	ld	ra,40(sp)
      52:	7402                	ld	s0,32(sp)
      54:	6145                	addi	sp,sp,48
      56:	8082                	ret

0000000000000058 <test_multi_context>:

int test_multi_context()
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    static int v1 = 0, v2 = 0;

    thrdstop(100, &main_id, thrdstop_handler_resume_main_id, (void *)NULL);
      60:	4681                	li	a3,0
      62:	00000617          	auipc	a2,0x0
      66:	f9e60613          	addi	a2,a2,-98 # 0 <thrdstop_handler_resume_main_id>
      6a:	00002597          	auipc	a1,0x2
      6e:	09e58593          	addi	a1,a1,158 # 2108 <main_id>
      72:	06400513          	li	a0,100
      76:	00000097          	auipc	ra,0x0
      7a:	668080e7          	jalr	1640(ra) # 6de <thrdstop>
    cancelthrdstop(main_id, 0);
      7e:	00002797          	auipc	a5,0x2
      82:	08a78793          	addi	a5,a5,138 # 2108 <main_id>
      86:	439c                	lw	a5,0(a5)
      88:	4581                	li	a1,0
      8a:	853e                	mv	a0,a5
      8c:	00000097          	auipc	ra,0x0
      90:	662080e7          	jalr	1634(ra) # 6ee <cancelthrdstop>

    if (v2 == 77)
      94:	00002797          	auipc	a5,0x2
      98:	08478793          	addi	a5,a5,132 # 2118 <v2.1>
      9c:	439c                	lw	a5,0(a5)
      9e:	873e                	mv	a4,a5
      a0:	04d00793          	li	a5,77
      a4:	02f71363          	bne	a4,a5,ca <test_multi_context+0x72>
    {
        v1 = 210;
      a8:	00002797          	auipc	a5,0x2
      ac:	07478793          	addi	a5,a5,116 # 211c <v1.0>
      b0:	0d200713          	li	a4,210
      b4:	c398                	sw	a4,0(a5)
        thrdresume(second_id); // jump to the while loop below
      b6:	00002797          	auipc	a5,0x2
      ba:	05678793          	addi	a5,a5,86 # 210c <second_id>
      be:	439c                	lw	a5,0(a5)
      c0:	853e                	mv	a0,a5
      c2:	00000097          	auipc	ra,0x0
      c6:	624080e7          	jalr	1572(ra) # 6e6 <thrdresume>
    }

    v2 += 77;
      ca:	00002797          	auipc	a5,0x2
      ce:	04e78793          	addi	a5,a5,78 # 2118 <v2.1>
      d2:	439c                	lw	a5,0(a5)
      d4:	04d7879b          	addiw	a5,a5,77
      d8:	0007871b          	sext.w	a4,a5
      dc:	00002797          	auipc	a5,0x2
      e0:	03c78793          	addi	a5,a5,60 # 2118 <v2.1>
      e4:	c398                	sw	a4,0(a5)
    thrdstop(5, &second_id, thrdstop_handler_resume_main_id, (void *)&v1);
      e6:	00002697          	auipc	a3,0x2
      ea:	03668693          	addi	a3,a3,54 # 211c <v1.0>
      ee:	00000617          	auipc	a2,0x0
      f2:	f1260613          	addi	a2,a2,-238 # 0 <thrdstop_handler_resume_main_id>
      f6:	00002597          	auipc	a1,0x2
      fa:	01658593          	addi	a1,a1,22 # 210c <second_id>
      fe:	4515                	li	a0,5
     100:	00000097          	auipc	ra,0x0
     104:	5de080e7          	jalr	1502(ra) # 6de <thrdstop>
    while (v1 == 0)
     108:	0001                	nop
     10a:	00002797          	auipc	a5,0x2
     10e:	01278793          	addi	a5,a5,18 # 211c <v1.0>
     112:	439c                	lw	a5,0(a5)
     114:	dbfd                	beqz	a5,10a <test_multi_context+0xb2>
    {
        // wait for the handler
    }

    return v1 != 210 || v2 != 77;
     116:	00002797          	auipc	a5,0x2
     11a:	00678793          	addi	a5,a5,6 # 211c <v1.0>
     11e:	439c                	lw	a5,0(a5)
     120:	873e                	mv	a4,a5
     122:	0d200793          	li	a5,210
     126:	00f71c63          	bne	a4,a5,13e <test_multi_context+0xe6>
     12a:	00002797          	auipc	a5,0x2
     12e:	fee78793          	addi	a5,a5,-18 # 2118 <v2.1>
     132:	439c                	lw	a5,0(a5)
     134:	873e                	mv	a4,a5
     136:	04d00793          	li	a5,77
     13a:	00f70463          	beq	a4,a5,142 <test_multi_context+0xea>
     13e:	4785                	li	a5,1
     140:	a011                	j	144 <test_multi_context+0xec>
     142:	4781                	li	a5,0
}
     144:	853e                	mv	a0,a5
     146:	60a2                	ld	ra,8(sp)
     148:	6402                	ld	s0,0(sp)
     14a:	0141                	addi	sp,sp,16
     14c:	8082                	ret

000000000000014e <main>:

int main(int argc, char **argv)
{
     14e:	7179                	addi	sp,sp,-48
     150:	f406                	sd	ra,40(sp)
     152:	f022                	sd	s0,32(sp)
     154:	1800                	addi	s0,sp,48
     156:	87aa                	mv	a5,a0
     158:	fcb43823          	sd	a1,-48(s0)
     15c:	fcf42e23          	sw	a5,-36(s0)
    int result = test_multi_context();
     160:	00000097          	auipc	ra,0x0
     164:	ef8080e7          	jalr	-264(ra) # 58 <test_multi_context>
     168:	87aa                	mv	a5,a0
     16a:	fef42623          	sw	a5,-20(s0)
    fprintf(2, "[%s] %s\n", result ? "FAILED" : "OK", "test_multi_context");
     16e:	fec42783          	lw	a5,-20(s0)
     172:	2781                	sext.w	a5,a5
     174:	c791                	beqz	a5,180 <main+0x32>
     176:	00002797          	auipc	a5,0x2
     17a:	df278793          	addi	a5,a5,-526 # 1f68 <schedule_rm+0x2b8>
     17e:	a029                	j	188 <main+0x3a>
     180:	00002797          	auipc	a5,0x2
     184:	df078793          	addi	a5,a5,-528 # 1f70 <schedule_rm+0x2c0>
     188:	00002697          	auipc	a3,0x2
     18c:	df068693          	addi	a3,a3,-528 # 1f78 <schedule_rm+0x2c8>
     190:	863e                	mv	a2,a5
     192:	00002597          	auipc	a1,0x2
     196:	dfe58593          	addi	a1,a1,-514 # 1f90 <schedule_rm+0x2e0>
     19a:	4509                	li	a0,2
     19c:	00001097          	auipc	ra,0x1
     1a0:	990080e7          	jalr	-1648(ra) # b2c <fprintf>

    exit(0);
     1a4:	4501                	li	a0,0
     1a6:	00000097          	auipc	ra,0x0
     1aa:	498080e7          	jalr	1176(ra) # 63e <exit>

00000000000001ae <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     1ae:	7179                	addi	sp,sp,-48
     1b0:	f422                	sd	s0,40(sp)
     1b2:	1800                	addi	s0,sp,48
     1b4:	fca43c23          	sd	a0,-40(s0)
     1b8:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     1bc:	fd843783          	ld	a5,-40(s0)
     1c0:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     1c4:	0001                	nop
     1c6:	fd043703          	ld	a4,-48(s0)
     1ca:	00170793          	addi	a5,a4,1
     1ce:	fcf43823          	sd	a5,-48(s0)
     1d2:	fd843783          	ld	a5,-40(s0)
     1d6:	00178693          	addi	a3,a5,1
     1da:	fcd43c23          	sd	a3,-40(s0)
     1de:	00074703          	lbu	a4,0(a4)
     1e2:	00e78023          	sb	a4,0(a5)
     1e6:	0007c783          	lbu	a5,0(a5)
     1ea:	fff1                	bnez	a5,1c6 <strcpy+0x18>
    ;
  return os;
     1ec:	fe843783          	ld	a5,-24(s0)
}
     1f0:	853e                	mv	a0,a5
     1f2:	7422                	ld	s0,40(sp)
     1f4:	6145                	addi	sp,sp,48
     1f6:	8082                	ret

00000000000001f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1f8:	1101                	addi	sp,sp,-32
     1fa:	ec22                	sd	s0,24(sp)
     1fc:	1000                	addi	s0,sp,32
     1fe:	fea43423          	sd	a0,-24(s0)
     202:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     206:	a819                	j	21c <strcmp+0x24>
    p++, q++;
     208:	fe843783          	ld	a5,-24(s0)
     20c:	0785                	addi	a5,a5,1
     20e:	fef43423          	sd	a5,-24(s0)
     212:	fe043783          	ld	a5,-32(s0)
     216:	0785                	addi	a5,a5,1
     218:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     21c:	fe843783          	ld	a5,-24(s0)
     220:	0007c783          	lbu	a5,0(a5)
     224:	cb99                	beqz	a5,23a <strcmp+0x42>
     226:	fe843783          	ld	a5,-24(s0)
     22a:	0007c703          	lbu	a4,0(a5)
     22e:	fe043783          	ld	a5,-32(s0)
     232:	0007c783          	lbu	a5,0(a5)
     236:	fcf709e3          	beq	a4,a5,208 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     23a:	fe843783          	ld	a5,-24(s0)
     23e:	0007c783          	lbu	a5,0(a5)
     242:	0007871b          	sext.w	a4,a5
     246:	fe043783          	ld	a5,-32(s0)
     24a:	0007c783          	lbu	a5,0(a5)
     24e:	2781                	sext.w	a5,a5
     250:	40f707bb          	subw	a5,a4,a5
     254:	2781                	sext.w	a5,a5
}
     256:	853e                	mv	a0,a5
     258:	6462                	ld	s0,24(sp)
     25a:	6105                	addi	sp,sp,32
     25c:	8082                	ret

000000000000025e <strlen>:

uint
strlen(const char *s)
{
     25e:	7179                	addi	sp,sp,-48
     260:	f422                	sd	s0,40(sp)
     262:	1800                	addi	s0,sp,48
     264:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     268:	fe042623          	sw	zero,-20(s0)
     26c:	a031                	j	278 <strlen+0x1a>
     26e:	fec42783          	lw	a5,-20(s0)
     272:	2785                	addiw	a5,a5,1
     274:	fef42623          	sw	a5,-20(s0)
     278:	fec42783          	lw	a5,-20(s0)
     27c:	fd843703          	ld	a4,-40(s0)
     280:	97ba                	add	a5,a5,a4
     282:	0007c783          	lbu	a5,0(a5)
     286:	f7e5                	bnez	a5,26e <strlen+0x10>
    ;
  return n;
     288:	fec42783          	lw	a5,-20(s0)
}
     28c:	853e                	mv	a0,a5
     28e:	7422                	ld	s0,40(sp)
     290:	6145                	addi	sp,sp,48
     292:	8082                	ret

0000000000000294 <memset>:

void*
memset(void *dst, int c, uint n)
{
     294:	7179                	addi	sp,sp,-48
     296:	f422                	sd	s0,40(sp)
     298:	1800                	addi	s0,sp,48
     29a:	fca43c23          	sd	a0,-40(s0)
     29e:	87ae                	mv	a5,a1
     2a0:	8732                	mv	a4,a2
     2a2:	fcf42a23          	sw	a5,-44(s0)
     2a6:	87ba                	mv	a5,a4
     2a8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     2ac:	fd843783          	ld	a5,-40(s0)
     2b0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     2b4:	fe042623          	sw	zero,-20(s0)
     2b8:	a00d                	j	2da <memset+0x46>
    cdst[i] = c;
     2ba:	fec42783          	lw	a5,-20(s0)
     2be:	fe043703          	ld	a4,-32(s0)
     2c2:	97ba                	add	a5,a5,a4
     2c4:	fd442703          	lw	a4,-44(s0)
     2c8:	0ff77713          	andi	a4,a4,255
     2cc:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2d0:	fec42783          	lw	a5,-20(s0)
     2d4:	2785                	addiw	a5,a5,1
     2d6:	fef42623          	sw	a5,-20(s0)
     2da:	fec42703          	lw	a4,-20(s0)
     2de:	fd042783          	lw	a5,-48(s0)
     2e2:	2781                	sext.w	a5,a5
     2e4:	fcf76be3          	bltu	a4,a5,2ba <memset+0x26>
  }
  return dst;
     2e8:	fd843783          	ld	a5,-40(s0)
}
     2ec:	853e                	mv	a0,a5
     2ee:	7422                	ld	s0,40(sp)
     2f0:	6145                	addi	sp,sp,48
     2f2:	8082                	ret

00000000000002f4 <strchr>:

char*
strchr(const char *s, char c)
{
     2f4:	1101                	addi	sp,sp,-32
     2f6:	ec22                	sd	s0,24(sp)
     2f8:	1000                	addi	s0,sp,32
     2fa:	fea43423          	sd	a0,-24(s0)
     2fe:	87ae                	mv	a5,a1
     300:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     304:	a01d                	j	32a <strchr+0x36>
    if(*s == c)
     306:	fe843783          	ld	a5,-24(s0)
     30a:	0007c703          	lbu	a4,0(a5)
     30e:	fe744783          	lbu	a5,-25(s0)
     312:	0ff7f793          	andi	a5,a5,255
     316:	00e79563          	bne	a5,a4,320 <strchr+0x2c>
      return (char*)s;
     31a:	fe843783          	ld	a5,-24(s0)
     31e:	a821                	j	336 <strchr+0x42>
  for(; *s; s++)
     320:	fe843783          	ld	a5,-24(s0)
     324:	0785                	addi	a5,a5,1
     326:	fef43423          	sd	a5,-24(s0)
     32a:	fe843783          	ld	a5,-24(s0)
     32e:	0007c783          	lbu	a5,0(a5)
     332:	fbf1                	bnez	a5,306 <strchr+0x12>
  return 0;
     334:	4781                	li	a5,0
}
     336:	853e                	mv	a0,a5
     338:	6462                	ld	s0,24(sp)
     33a:	6105                	addi	sp,sp,32
     33c:	8082                	ret

000000000000033e <gets>:

char*
gets(char *buf, int max)
{
     33e:	7179                	addi	sp,sp,-48
     340:	f406                	sd	ra,40(sp)
     342:	f022                	sd	s0,32(sp)
     344:	1800                	addi	s0,sp,48
     346:	fca43c23          	sd	a0,-40(s0)
     34a:	87ae                	mv	a5,a1
     34c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     350:	fe042623          	sw	zero,-20(s0)
     354:	a8a1                	j	3ac <gets+0x6e>
    cc = read(0, &c, 1);
     356:	fe740793          	addi	a5,s0,-25
     35a:	4605                	li	a2,1
     35c:	85be                	mv	a1,a5
     35e:	4501                	li	a0,0
     360:	00000097          	auipc	ra,0x0
     364:	2f6080e7          	jalr	758(ra) # 656 <read>
     368:	87aa                	mv	a5,a0
     36a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     36e:	fe842783          	lw	a5,-24(s0)
     372:	2781                	sext.w	a5,a5
     374:	04f05763          	blez	a5,3c2 <gets+0x84>
      break;
    buf[i++] = c;
     378:	fec42783          	lw	a5,-20(s0)
     37c:	0017871b          	addiw	a4,a5,1
     380:	fee42623          	sw	a4,-20(s0)
     384:	873e                	mv	a4,a5
     386:	fd843783          	ld	a5,-40(s0)
     38a:	97ba                	add	a5,a5,a4
     38c:	fe744703          	lbu	a4,-25(s0)
     390:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     394:	fe744783          	lbu	a5,-25(s0)
     398:	873e                	mv	a4,a5
     39a:	47a9                	li	a5,10
     39c:	02f70463          	beq	a4,a5,3c4 <gets+0x86>
     3a0:	fe744783          	lbu	a5,-25(s0)
     3a4:	873e                	mv	a4,a5
     3a6:	47b5                	li	a5,13
     3a8:	00f70e63          	beq	a4,a5,3c4 <gets+0x86>
  for(i=0; i+1 < max; ){
     3ac:	fec42783          	lw	a5,-20(s0)
     3b0:	2785                	addiw	a5,a5,1
     3b2:	0007871b          	sext.w	a4,a5
     3b6:	fd442783          	lw	a5,-44(s0)
     3ba:	2781                	sext.w	a5,a5
     3bc:	f8f74de3          	blt	a4,a5,356 <gets+0x18>
     3c0:	a011                	j	3c4 <gets+0x86>
      break;
     3c2:	0001                	nop
      break;
  }
  buf[i] = '\0';
     3c4:	fec42783          	lw	a5,-20(s0)
     3c8:	fd843703          	ld	a4,-40(s0)
     3cc:	97ba                	add	a5,a5,a4
     3ce:	00078023          	sb	zero,0(a5)
  return buf;
     3d2:	fd843783          	ld	a5,-40(s0)
}
     3d6:	853e                	mv	a0,a5
     3d8:	70a2                	ld	ra,40(sp)
     3da:	7402                	ld	s0,32(sp)
     3dc:	6145                	addi	sp,sp,48
     3de:	8082                	ret

00000000000003e0 <stat>:

int
stat(const char *n, struct stat *st)
{
     3e0:	7179                	addi	sp,sp,-48
     3e2:	f406                	sd	ra,40(sp)
     3e4:	f022                	sd	s0,32(sp)
     3e6:	1800                	addi	s0,sp,48
     3e8:	fca43c23          	sd	a0,-40(s0)
     3ec:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3f0:	4581                	li	a1,0
     3f2:	fd843503          	ld	a0,-40(s0)
     3f6:	00000097          	auipc	ra,0x0
     3fa:	288080e7          	jalr	648(ra) # 67e <open>
     3fe:	87aa                	mv	a5,a0
     400:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     404:	fec42783          	lw	a5,-20(s0)
     408:	2781                	sext.w	a5,a5
     40a:	0007d463          	bgez	a5,412 <stat+0x32>
    return -1;
     40e:	57fd                	li	a5,-1
     410:	a035                	j	43c <stat+0x5c>
  r = fstat(fd, st);
     412:	fec42783          	lw	a5,-20(s0)
     416:	fd043583          	ld	a1,-48(s0)
     41a:	853e                	mv	a0,a5
     41c:	00000097          	auipc	ra,0x0
     420:	27a080e7          	jalr	634(ra) # 696 <fstat>
     424:	87aa                	mv	a5,a0
     426:	fef42423          	sw	a5,-24(s0)
  close(fd);
     42a:	fec42783          	lw	a5,-20(s0)
     42e:	853e                	mv	a0,a5
     430:	00000097          	auipc	ra,0x0
     434:	236080e7          	jalr	566(ra) # 666 <close>
  return r;
     438:	fe842783          	lw	a5,-24(s0)
}
     43c:	853e                	mv	a0,a5
     43e:	70a2                	ld	ra,40(sp)
     440:	7402                	ld	s0,32(sp)
     442:	6145                	addi	sp,sp,48
     444:	8082                	ret

0000000000000446 <atoi>:

int
atoi(const char *s)
{
     446:	7179                	addi	sp,sp,-48
     448:	f422                	sd	s0,40(sp)
     44a:	1800                	addi	s0,sp,48
     44c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     450:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     454:	a815                	j	488 <atoi+0x42>
    n = n*10 + *s++ - '0';
     456:	fec42703          	lw	a4,-20(s0)
     45a:	87ba                	mv	a5,a4
     45c:	0027979b          	slliw	a5,a5,0x2
     460:	9fb9                	addw	a5,a5,a4
     462:	0017979b          	slliw	a5,a5,0x1
     466:	0007871b          	sext.w	a4,a5
     46a:	fd843783          	ld	a5,-40(s0)
     46e:	00178693          	addi	a3,a5,1
     472:	fcd43c23          	sd	a3,-40(s0)
     476:	0007c783          	lbu	a5,0(a5)
     47a:	2781                	sext.w	a5,a5
     47c:	9fb9                	addw	a5,a5,a4
     47e:	2781                	sext.w	a5,a5
     480:	fd07879b          	addiw	a5,a5,-48
     484:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     488:	fd843783          	ld	a5,-40(s0)
     48c:	0007c783          	lbu	a5,0(a5)
     490:	873e                	mv	a4,a5
     492:	02f00793          	li	a5,47
     496:	00e7fb63          	bgeu	a5,a4,4ac <atoi+0x66>
     49a:	fd843783          	ld	a5,-40(s0)
     49e:	0007c783          	lbu	a5,0(a5)
     4a2:	873e                	mv	a4,a5
     4a4:	03900793          	li	a5,57
     4a8:	fae7f7e3          	bgeu	a5,a4,456 <atoi+0x10>
  return n;
     4ac:	fec42783          	lw	a5,-20(s0)
}
     4b0:	853e                	mv	a0,a5
     4b2:	7422                	ld	s0,40(sp)
     4b4:	6145                	addi	sp,sp,48
     4b6:	8082                	ret

00000000000004b8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     4b8:	7139                	addi	sp,sp,-64
     4ba:	fc22                	sd	s0,56(sp)
     4bc:	0080                	addi	s0,sp,64
     4be:	fca43c23          	sd	a0,-40(s0)
     4c2:	fcb43823          	sd	a1,-48(s0)
     4c6:	87b2                	mv	a5,a2
     4c8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4cc:	fd843783          	ld	a5,-40(s0)
     4d0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4d4:	fd043783          	ld	a5,-48(s0)
     4d8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4dc:	fe043703          	ld	a4,-32(s0)
     4e0:	fe843783          	ld	a5,-24(s0)
     4e4:	02e7fc63          	bgeu	a5,a4,51c <memmove+0x64>
    while(n-- > 0)
     4e8:	a00d                	j	50a <memmove+0x52>
      *dst++ = *src++;
     4ea:	fe043703          	ld	a4,-32(s0)
     4ee:	00170793          	addi	a5,a4,1
     4f2:	fef43023          	sd	a5,-32(s0)
     4f6:	fe843783          	ld	a5,-24(s0)
     4fa:	00178693          	addi	a3,a5,1
     4fe:	fed43423          	sd	a3,-24(s0)
     502:	00074703          	lbu	a4,0(a4)
     506:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     50a:	fcc42783          	lw	a5,-52(s0)
     50e:	fff7871b          	addiw	a4,a5,-1
     512:	fce42623          	sw	a4,-52(s0)
     516:	fcf04ae3          	bgtz	a5,4ea <memmove+0x32>
     51a:	a891                	j	56e <memmove+0xb6>
  } else {
    dst += n;
     51c:	fcc42783          	lw	a5,-52(s0)
     520:	fe843703          	ld	a4,-24(s0)
     524:	97ba                	add	a5,a5,a4
     526:	fef43423          	sd	a5,-24(s0)
    src += n;
     52a:	fcc42783          	lw	a5,-52(s0)
     52e:	fe043703          	ld	a4,-32(s0)
     532:	97ba                	add	a5,a5,a4
     534:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     538:	a01d                	j	55e <memmove+0xa6>
      *--dst = *--src;
     53a:	fe043783          	ld	a5,-32(s0)
     53e:	17fd                	addi	a5,a5,-1
     540:	fef43023          	sd	a5,-32(s0)
     544:	fe843783          	ld	a5,-24(s0)
     548:	17fd                	addi	a5,a5,-1
     54a:	fef43423          	sd	a5,-24(s0)
     54e:	fe043783          	ld	a5,-32(s0)
     552:	0007c703          	lbu	a4,0(a5)
     556:	fe843783          	ld	a5,-24(s0)
     55a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     55e:	fcc42783          	lw	a5,-52(s0)
     562:	fff7871b          	addiw	a4,a5,-1
     566:	fce42623          	sw	a4,-52(s0)
     56a:	fcf048e3          	bgtz	a5,53a <memmove+0x82>
  }
  return vdst;
     56e:	fd843783          	ld	a5,-40(s0)
}
     572:	853e                	mv	a0,a5
     574:	7462                	ld	s0,56(sp)
     576:	6121                	addi	sp,sp,64
     578:	8082                	ret

000000000000057a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     57a:	7139                	addi	sp,sp,-64
     57c:	fc22                	sd	s0,56(sp)
     57e:	0080                	addi	s0,sp,64
     580:	fca43c23          	sd	a0,-40(s0)
     584:	fcb43823          	sd	a1,-48(s0)
     588:	87b2                	mv	a5,a2
     58a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     58e:	fd843783          	ld	a5,-40(s0)
     592:	fef43423          	sd	a5,-24(s0)
     596:	fd043783          	ld	a5,-48(s0)
     59a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     59e:	a0a1                	j	5e6 <memcmp+0x6c>
    if (*p1 != *p2) {
     5a0:	fe843783          	ld	a5,-24(s0)
     5a4:	0007c703          	lbu	a4,0(a5)
     5a8:	fe043783          	ld	a5,-32(s0)
     5ac:	0007c783          	lbu	a5,0(a5)
     5b0:	02f70163          	beq	a4,a5,5d2 <memcmp+0x58>
      return *p1 - *p2;
     5b4:	fe843783          	ld	a5,-24(s0)
     5b8:	0007c783          	lbu	a5,0(a5)
     5bc:	0007871b          	sext.w	a4,a5
     5c0:	fe043783          	ld	a5,-32(s0)
     5c4:	0007c783          	lbu	a5,0(a5)
     5c8:	2781                	sext.w	a5,a5
     5ca:	40f707bb          	subw	a5,a4,a5
     5ce:	2781                	sext.w	a5,a5
     5d0:	a01d                	j	5f6 <memcmp+0x7c>
    }
    p1++;
     5d2:	fe843783          	ld	a5,-24(s0)
     5d6:	0785                	addi	a5,a5,1
     5d8:	fef43423          	sd	a5,-24(s0)
    p2++;
     5dc:	fe043783          	ld	a5,-32(s0)
     5e0:	0785                	addi	a5,a5,1
     5e2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5e6:	fcc42783          	lw	a5,-52(s0)
     5ea:	fff7871b          	addiw	a4,a5,-1
     5ee:	fce42623          	sw	a4,-52(s0)
     5f2:	f7dd                	bnez	a5,5a0 <memcmp+0x26>
  }
  return 0;
     5f4:	4781                	li	a5,0
}
     5f6:	853e                	mv	a0,a5
     5f8:	7462                	ld	s0,56(sp)
     5fa:	6121                	addi	sp,sp,64
     5fc:	8082                	ret

00000000000005fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5fe:	7179                	addi	sp,sp,-48
     600:	f406                	sd	ra,40(sp)
     602:	f022                	sd	s0,32(sp)
     604:	1800                	addi	s0,sp,48
     606:	fea43423          	sd	a0,-24(s0)
     60a:	feb43023          	sd	a1,-32(s0)
     60e:	87b2                	mv	a5,a2
     610:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     614:	fdc42783          	lw	a5,-36(s0)
     618:	863e                	mv	a2,a5
     61a:	fe043583          	ld	a1,-32(s0)
     61e:	fe843503          	ld	a0,-24(s0)
     622:	00000097          	auipc	ra,0x0
     626:	e96080e7          	jalr	-362(ra) # 4b8 <memmove>
     62a:	87aa                	mv	a5,a0
}
     62c:	853e                	mv	a0,a5
     62e:	70a2                	ld	ra,40(sp)
     630:	7402                	ld	s0,32(sp)
     632:	6145                	addi	sp,sp,48
     634:	8082                	ret

0000000000000636 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     636:	4885                	li	a7,1
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <exit>:
.global exit
exit:
 li a7, SYS_exit
     63e:	4889                	li	a7,2
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <wait>:
.global wait
wait:
 li a7, SYS_wait
     646:	488d                	li	a7,3
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     64e:	4891                	li	a7,4
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <read>:
.global read
read:
 li a7, SYS_read
     656:	4895                	li	a7,5
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <write>:
.global write
write:
 li a7, SYS_write
     65e:	48c1                	li	a7,16
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <close>:
.global close
close:
 li a7, SYS_close
     666:	48d5                	li	a7,21
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <kill>:
.global kill
kill:
 li a7, SYS_kill
     66e:	4899                	li	a7,6
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <exec>:
.global exec
exec:
 li a7, SYS_exec
     676:	489d                	li	a7,7
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <open>:
.global open
open:
 li a7, SYS_open
     67e:	48bd                	li	a7,15
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     686:	48c5                	li	a7,17
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     68e:	48c9                	li	a7,18
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     696:	48a1                	li	a7,8
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <link>:
.global link
link:
 li a7, SYS_link
     69e:	48cd                	li	a7,19
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     6a6:	48d1                	li	a7,20
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     6ae:	48a5                	li	a7,9
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     6b6:	48a9                	li	a7,10
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     6be:	48ad                	li	a7,11
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     6c6:	48b1                	li	a7,12
 ecall
     6c8:	00000073          	ecall
 ret
     6cc:	8082                	ret

00000000000006ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     6ce:	48b5                	li	a7,13
 ecall
     6d0:	00000073          	ecall
 ret
     6d4:	8082                	ret

00000000000006d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6d6:	48b9                	li	a7,14
 ecall
     6d8:	00000073          	ecall
 ret
     6dc:	8082                	ret

00000000000006de <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     6de:	48d9                	li	a7,22
 ecall
     6e0:	00000073          	ecall
 ret
     6e4:	8082                	ret

00000000000006e6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     6e6:	48dd                	li	a7,23
 ecall
     6e8:	00000073          	ecall
 ret
     6ec:	8082                	ret

00000000000006ee <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     6ee:	48e1                	li	a7,24
 ecall
     6f0:	00000073          	ecall
 ret
     6f4:	8082                	ret

00000000000006f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6f6:	1101                	addi	sp,sp,-32
     6f8:	ec06                	sd	ra,24(sp)
     6fa:	e822                	sd	s0,16(sp)
     6fc:	1000                	addi	s0,sp,32
     6fe:	87aa                	mv	a5,a0
     700:	872e                	mv	a4,a1
     702:	fef42623          	sw	a5,-20(s0)
     706:	87ba                	mv	a5,a4
     708:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     70c:	feb40713          	addi	a4,s0,-21
     710:	fec42783          	lw	a5,-20(s0)
     714:	4605                	li	a2,1
     716:	85ba                	mv	a1,a4
     718:	853e                	mv	a0,a5
     71a:	00000097          	auipc	ra,0x0
     71e:	f44080e7          	jalr	-188(ra) # 65e <write>
}
     722:	0001                	nop
     724:	60e2                	ld	ra,24(sp)
     726:	6442                	ld	s0,16(sp)
     728:	6105                	addi	sp,sp,32
     72a:	8082                	ret

000000000000072c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     72c:	7139                	addi	sp,sp,-64
     72e:	fc06                	sd	ra,56(sp)
     730:	f822                	sd	s0,48(sp)
     732:	0080                	addi	s0,sp,64
     734:	87aa                	mv	a5,a0
     736:	8736                	mv	a4,a3
     738:	fcf42623          	sw	a5,-52(s0)
     73c:	87ae                	mv	a5,a1
     73e:	fcf42423          	sw	a5,-56(s0)
     742:	87b2                	mv	a5,a2
     744:	fcf42223          	sw	a5,-60(s0)
     748:	87ba                	mv	a5,a4
     74a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     74e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     752:	fc042783          	lw	a5,-64(s0)
     756:	2781                	sext.w	a5,a5
     758:	c38d                	beqz	a5,77a <printint+0x4e>
     75a:	fc842783          	lw	a5,-56(s0)
     75e:	2781                	sext.w	a5,a5
     760:	0007dd63          	bgez	a5,77a <printint+0x4e>
    neg = 1;
     764:	4785                	li	a5,1
     766:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     76a:	fc842783          	lw	a5,-56(s0)
     76e:	40f007bb          	negw	a5,a5
     772:	2781                	sext.w	a5,a5
     774:	fef42223          	sw	a5,-28(s0)
     778:	a029                	j	782 <printint+0x56>
  } else {
    x = xx;
     77a:	fc842783          	lw	a5,-56(s0)
     77e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     782:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     786:	fc442783          	lw	a5,-60(s0)
     78a:	fe442703          	lw	a4,-28(s0)
     78e:	02f777bb          	remuw	a5,a4,a5
     792:	0007861b          	sext.w	a2,a5
     796:	fec42783          	lw	a5,-20(s0)
     79a:	0017871b          	addiw	a4,a5,1
     79e:	fee42623          	sw	a4,-20(s0)
     7a2:	00002697          	auipc	a3,0x2
     7a6:	92e68693          	addi	a3,a3,-1746 # 20d0 <digits>
     7aa:	02061713          	slli	a4,a2,0x20
     7ae:	9301                	srli	a4,a4,0x20
     7b0:	9736                	add	a4,a4,a3
     7b2:	00074703          	lbu	a4,0(a4)
     7b6:	ff040693          	addi	a3,s0,-16
     7ba:	97b6                	add	a5,a5,a3
     7bc:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     7c0:	fc442783          	lw	a5,-60(s0)
     7c4:	fe442703          	lw	a4,-28(s0)
     7c8:	02f757bb          	divuw	a5,a4,a5
     7cc:	fef42223          	sw	a5,-28(s0)
     7d0:	fe442783          	lw	a5,-28(s0)
     7d4:	2781                	sext.w	a5,a5
     7d6:	fbc5                	bnez	a5,786 <printint+0x5a>
  if(neg)
     7d8:	fe842783          	lw	a5,-24(s0)
     7dc:	2781                	sext.w	a5,a5
     7de:	cf95                	beqz	a5,81a <printint+0xee>
    buf[i++] = '-';
     7e0:	fec42783          	lw	a5,-20(s0)
     7e4:	0017871b          	addiw	a4,a5,1
     7e8:	fee42623          	sw	a4,-20(s0)
     7ec:	ff040713          	addi	a4,s0,-16
     7f0:	97ba                	add	a5,a5,a4
     7f2:	02d00713          	li	a4,45
     7f6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     7fa:	a005                	j	81a <printint+0xee>
    putc(fd, buf[i]);
     7fc:	fec42783          	lw	a5,-20(s0)
     800:	ff040713          	addi	a4,s0,-16
     804:	97ba                	add	a5,a5,a4
     806:	fe07c703          	lbu	a4,-32(a5)
     80a:	fcc42783          	lw	a5,-52(s0)
     80e:	85ba                	mv	a1,a4
     810:	853e                	mv	a0,a5
     812:	00000097          	auipc	ra,0x0
     816:	ee4080e7          	jalr	-284(ra) # 6f6 <putc>
  while(--i >= 0)
     81a:	fec42783          	lw	a5,-20(s0)
     81e:	37fd                	addiw	a5,a5,-1
     820:	fef42623          	sw	a5,-20(s0)
     824:	fec42783          	lw	a5,-20(s0)
     828:	2781                	sext.w	a5,a5
     82a:	fc07d9e3          	bgez	a5,7fc <printint+0xd0>
}
     82e:	0001                	nop
     830:	0001                	nop
     832:	70e2                	ld	ra,56(sp)
     834:	7442                	ld	s0,48(sp)
     836:	6121                	addi	sp,sp,64
     838:	8082                	ret

000000000000083a <printptr>:

static void
printptr(int fd, uint64 x) {
     83a:	7179                	addi	sp,sp,-48
     83c:	f406                	sd	ra,40(sp)
     83e:	f022                	sd	s0,32(sp)
     840:	1800                	addi	s0,sp,48
     842:	87aa                	mv	a5,a0
     844:	fcb43823          	sd	a1,-48(s0)
     848:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     84c:	fdc42783          	lw	a5,-36(s0)
     850:	03000593          	li	a1,48
     854:	853e                	mv	a0,a5
     856:	00000097          	auipc	ra,0x0
     85a:	ea0080e7          	jalr	-352(ra) # 6f6 <putc>
  putc(fd, 'x');
     85e:	fdc42783          	lw	a5,-36(s0)
     862:	07800593          	li	a1,120
     866:	853e                	mv	a0,a5
     868:	00000097          	auipc	ra,0x0
     86c:	e8e080e7          	jalr	-370(ra) # 6f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     870:	fe042623          	sw	zero,-20(s0)
     874:	a82d                	j	8ae <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     876:	fd043783          	ld	a5,-48(s0)
     87a:	93f1                	srli	a5,a5,0x3c
     87c:	00002717          	auipc	a4,0x2
     880:	85470713          	addi	a4,a4,-1964 # 20d0 <digits>
     884:	97ba                	add	a5,a5,a4
     886:	0007c703          	lbu	a4,0(a5)
     88a:	fdc42783          	lw	a5,-36(s0)
     88e:	85ba                	mv	a1,a4
     890:	853e                	mv	a0,a5
     892:	00000097          	auipc	ra,0x0
     896:	e64080e7          	jalr	-412(ra) # 6f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     89a:	fec42783          	lw	a5,-20(s0)
     89e:	2785                	addiw	a5,a5,1
     8a0:	fef42623          	sw	a5,-20(s0)
     8a4:	fd043783          	ld	a5,-48(s0)
     8a8:	0792                	slli	a5,a5,0x4
     8aa:	fcf43823          	sd	a5,-48(s0)
     8ae:	fec42783          	lw	a5,-20(s0)
     8b2:	873e                	mv	a4,a5
     8b4:	47bd                	li	a5,15
     8b6:	fce7f0e3          	bgeu	a5,a4,876 <printptr+0x3c>
}
     8ba:	0001                	nop
     8bc:	0001                	nop
     8be:	70a2                	ld	ra,40(sp)
     8c0:	7402                	ld	s0,32(sp)
     8c2:	6145                	addi	sp,sp,48
     8c4:	8082                	ret

00000000000008c6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8c6:	715d                	addi	sp,sp,-80
     8c8:	e486                	sd	ra,72(sp)
     8ca:	e0a2                	sd	s0,64(sp)
     8cc:	0880                	addi	s0,sp,80
     8ce:	87aa                	mv	a5,a0
     8d0:	fcb43023          	sd	a1,-64(s0)
     8d4:	fac43c23          	sd	a2,-72(s0)
     8d8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8dc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8e0:	fe042223          	sw	zero,-28(s0)
     8e4:	a42d                	j	b0e <vprintf+0x248>
    c = fmt[i] & 0xff;
     8e6:	fe442783          	lw	a5,-28(s0)
     8ea:	fc043703          	ld	a4,-64(s0)
     8ee:	97ba                	add	a5,a5,a4
     8f0:	0007c783          	lbu	a5,0(a5)
     8f4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     8f8:	fe042783          	lw	a5,-32(s0)
     8fc:	2781                	sext.w	a5,a5
     8fe:	eb9d                	bnez	a5,934 <vprintf+0x6e>
      if(c == '%'){
     900:	fdc42783          	lw	a5,-36(s0)
     904:	0007871b          	sext.w	a4,a5
     908:	02500793          	li	a5,37
     90c:	00f71763          	bne	a4,a5,91a <vprintf+0x54>
        state = '%';
     910:	02500793          	li	a5,37
     914:	fef42023          	sw	a5,-32(s0)
     918:	a2f5                	j	b04 <vprintf+0x23e>
      } else {
        putc(fd, c);
     91a:	fdc42783          	lw	a5,-36(s0)
     91e:	0ff7f713          	andi	a4,a5,255
     922:	fcc42783          	lw	a5,-52(s0)
     926:	85ba                	mv	a1,a4
     928:	853e                	mv	a0,a5
     92a:	00000097          	auipc	ra,0x0
     92e:	dcc080e7          	jalr	-564(ra) # 6f6 <putc>
     932:	aac9                	j	b04 <vprintf+0x23e>
      }
    } else if(state == '%'){
     934:	fe042783          	lw	a5,-32(s0)
     938:	0007871b          	sext.w	a4,a5
     93c:	02500793          	li	a5,37
     940:	1cf71263          	bne	a4,a5,b04 <vprintf+0x23e>
      if(c == 'd'){
     944:	fdc42783          	lw	a5,-36(s0)
     948:	0007871b          	sext.w	a4,a5
     94c:	06400793          	li	a5,100
     950:	02f71463          	bne	a4,a5,978 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     954:	fb843783          	ld	a5,-72(s0)
     958:	00878713          	addi	a4,a5,8
     95c:	fae43c23          	sd	a4,-72(s0)
     960:	4398                	lw	a4,0(a5)
     962:	fcc42783          	lw	a5,-52(s0)
     966:	4685                	li	a3,1
     968:	4629                	li	a2,10
     96a:	85ba                	mv	a1,a4
     96c:	853e                	mv	a0,a5
     96e:	00000097          	auipc	ra,0x0
     972:	dbe080e7          	jalr	-578(ra) # 72c <printint>
     976:	a269                	j	b00 <vprintf+0x23a>
      } else if(c == 'l') {
     978:	fdc42783          	lw	a5,-36(s0)
     97c:	0007871b          	sext.w	a4,a5
     980:	06c00793          	li	a5,108
     984:	02f71663          	bne	a4,a5,9b0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     988:	fb843783          	ld	a5,-72(s0)
     98c:	00878713          	addi	a4,a5,8
     990:	fae43c23          	sd	a4,-72(s0)
     994:	639c                	ld	a5,0(a5)
     996:	0007871b          	sext.w	a4,a5
     99a:	fcc42783          	lw	a5,-52(s0)
     99e:	4681                	li	a3,0
     9a0:	4629                	li	a2,10
     9a2:	85ba                	mv	a1,a4
     9a4:	853e                	mv	a0,a5
     9a6:	00000097          	auipc	ra,0x0
     9aa:	d86080e7          	jalr	-634(ra) # 72c <printint>
     9ae:	aa89                	j	b00 <vprintf+0x23a>
      } else if(c == 'x') {
     9b0:	fdc42783          	lw	a5,-36(s0)
     9b4:	0007871b          	sext.w	a4,a5
     9b8:	07800793          	li	a5,120
     9bc:	02f71463          	bne	a4,a5,9e4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     9c0:	fb843783          	ld	a5,-72(s0)
     9c4:	00878713          	addi	a4,a5,8
     9c8:	fae43c23          	sd	a4,-72(s0)
     9cc:	4398                	lw	a4,0(a5)
     9ce:	fcc42783          	lw	a5,-52(s0)
     9d2:	4681                	li	a3,0
     9d4:	4641                	li	a2,16
     9d6:	85ba                	mv	a1,a4
     9d8:	853e                	mv	a0,a5
     9da:	00000097          	auipc	ra,0x0
     9de:	d52080e7          	jalr	-686(ra) # 72c <printint>
     9e2:	aa39                	j	b00 <vprintf+0x23a>
      } else if(c == 'p') {
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0007871b          	sext.w	a4,a5
     9ec:	07000793          	li	a5,112
     9f0:	02f71263          	bne	a4,a5,a14 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     9f4:	fb843783          	ld	a5,-72(s0)
     9f8:	00878713          	addi	a4,a5,8
     9fc:	fae43c23          	sd	a4,-72(s0)
     a00:	6398                	ld	a4,0(a5)
     a02:	fcc42783          	lw	a5,-52(s0)
     a06:	85ba                	mv	a1,a4
     a08:	853e                	mv	a0,a5
     a0a:	00000097          	auipc	ra,0x0
     a0e:	e30080e7          	jalr	-464(ra) # 83a <printptr>
     a12:	a0fd                	j	b00 <vprintf+0x23a>
      } else if(c == 's'){
     a14:	fdc42783          	lw	a5,-36(s0)
     a18:	0007871b          	sext.w	a4,a5
     a1c:	07300793          	li	a5,115
     a20:	04f71c63          	bne	a4,a5,a78 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a24:	fb843783          	ld	a5,-72(s0)
     a28:	00878713          	addi	a4,a5,8
     a2c:	fae43c23          	sd	a4,-72(s0)
     a30:	639c                	ld	a5,0(a5)
     a32:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a36:	fe843783          	ld	a5,-24(s0)
     a3a:	eb8d                	bnez	a5,a6c <vprintf+0x1a6>
          s = "(null)";
     a3c:	00001797          	auipc	a5,0x1
     a40:	56478793          	addi	a5,a5,1380 # 1fa0 <schedule_rm+0x2f0>
     a44:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a48:	a015                	j	a6c <vprintf+0x1a6>
          putc(fd, *s);
     a4a:	fe843783          	ld	a5,-24(s0)
     a4e:	0007c703          	lbu	a4,0(a5)
     a52:	fcc42783          	lw	a5,-52(s0)
     a56:	85ba                	mv	a1,a4
     a58:	853e                	mv	a0,a5
     a5a:	00000097          	auipc	ra,0x0
     a5e:	c9c080e7          	jalr	-868(ra) # 6f6 <putc>
          s++;
     a62:	fe843783          	ld	a5,-24(s0)
     a66:	0785                	addi	a5,a5,1
     a68:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a6c:	fe843783          	ld	a5,-24(s0)
     a70:	0007c783          	lbu	a5,0(a5)
     a74:	fbf9                	bnez	a5,a4a <vprintf+0x184>
     a76:	a069                	j	b00 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a78:	fdc42783          	lw	a5,-36(s0)
     a7c:	0007871b          	sext.w	a4,a5
     a80:	06300793          	li	a5,99
     a84:	02f71463          	bne	a4,a5,aac <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a88:	fb843783          	ld	a5,-72(s0)
     a8c:	00878713          	addi	a4,a5,8
     a90:	fae43c23          	sd	a4,-72(s0)
     a94:	439c                	lw	a5,0(a5)
     a96:	0ff7f713          	andi	a4,a5,255
     a9a:	fcc42783          	lw	a5,-52(s0)
     a9e:	85ba                	mv	a1,a4
     aa0:	853e                	mv	a0,a5
     aa2:	00000097          	auipc	ra,0x0
     aa6:	c54080e7          	jalr	-940(ra) # 6f6 <putc>
     aaa:	a899                	j	b00 <vprintf+0x23a>
      } else if(c == '%'){
     aac:	fdc42783          	lw	a5,-36(s0)
     ab0:	0007871b          	sext.w	a4,a5
     ab4:	02500793          	li	a5,37
     ab8:	00f71f63          	bne	a4,a5,ad6 <vprintf+0x210>
        putc(fd, c);
     abc:	fdc42783          	lw	a5,-36(s0)
     ac0:	0ff7f713          	andi	a4,a5,255
     ac4:	fcc42783          	lw	a5,-52(s0)
     ac8:	85ba                	mv	a1,a4
     aca:	853e                	mv	a0,a5
     acc:	00000097          	auipc	ra,0x0
     ad0:	c2a080e7          	jalr	-982(ra) # 6f6 <putc>
     ad4:	a035                	j	b00 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ad6:	fcc42783          	lw	a5,-52(s0)
     ada:	02500593          	li	a1,37
     ade:	853e                	mv	a0,a5
     ae0:	00000097          	auipc	ra,0x0
     ae4:	c16080e7          	jalr	-1002(ra) # 6f6 <putc>
        putc(fd, c);
     ae8:	fdc42783          	lw	a5,-36(s0)
     aec:	0ff7f713          	andi	a4,a5,255
     af0:	fcc42783          	lw	a5,-52(s0)
     af4:	85ba                	mv	a1,a4
     af6:	853e                	mv	a0,a5
     af8:	00000097          	auipc	ra,0x0
     afc:	bfe080e7          	jalr	-1026(ra) # 6f6 <putc>
      }
      state = 0;
     b00:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b04:	fe442783          	lw	a5,-28(s0)
     b08:	2785                	addiw	a5,a5,1
     b0a:	fef42223          	sw	a5,-28(s0)
     b0e:	fe442783          	lw	a5,-28(s0)
     b12:	fc043703          	ld	a4,-64(s0)
     b16:	97ba                	add	a5,a5,a4
     b18:	0007c783          	lbu	a5,0(a5)
     b1c:	dc0795e3          	bnez	a5,8e6 <vprintf+0x20>
    }
  }
}
     b20:	0001                	nop
     b22:	0001                	nop
     b24:	60a6                	ld	ra,72(sp)
     b26:	6406                	ld	s0,64(sp)
     b28:	6161                	addi	sp,sp,80
     b2a:	8082                	ret

0000000000000b2c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     b2c:	7159                	addi	sp,sp,-112
     b2e:	fc06                	sd	ra,56(sp)
     b30:	f822                	sd	s0,48(sp)
     b32:	0080                	addi	s0,sp,64
     b34:	fcb43823          	sd	a1,-48(s0)
     b38:	e010                	sd	a2,0(s0)
     b3a:	e414                	sd	a3,8(s0)
     b3c:	e818                	sd	a4,16(s0)
     b3e:	ec1c                	sd	a5,24(s0)
     b40:	03043023          	sd	a6,32(s0)
     b44:	03143423          	sd	a7,40(s0)
     b48:	87aa                	mv	a5,a0
     b4a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b4e:	03040793          	addi	a5,s0,48
     b52:	fcf43423          	sd	a5,-56(s0)
     b56:	fc843783          	ld	a5,-56(s0)
     b5a:	fd078793          	addi	a5,a5,-48
     b5e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b62:	fe843703          	ld	a4,-24(s0)
     b66:	fdc42783          	lw	a5,-36(s0)
     b6a:	863a                	mv	a2,a4
     b6c:	fd043583          	ld	a1,-48(s0)
     b70:	853e                	mv	a0,a5
     b72:	00000097          	auipc	ra,0x0
     b76:	d54080e7          	jalr	-684(ra) # 8c6 <vprintf>
}
     b7a:	0001                	nop
     b7c:	70e2                	ld	ra,56(sp)
     b7e:	7442                	ld	s0,48(sp)
     b80:	6165                	addi	sp,sp,112
     b82:	8082                	ret

0000000000000b84 <printf>:

void
printf(const char *fmt, ...)
{
     b84:	7159                	addi	sp,sp,-112
     b86:	f406                	sd	ra,40(sp)
     b88:	f022                	sd	s0,32(sp)
     b8a:	1800                	addi	s0,sp,48
     b8c:	fca43c23          	sd	a0,-40(s0)
     b90:	e40c                	sd	a1,8(s0)
     b92:	e810                	sd	a2,16(s0)
     b94:	ec14                	sd	a3,24(s0)
     b96:	f018                	sd	a4,32(s0)
     b98:	f41c                	sd	a5,40(s0)
     b9a:	03043823          	sd	a6,48(s0)
     b9e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     ba2:	04040793          	addi	a5,s0,64
     ba6:	fcf43823          	sd	a5,-48(s0)
     baa:	fd043783          	ld	a5,-48(s0)
     bae:	fc878793          	addi	a5,a5,-56
     bb2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     bb6:	fe843783          	ld	a5,-24(s0)
     bba:	863e                	mv	a2,a5
     bbc:	fd843583          	ld	a1,-40(s0)
     bc0:	4505                	li	a0,1
     bc2:	00000097          	auipc	ra,0x0
     bc6:	d04080e7          	jalr	-764(ra) # 8c6 <vprintf>
}
     bca:	0001                	nop
     bcc:	70a2                	ld	ra,40(sp)
     bce:	7402                	ld	s0,32(sp)
     bd0:	6165                	addi	sp,sp,112
     bd2:	8082                	ret

0000000000000bd4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     bd4:	7179                	addi	sp,sp,-48
     bd6:	f422                	sd	s0,40(sp)
     bd8:	1800                	addi	s0,sp,48
     bda:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bde:	fd843783          	ld	a5,-40(s0)
     be2:	17c1                	addi	a5,a5,-16
     be4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     be8:	00001797          	auipc	a5,0x1
     bec:	54878793          	addi	a5,a5,1352 # 2130 <freep>
     bf0:	639c                	ld	a5,0(a5)
     bf2:	fef43423          	sd	a5,-24(s0)
     bf6:	a815                	j	c2a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bf8:	fe843783          	ld	a5,-24(s0)
     bfc:	639c                	ld	a5,0(a5)
     bfe:	fe843703          	ld	a4,-24(s0)
     c02:	00f76f63          	bltu	a4,a5,c20 <free+0x4c>
     c06:	fe043703          	ld	a4,-32(s0)
     c0a:	fe843783          	ld	a5,-24(s0)
     c0e:	02e7eb63          	bltu	a5,a4,c44 <free+0x70>
     c12:	fe843783          	ld	a5,-24(s0)
     c16:	639c                	ld	a5,0(a5)
     c18:	fe043703          	ld	a4,-32(s0)
     c1c:	02f76463          	bltu	a4,a5,c44 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c20:	fe843783          	ld	a5,-24(s0)
     c24:	639c                	ld	a5,0(a5)
     c26:	fef43423          	sd	a5,-24(s0)
     c2a:	fe043703          	ld	a4,-32(s0)
     c2e:	fe843783          	ld	a5,-24(s0)
     c32:	fce7f3e3          	bgeu	a5,a4,bf8 <free+0x24>
     c36:	fe843783          	ld	a5,-24(s0)
     c3a:	639c                	ld	a5,0(a5)
     c3c:	fe043703          	ld	a4,-32(s0)
     c40:	faf77ce3          	bgeu	a4,a5,bf8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	479c                	lw	a5,8(a5)
     c4a:	1782                	slli	a5,a5,0x20
     c4c:	9381                	srli	a5,a5,0x20
     c4e:	0792                	slli	a5,a5,0x4
     c50:	fe043703          	ld	a4,-32(s0)
     c54:	973e                	add	a4,a4,a5
     c56:	fe843783          	ld	a5,-24(s0)
     c5a:	639c                	ld	a5,0(a5)
     c5c:	02f71763          	bne	a4,a5,c8a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c60:	fe043783          	ld	a5,-32(s0)
     c64:	4798                	lw	a4,8(a5)
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	639c                	ld	a5,0(a5)
     c6c:	479c                	lw	a5,8(a5)
     c6e:	9fb9                	addw	a5,a5,a4
     c70:	0007871b          	sext.w	a4,a5
     c74:	fe043783          	ld	a5,-32(s0)
     c78:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c7a:	fe843783          	ld	a5,-24(s0)
     c7e:	639c                	ld	a5,0(a5)
     c80:	6398                	ld	a4,0(a5)
     c82:	fe043783          	ld	a5,-32(s0)
     c86:	e398                	sd	a4,0(a5)
     c88:	a039                	j	c96 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c8a:	fe843783          	ld	a5,-24(s0)
     c8e:	6398                	ld	a4,0(a5)
     c90:	fe043783          	ld	a5,-32(s0)
     c94:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c96:	fe843783          	ld	a5,-24(s0)
     c9a:	479c                	lw	a5,8(a5)
     c9c:	1782                	slli	a5,a5,0x20
     c9e:	9381                	srli	a5,a5,0x20
     ca0:	0792                	slli	a5,a5,0x4
     ca2:	fe843703          	ld	a4,-24(s0)
     ca6:	97ba                	add	a5,a5,a4
     ca8:	fe043703          	ld	a4,-32(s0)
     cac:	02f71563          	bne	a4,a5,cd6 <free+0x102>
    p->s.size += bp->s.size;
     cb0:	fe843783          	ld	a5,-24(s0)
     cb4:	4798                	lw	a4,8(a5)
     cb6:	fe043783          	ld	a5,-32(s0)
     cba:	479c                	lw	a5,8(a5)
     cbc:	9fb9                	addw	a5,a5,a4
     cbe:	0007871b          	sext.w	a4,a5
     cc2:	fe843783          	ld	a5,-24(s0)
     cc6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     cc8:	fe043783          	ld	a5,-32(s0)
     ccc:	6398                	ld	a4,0(a5)
     cce:	fe843783          	ld	a5,-24(s0)
     cd2:	e398                	sd	a4,0(a5)
     cd4:	a031                	j	ce0 <free+0x10c>
  } else
    p->s.ptr = bp;
     cd6:	fe843783          	ld	a5,-24(s0)
     cda:	fe043703          	ld	a4,-32(s0)
     cde:	e398                	sd	a4,0(a5)
  freep = p;
     ce0:	00001797          	auipc	a5,0x1
     ce4:	45078793          	addi	a5,a5,1104 # 2130 <freep>
     ce8:	fe843703          	ld	a4,-24(s0)
     cec:	e398                	sd	a4,0(a5)
}
     cee:	0001                	nop
     cf0:	7422                	ld	s0,40(sp)
     cf2:	6145                	addi	sp,sp,48
     cf4:	8082                	ret

0000000000000cf6 <morecore>:

static Header*
morecore(uint nu)
{
     cf6:	7179                	addi	sp,sp,-48
     cf8:	f406                	sd	ra,40(sp)
     cfa:	f022                	sd	s0,32(sp)
     cfc:	1800                	addi	s0,sp,48
     cfe:	87aa                	mv	a5,a0
     d00:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     d04:	fdc42783          	lw	a5,-36(s0)
     d08:	0007871b          	sext.w	a4,a5
     d0c:	6785                	lui	a5,0x1
     d0e:	00f77563          	bgeu	a4,a5,d18 <morecore+0x22>
    nu = 4096;
     d12:	6785                	lui	a5,0x1
     d14:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     d18:	fdc42783          	lw	a5,-36(s0)
     d1c:	0047979b          	slliw	a5,a5,0x4
     d20:	2781                	sext.w	a5,a5
     d22:	2781                	sext.w	a5,a5
     d24:	853e                	mv	a0,a5
     d26:	00000097          	auipc	ra,0x0
     d2a:	9a0080e7          	jalr	-1632(ra) # 6c6 <sbrk>
     d2e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d32:	fe843703          	ld	a4,-24(s0)
     d36:	57fd                	li	a5,-1
     d38:	00f71463          	bne	a4,a5,d40 <morecore+0x4a>
    return 0;
     d3c:	4781                	li	a5,0
     d3e:	a03d                	j	d6c <morecore+0x76>
  hp = (Header*)p;
     d40:	fe843783          	ld	a5,-24(s0)
     d44:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d48:	fe043783          	ld	a5,-32(s0)
     d4c:	fdc42703          	lw	a4,-36(s0)
     d50:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d52:	fe043783          	ld	a5,-32(s0)
     d56:	07c1                	addi	a5,a5,16
     d58:	853e                	mv	a0,a5
     d5a:	00000097          	auipc	ra,0x0
     d5e:	e7a080e7          	jalr	-390(ra) # bd4 <free>
  return freep;
     d62:	00001797          	auipc	a5,0x1
     d66:	3ce78793          	addi	a5,a5,974 # 2130 <freep>
     d6a:	639c                	ld	a5,0(a5)
}
     d6c:	853e                	mv	a0,a5
     d6e:	70a2                	ld	ra,40(sp)
     d70:	7402                	ld	s0,32(sp)
     d72:	6145                	addi	sp,sp,48
     d74:	8082                	ret

0000000000000d76 <malloc>:

void*
malloc(uint nbytes)
{
     d76:	7139                	addi	sp,sp,-64
     d78:	fc06                	sd	ra,56(sp)
     d7a:	f822                	sd	s0,48(sp)
     d7c:	0080                	addi	s0,sp,64
     d7e:	87aa                	mv	a5,a0
     d80:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d84:	fcc46783          	lwu	a5,-52(s0)
     d88:	07bd                	addi	a5,a5,15
     d8a:	8391                	srli	a5,a5,0x4
     d8c:	2781                	sext.w	a5,a5
     d8e:	2785                	addiw	a5,a5,1
     d90:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d94:	00001797          	auipc	a5,0x1
     d98:	39c78793          	addi	a5,a5,924 # 2130 <freep>
     d9c:	639c                	ld	a5,0(a5)
     d9e:	fef43023          	sd	a5,-32(s0)
     da2:	fe043783          	ld	a5,-32(s0)
     da6:	ef95                	bnez	a5,de2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     da8:	00001797          	auipc	a5,0x1
     dac:	37878793          	addi	a5,a5,888 # 2120 <base>
     db0:	fef43023          	sd	a5,-32(s0)
     db4:	00001797          	auipc	a5,0x1
     db8:	37c78793          	addi	a5,a5,892 # 2130 <freep>
     dbc:	fe043703          	ld	a4,-32(s0)
     dc0:	e398                	sd	a4,0(a5)
     dc2:	00001797          	auipc	a5,0x1
     dc6:	36e78793          	addi	a5,a5,878 # 2130 <freep>
     dca:	6398                	ld	a4,0(a5)
     dcc:	00001797          	auipc	a5,0x1
     dd0:	35478793          	addi	a5,a5,852 # 2120 <base>
     dd4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     dd6:	00001797          	auipc	a5,0x1
     dda:	34a78793          	addi	a5,a5,842 # 2120 <base>
     dde:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     de2:	fe043783          	ld	a5,-32(s0)
     de6:	639c                	ld	a5,0(a5)
     de8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dec:	fe843783          	ld	a5,-24(s0)
     df0:	4798                	lw	a4,8(a5)
     df2:	fdc42783          	lw	a5,-36(s0)
     df6:	2781                	sext.w	a5,a5
     df8:	06f76863          	bltu	a4,a5,e68 <malloc+0xf2>
      if(p->s.size == nunits)
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	4798                	lw	a4,8(a5)
     e02:	fdc42783          	lw	a5,-36(s0)
     e06:	2781                	sext.w	a5,a5
     e08:	00e79963          	bne	a5,a4,e1a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     e0c:	fe843783          	ld	a5,-24(s0)
     e10:	6398                	ld	a4,0(a5)
     e12:	fe043783          	ld	a5,-32(s0)
     e16:	e398                	sd	a4,0(a5)
     e18:	a82d                	j	e52 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     e1a:	fe843783          	ld	a5,-24(s0)
     e1e:	4798                	lw	a4,8(a5)
     e20:	fdc42783          	lw	a5,-36(s0)
     e24:	40f707bb          	subw	a5,a4,a5
     e28:	0007871b          	sext.w	a4,a5
     e2c:	fe843783          	ld	a5,-24(s0)
     e30:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e32:	fe843783          	ld	a5,-24(s0)
     e36:	479c                	lw	a5,8(a5)
     e38:	1782                	slli	a5,a5,0x20
     e3a:	9381                	srli	a5,a5,0x20
     e3c:	0792                	slli	a5,a5,0x4
     e3e:	fe843703          	ld	a4,-24(s0)
     e42:	97ba                	add	a5,a5,a4
     e44:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e48:	fe843783          	ld	a5,-24(s0)
     e4c:	fdc42703          	lw	a4,-36(s0)
     e50:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e52:	00001797          	auipc	a5,0x1
     e56:	2de78793          	addi	a5,a5,734 # 2130 <freep>
     e5a:	fe043703          	ld	a4,-32(s0)
     e5e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	07c1                	addi	a5,a5,16
     e66:	a091                	j	eaa <malloc+0x134>
    }
    if(p == freep)
     e68:	00001797          	auipc	a5,0x1
     e6c:	2c878793          	addi	a5,a5,712 # 2130 <freep>
     e70:	639c                	ld	a5,0(a5)
     e72:	fe843703          	ld	a4,-24(s0)
     e76:	02f71063          	bne	a4,a5,e96 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     e7a:	fdc42783          	lw	a5,-36(s0)
     e7e:	853e                	mv	a0,a5
     e80:	00000097          	auipc	ra,0x0
     e84:	e76080e7          	jalr	-394(ra) # cf6 <morecore>
     e88:	fea43423          	sd	a0,-24(s0)
     e8c:	fe843783          	ld	a5,-24(s0)
     e90:	e399                	bnez	a5,e96 <malloc+0x120>
        return 0;
     e92:	4781                	li	a5,0
     e94:	a819                	j	eaa <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e96:	fe843783          	ld	a5,-24(s0)
     e9a:	fef43023          	sd	a5,-32(s0)
     e9e:	fe843783          	ld	a5,-24(s0)
     ea2:	639c                	ld	a5,0(a5)
     ea4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     ea8:	b791                	j	dec <malloc+0x76>
  }
}
     eaa:	853e                	mv	a0,a5
     eac:	70e2                	ld	ra,56(sp)
     eae:	7442                	ld	s0,48(sp)
     eb0:	6121                	addi	sp,sp,64
     eb2:	8082                	ret

0000000000000eb4 <setjmp>:
     eb4:	e100                	sd	s0,0(a0)
     eb6:	e504                	sd	s1,8(a0)
     eb8:	01253823          	sd	s2,16(a0)
     ebc:	01353c23          	sd	s3,24(a0)
     ec0:	03453023          	sd	s4,32(a0)
     ec4:	03553423          	sd	s5,40(a0)
     ec8:	03653823          	sd	s6,48(a0)
     ecc:	03753c23          	sd	s7,56(a0)
     ed0:	05853023          	sd	s8,64(a0)
     ed4:	05953423          	sd	s9,72(a0)
     ed8:	05a53823          	sd	s10,80(a0)
     edc:	05b53c23          	sd	s11,88(a0)
     ee0:	06153023          	sd	ra,96(a0)
     ee4:	06253423          	sd	sp,104(a0)
     ee8:	4501                	li	a0,0
     eea:	8082                	ret

0000000000000eec <longjmp>:
     eec:	6100                	ld	s0,0(a0)
     eee:	6504                	ld	s1,8(a0)
     ef0:	01053903          	ld	s2,16(a0)
     ef4:	01853983          	ld	s3,24(a0)
     ef8:	02053a03          	ld	s4,32(a0)
     efc:	02853a83          	ld	s5,40(a0)
     f00:	03053b03          	ld	s6,48(a0)
     f04:	03853b83          	ld	s7,56(a0)
     f08:	04053c03          	ld	s8,64(a0)
     f0c:	04853c83          	ld	s9,72(a0)
     f10:	05053d03          	ld	s10,80(a0)
     f14:	05853d83          	ld	s11,88(a0)
     f18:	06053083          	ld	ra,96(a0)
     f1c:	06853103          	ld	sp,104(a0)
     f20:	c199                	beqz	a1,f26 <longjmp_1>
     f22:	852e                	mv	a0,a1
     f24:	8082                	ret

0000000000000f26 <longjmp_1>:
     f26:	4505                	li	a0,1
     f28:	8082                	ret

0000000000000f2a <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     f2a:	7179                	addi	sp,sp,-48
     f2c:	f422                	sd	s0,40(sp)
     f2e:	1800                	addi	s0,sp,48
     f30:	fea43423          	sd	a0,-24(s0)
     f34:	feb43023          	sd	a1,-32(s0)
     f38:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     f3c:	fd843783          	ld	a5,-40(s0)
     f40:	fe843703          	ld	a4,-24(s0)
     f44:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     f46:	fe843783          	ld	a5,-24(s0)
     f4a:	fd843703          	ld	a4,-40(s0)
     f4e:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     f50:	fe843783          	ld	a5,-24(s0)
     f54:	fe043703          	ld	a4,-32(s0)
     f58:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     f5a:	fe043783          	ld	a5,-32(s0)
     f5e:	fe843703          	ld	a4,-24(s0)
     f62:	e398                	sd	a4,0(a5)
}
     f64:	0001                	nop
     f66:	7422                	ld	s0,40(sp)
     f68:	6145                	addi	sp,sp,48
     f6a:	8082                	ret

0000000000000f6c <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     f6c:	1101                	addi	sp,sp,-32
     f6e:	ec06                	sd	ra,24(sp)
     f70:	e822                	sd	s0,16(sp)
     f72:	1000                	addi	s0,sp,32
     f74:	fea43423          	sd	a0,-24(s0)
     f78:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     f7c:	fe043783          	ld	a5,-32(s0)
     f80:	679c                	ld	a5,8(a5)
     f82:	fe043603          	ld	a2,-32(s0)
     f86:	85be                	mv	a1,a5
     f88:	fe843503          	ld	a0,-24(s0)
     f8c:	00000097          	auipc	ra,0x0
     f90:	f9e080e7          	jalr	-98(ra) # f2a <__list_add>
}
     f94:	0001                	nop
     f96:	60e2                	ld	ra,24(sp)
     f98:	6442                	ld	s0,16(sp)
     f9a:	6105                	addi	sp,sp,32
     f9c:	8082                	ret

0000000000000f9e <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     f9e:	1101                	addi	sp,sp,-32
     fa0:	ec22                	sd	s0,24(sp)
     fa2:	1000                	addi	s0,sp,32
     fa4:	fea43423          	sd	a0,-24(s0)
     fa8:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     fac:	fe043783          	ld	a5,-32(s0)
     fb0:	fe843703          	ld	a4,-24(s0)
     fb4:	e798                	sd	a4,8(a5)
    prev->next = next;
     fb6:	fe843783          	ld	a5,-24(s0)
     fba:	fe043703          	ld	a4,-32(s0)
     fbe:	e398                	sd	a4,0(a5)
}
     fc0:	0001                	nop
     fc2:	6462                	ld	s0,24(sp)
     fc4:	6105                	addi	sp,sp,32
     fc6:	8082                	ret

0000000000000fc8 <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     fc8:	1101                	addi	sp,sp,-32
     fca:	ec06                	sd	ra,24(sp)
     fcc:	e822                	sd	s0,16(sp)
     fce:	1000                	addi	s0,sp,32
     fd0:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     fd4:	fe843783          	ld	a5,-24(s0)
     fd8:	6798                	ld	a4,8(a5)
     fda:	fe843783          	ld	a5,-24(s0)
     fde:	639c                	ld	a5,0(a5)
     fe0:	85be                	mv	a1,a5
     fe2:	853a                	mv	a0,a4
     fe4:	00000097          	auipc	ra,0x0
     fe8:	fba080e7          	jalr	-70(ra) # f9e <__list_del>
    entry->next = LIST_POISON1;
     fec:	fe843783          	ld	a5,-24(s0)
     ff0:	00100737          	lui	a4,0x100
     ff4:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd830>
     ff8:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
     ffa:	fe843783          	ld	a5,-24(s0)
     ffe:	00200737          	lui	a4,0x200
    1002:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd930>
    1006:	e798                	sd	a4,8(a5)
}
    1008:	0001                	nop
    100a:	60e2                	ld	ra,24(sp)
    100c:	6442                	ld	s0,16(sp)
    100e:	6105                	addi	sp,sp,32
    1010:	8082                	ret

0000000000001012 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
    1012:	1101                	addi	sp,sp,-32
    1014:	ec22                	sd	s0,24(sp)
    1016:	1000                	addi	s0,sp,32
    1018:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
    101c:	fe843783          	ld	a5,-24(s0)
    1020:	639c                	ld	a5,0(a5)
    1022:	fe843703          	ld	a4,-24(s0)
    1026:	40f707b3          	sub	a5,a4,a5
    102a:	0017b793          	seqz	a5,a5
    102e:	0ff7f793          	andi	a5,a5,255
    1032:	2781                	sext.w	a5,a5
}
    1034:	853e                	mv	a0,a5
    1036:	6462                	ld	s0,24(sp)
    1038:	6105                	addi	sp,sp,32
    103a:	8082                	ret

000000000000103c <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int processing_time, int period, int n)
{
    103c:	715d                	addi	sp,sp,-80
    103e:	e486                	sd	ra,72(sp)
    1040:	e0a2                	sd	s0,64(sp)
    1042:	0880                	addi	s0,sp,80
    1044:	fca43423          	sd	a0,-56(s0)
    1048:	fcb43023          	sd	a1,-64(s0)
    104c:	87b2                	mv	a5,a2
    104e:	faf42e23          	sw	a5,-68(s0)
    1052:	87b6                	mv	a5,a3
    1054:	faf42c23          	sw	a5,-72(s0)
    1058:	87ba                	mv	a5,a4
    105a:	faf42a23          	sw	a5,-76(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
    105e:	05800513          	li	a0,88
    1062:	00000097          	auipc	ra,0x0
    1066:	d14080e7          	jalr	-748(ra) # d76 <malloc>
    106a:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
    106e:	6505                	lui	a0,0x1
    1070:	00000097          	auipc	ra,0x0
    1074:	d06080e7          	jalr	-762(ra) # d76 <malloc>
    1078:	87aa                	mv	a5,a0
    107a:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
    107e:	fe043703          	ld	a4,-32(s0)
    1082:	6785                	lui	a5,0x1
    1084:	17c1                	addi	a5,a5,-16
    1086:	97ba                	add	a5,a5,a4
    1088:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
    108c:	fe843783          	ld	a5,-24(s0)
    1090:	fc843703          	ld	a4,-56(s0)
    1094:	e398                	sd	a4,0(a5)
    t->arg = arg;
    1096:	fe843783          	ld	a5,-24(s0)
    109a:	fc043703          	ld	a4,-64(s0)
    109e:	e798                	sd	a4,8(a5)
    t->ID = _id++;
    10a0:	00001797          	auipc	a5,0x1
    10a4:	07478793          	addi	a5,a5,116 # 2114 <_id.0>
    10a8:	439c                	lw	a5,0(a5)
    10aa:	0017871b          	addiw	a4,a5,1
    10ae:	0007069b          	sext.w	a3,a4
    10b2:	00001717          	auipc	a4,0x1
    10b6:	06270713          	addi	a4,a4,98 # 2114 <_id.0>
    10ba:	c314                	sw	a3,0(a4)
    10bc:	fe843703          	ld	a4,-24(s0)
    10c0:	d31c                	sw	a5,32(a4)
    t->buf_set = 0;
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	0207ac23          	sw	zero,56(a5)
    t->stack = (void *)new_stack;
    10ca:	fe043703          	ld	a4,-32(s0)
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
    10d4:	fd843703          	ld	a4,-40(s0)
    10d8:	fe843783          	ld	a5,-24(s0)
    10dc:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
    10de:	fe843783          	ld	a5,-24(s0)
    10e2:	fbc42703          	lw	a4,-68(s0)
    10e6:	c3b8                	sw	a4,64(a5)
    t->period = period;
    10e8:	fe843783          	ld	a5,-24(s0)
    10ec:	fb842703          	lw	a4,-72(s0)
    10f0:	c3f8                	sw	a4,68(a5)
    t->n = n;
    10f2:	fe843783          	ld	a5,-24(s0)
    10f6:	fb442703          	lw	a4,-76(s0)
    10fa:	c7b8                	sw	a4,72(a5)
    t->remaining_time = 0;
    10fc:	fe843783          	ld	a5,-24(s0)
    1100:	0407a623          	sw	zero,76(a5)
    t->current_deadline = 0;
    1104:	fe843783          	ld	a5,-24(s0)
    1108:	0407a823          	sw	zero,80(a5)
    return t;
    110c:	fe843783          	ld	a5,-24(s0)
}
    1110:	853e                	mv	a0,a5
    1112:	60a6                	ld	ra,72(sp)
    1114:	6406                	ld	s0,64(sp)
    1116:	6161                	addi	sp,sp,80
    1118:	8082                	ret

000000000000111a <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
    111a:	7179                	addi	sp,sp,-48
    111c:	f406                	sd	ra,40(sp)
    111e:	f022                	sd	s0,32(sp)
    1120:	1800                	addi	s0,sp,48
    1122:	fca43c23          	sd	a0,-40(s0)
    1126:	87ae                	mv	a5,a1
    1128:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    112c:	02000513          	li	a0,32
    1130:	00000097          	auipc	ra,0x0
    1134:	c46080e7          	jalr	-954(ra) # d76 <malloc>
    1138:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    113c:	fe843783          	ld	a5,-24(s0)
    1140:	fd843703          	ld	a4,-40(s0)
    1144:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    1146:	fe843783          	ld	a5,-24(s0)
    114a:	fd442703          	lw	a4,-44(s0)
    114e:	cf98                	sw	a4,24(a5)
    t->current_deadline = arrival_time;
    1150:	fd843783          	ld	a5,-40(s0)
    1154:	fd442703          	lw	a4,-44(s0)
    1158:	cbb8                	sw	a4,80(a5)
    list_add_tail(&new_entry->thread_list, &release_queue);
    115a:	fe843783          	ld	a5,-24(s0)
    115e:	07a1                	addi	a5,a5,8
    1160:	00001597          	auipc	a1,0x1
    1164:	f9858593          	addi	a1,a1,-104 # 20f8 <release_queue>
    1168:	853e                	mv	a0,a5
    116a:	00000097          	auipc	ra,0x0
    116e:	e02080e7          	jalr	-510(ra) # f6c <list_add_tail>
}
    1172:	0001                	nop
    1174:	70a2                	ld	ra,40(sp)
    1176:	7402                	ld	s0,32(sp)
    1178:	6145                	addi	sp,sp,48
    117a:	8082                	ret

000000000000117c <__release>:

void __release()
{
    117c:	7139                	addi	sp,sp,-64
    117e:	fc06                	sd	ra,56(sp)
    1180:	f822                	sd	s0,48(sp)
    1182:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    1184:	00001797          	auipc	a5,0x1
    1188:	f7478793          	addi	a5,a5,-140 # 20f8 <release_queue>
    118c:	639c                	ld	a5,0(a5)
    118e:	fcf43c23          	sd	a5,-40(s0)
    1192:	fd843783          	ld	a5,-40(s0)
    1196:	17e1                	addi	a5,a5,-8
    1198:	fef43423          	sd	a5,-24(s0)
    119c:	fe843783          	ld	a5,-24(s0)
    11a0:	679c                	ld	a5,8(a5)
    11a2:	fcf43823          	sd	a5,-48(s0)
    11a6:	fd043783          	ld	a5,-48(s0)
    11aa:	17e1                	addi	a5,a5,-8
    11ac:	fef43023          	sd	a5,-32(s0)
    11b0:	a851                	j	1244 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
    11b2:	fe843783          	ld	a5,-24(s0)
    11b6:	4f98                	lw	a4,24(a5)
    11b8:	00001797          	auipc	a5,0x1
    11bc:	f8878793          	addi	a5,a5,-120 # 2140 <threading_system_time>
    11c0:	439c                	lw	a5,0(a5)
    11c2:	06e7c363          	blt	a5,a4,1228 <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
    11c6:	fe843783          	ld	a5,-24(s0)
    11ca:	6398                	ld	a4,0(a5)
    11cc:	fe843783          	ld	a5,-24(s0)
    11d0:	639c                	ld	a5,0(a5)
    11d2:	4338                	lw	a4,64(a4)
    11d4:	c7f8                	sw	a4,76(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->period;
    11d6:	fe843783          	ld	a5,-24(s0)
    11da:	4f94                	lw	a3,24(a5)
    11dc:	fe843783          	ld	a5,-24(s0)
    11e0:	639c                	ld	a5,0(a5)
    11e2:	43f8                	lw	a4,68(a5)
    11e4:	fe843783          	ld	a5,-24(s0)
    11e8:	639c                	ld	a5,0(a5)
    11ea:	9f35                	addw	a4,a4,a3
    11ec:	2701                	sext.w	a4,a4
    11ee:	cbb8                	sw	a4,80(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    11f0:	fe843783          	ld	a5,-24(s0)
    11f4:	639c                	ld	a5,0(a5)
    11f6:	02878793          	addi	a5,a5,40
    11fa:	00001597          	auipc	a1,0x1
    11fe:	eee58593          	addi	a1,a1,-274 # 20e8 <run_queue>
    1202:	853e                	mv	a0,a5
    1204:	00000097          	auipc	ra,0x0
    1208:	d68080e7          	jalr	-664(ra) # f6c <list_add_tail>
            list_del(&cur->thread_list);
    120c:	fe843783          	ld	a5,-24(s0)
    1210:	07a1                	addi	a5,a5,8
    1212:	853e                	mv	a0,a5
    1214:	00000097          	auipc	ra,0x0
    1218:	db4080e7          	jalr	-588(ra) # fc8 <list_del>
            free(cur);
    121c:	fe843503          	ld	a0,-24(s0)
    1220:	00000097          	auipc	ra,0x0
    1224:	9b4080e7          	jalr	-1612(ra) # bd4 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    1228:	fe043783          	ld	a5,-32(s0)
    122c:	fef43423          	sd	a5,-24(s0)
    1230:	fe043783          	ld	a5,-32(s0)
    1234:	679c                	ld	a5,8(a5)
    1236:	fcf43423          	sd	a5,-56(s0)
    123a:	fc843783          	ld	a5,-56(s0)
    123e:	17e1                	addi	a5,a5,-8
    1240:	fef43023          	sd	a5,-32(s0)
    1244:	fe843783          	ld	a5,-24(s0)
    1248:	00878713          	addi	a4,a5,8
    124c:	00001797          	auipc	a5,0x1
    1250:	eac78793          	addi	a5,a5,-340 # 20f8 <release_queue>
    1254:	f4f71fe3          	bne	a4,a5,11b2 <__release+0x36>
        }
    }
}
    1258:	0001                	nop
    125a:	0001                	nop
    125c:	70e2                	ld	ra,56(sp)
    125e:	7442                	ld	s0,48(sp)
    1260:	6121                	addi	sp,sp,64
    1262:	8082                	ret

0000000000001264 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    1264:	1101                	addi	sp,sp,-32
    1266:	ec06                	sd	ra,24(sp)
    1268:	e822                	sd	s0,16(sp)
    126a:	1000                	addi	s0,sp,32
    126c:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    1270:	fe843783          	ld	a5,-24(s0)
    1274:	7b98                	ld	a4,48(a5)
    1276:	00001797          	auipc	a5,0x1
    127a:	ec278793          	addi	a5,a5,-318 # 2138 <current>
    127e:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    1280:	fe843783          	ld	a5,-24(s0)
    1284:	02878793          	addi	a5,a5,40
    1288:	853e                	mv	a0,a5
    128a:	00000097          	auipc	ra,0x0
    128e:	d3e080e7          	jalr	-706(ra) # fc8 <list_del>

    free(to_remove->stack);
    1292:	fe843783          	ld	a5,-24(s0)
    1296:	6b9c                	ld	a5,16(a5)
    1298:	853e                	mv	a0,a5
    129a:	00000097          	auipc	ra,0x0
    129e:	93a080e7          	jalr	-1734(ra) # bd4 <free>
    free(to_remove);
    12a2:	fe843503          	ld	a0,-24(s0)
    12a6:	00000097          	auipc	ra,0x0
    12aa:	92e080e7          	jalr	-1746(ra) # bd4 <free>

    __schedule();
    12ae:	00000097          	auipc	ra,0x0
    12b2:	446080e7          	jalr	1094(ra) # 16f4 <__schedule>
    __dispatch();
    12b6:	00000097          	auipc	ra,0x0
    12ba:	2b6080e7          	jalr	694(ra) # 156c <__dispatch>
    thrdresume(main_thrd_id);
    12be:	00001797          	auipc	a5,0x1
    12c2:	e5278793          	addi	a5,a5,-430 # 2110 <main_thrd_id>
    12c6:	439c                	lw	a5,0(a5)
    12c8:	853e                	mv	a0,a5
    12ca:	fffff097          	auipc	ra,0xfffff
    12ce:	41c080e7          	jalr	1052(ra) # 6e6 <thrdresume>
}
    12d2:	0001                	nop
    12d4:	60e2                	ld	ra,24(sp)
    12d6:	6442                	ld	s0,16(sp)
    12d8:	6105                	addi	sp,sp,32
    12da:	8082                	ret

00000000000012dc <thread_exit>:

void thread_exit(void)
{
    12dc:	7179                	addi	sp,sp,-48
    12de:	f406                	sd	ra,40(sp)
    12e0:	f022                	sd	s0,32(sp)
    12e2:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    12e4:	00001797          	auipc	a5,0x1
    12e8:	e5478793          	addi	a5,a5,-428 # 2138 <current>
    12ec:	6398                	ld	a4,0(a5)
    12ee:	00001797          	auipc	a5,0x1
    12f2:	dfa78793          	addi	a5,a5,-518 # 20e8 <run_queue>
    12f6:	02f71063          	bne	a4,a5,1316 <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    12fa:	00001597          	auipc	a1,0x1
    12fe:	cae58593          	addi	a1,a1,-850 # 1fa8 <schedule_rm+0x2f8>
    1302:	4509                	li	a0,2
    1304:	00000097          	auipc	ra,0x0
    1308:	828080e7          	jalr	-2008(ra) # b2c <fprintf>
        exit(1);
    130c:	4505                	li	a0,1
    130e:	fffff097          	auipc	ra,0xfffff
    1312:	330080e7          	jalr	816(ra) # 63e <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    1316:	00001797          	auipc	a5,0x1
    131a:	e2278793          	addi	a5,a5,-478 # 2138 <current>
    131e:	639c                	ld	a5,0(a5)
    1320:	fef43423          	sd	a5,-24(s0)
    1324:	fe843783          	ld	a5,-24(s0)
    1328:	fd878793          	addi	a5,a5,-40
    132c:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    1330:	fe043783          	ld	a5,-32(s0)
    1334:	5fdc                	lw	a5,60(a5)
    1336:	4585                	li	a1,1
    1338:	853e                	mv	a0,a5
    133a:	fffff097          	auipc	ra,0xfffff
    133e:	3b4080e7          	jalr	948(ra) # 6ee <cancelthrdstop>
    1342:	87aa                	mv	a5,a0
    1344:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    1348:	00001797          	auipc	a5,0x1
    134c:	df878793          	addi	a5,a5,-520 # 2140 <threading_system_time>
    1350:	439c                	lw	a5,0(a5)
    1352:	fdc42703          	lw	a4,-36(s0)
    1356:	9fb9                	addw	a5,a5,a4
    1358:	0007871b          	sext.w	a4,a5
    135c:	00001797          	auipc	a5,0x1
    1360:	de478793          	addi	a5,a5,-540 # 2140 <threading_system_time>
    1364:	c398                	sw	a4,0(a5)

    __release();
    1366:	00000097          	auipc	ra,0x0
    136a:	e16080e7          	jalr	-490(ra) # 117c <__release>
    __thread_exit(to_remove);
    136e:	fe043503          	ld	a0,-32(s0)
    1372:	00000097          	auipc	ra,0x0
    1376:	ef2080e7          	jalr	-270(ra) # 1264 <__thread_exit>
}
    137a:	0001                	nop
    137c:	70a2                	ld	ra,40(sp)
    137e:	7402                	ld	s0,32(sp)
    1380:	6145                	addi	sp,sp,48
    1382:	8082                	ret

0000000000001384 <__finish_current>:

void __finish_current()
{
    1384:	7179                	addi	sp,sp,-48
    1386:	f406                	sd	ra,40(sp)
    1388:	f022                	sd	s0,32(sp)
    138a:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    138c:	00001797          	auipc	a5,0x1
    1390:	dac78793          	addi	a5,a5,-596 # 2138 <current>
    1394:	639c                	ld	a5,0(a5)
    1396:	fef43423          	sd	a5,-24(s0)
    139a:	fe843783          	ld	a5,-24(s0)
    139e:	fd878793          	addi	a5,a5,-40
    13a2:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    13a6:	fe043783          	ld	a5,-32(s0)
    13aa:	47bc                	lw	a5,72(a5)
    13ac:	37fd                	addiw	a5,a5,-1
    13ae:	0007871b          	sext.w	a4,a5
    13b2:	fe043783          	ld	a5,-32(s0)
    13b6:	c7b8                	sw	a4,72(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    13b8:	fe043783          	ld	a5,-32(s0)
    13bc:	5398                	lw	a4,32(a5)
    13be:	00001797          	auipc	a5,0x1
    13c2:	d8278793          	addi	a5,a5,-638 # 2140 <threading_system_time>
    13c6:	4390                	lw	a2,0(a5)
    13c8:	fe043783          	ld	a5,-32(s0)
    13cc:	47bc                	lw	a5,72(a5)
    13ce:	86be                	mv	a3,a5
    13d0:	85ba                	mv	a1,a4
    13d2:	00001517          	auipc	a0,0x1
    13d6:	c0e50513          	addi	a0,a0,-1010 # 1fe0 <schedule_rm+0x330>
    13da:	fffff097          	auipc	ra,0xfffff
    13de:	7aa080e7          	jalr	1962(ra) # b84 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    13e2:	fe043783          	ld	a5,-32(s0)
    13e6:	47bc                	lw	a5,72(a5)
    13e8:	04f05563          	blez	a5,1432 <__finish_current+0xae>
        struct list_head *to_remove = current;
    13ec:	00001797          	auipc	a5,0x1
    13f0:	d4c78793          	addi	a5,a5,-692 # 2138 <current>
    13f4:	639c                	ld	a5,0(a5)
    13f6:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    13fa:	00001797          	auipc	a5,0x1
    13fe:	d3e78793          	addi	a5,a5,-706 # 2138 <current>
    1402:	639c                	ld	a5,0(a5)
    1404:	6798                	ld	a4,8(a5)
    1406:	00001797          	auipc	a5,0x1
    140a:	d3278793          	addi	a5,a5,-718 # 2138 <current>
    140e:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1410:	fd843503          	ld	a0,-40(s0)
    1414:	00000097          	auipc	ra,0x0
    1418:	bb4080e7          	jalr	-1100(ra) # fc8 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    141c:	fe043783          	ld	a5,-32(s0)
    1420:	4bbc                	lw	a5,80(a5)
    1422:	85be                	mv	a1,a5
    1424:	fe043503          	ld	a0,-32(s0)
    1428:	00000097          	auipc	ra,0x0
    142c:	cf2080e7          	jalr	-782(ra) # 111a <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    1430:	a039                	j	143e <__finish_current+0xba>
        __thread_exit(current_thread);
    1432:	fe043503          	ld	a0,-32(s0)
    1436:	00000097          	auipc	ra,0x0
    143a:	e2e080e7          	jalr	-466(ra) # 1264 <__thread_exit>
}
    143e:	0001                	nop
    1440:	70a2                	ld	ra,40(sp)
    1442:	7402                	ld	s0,32(sp)
    1444:	6145                	addi	sp,sp,48
    1446:	8082                	ret

0000000000001448 <switch_handler>:

void switch_handler(void *arg)
{
    1448:	7139                	addi	sp,sp,-64
    144a:	fc06                	sd	ra,56(sp)
    144c:	f822                	sd	s0,48(sp)
    144e:	0080                	addi	s0,sp,64
    1450:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    1454:	fc843783          	ld	a5,-56(s0)
    1458:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    145c:	00001797          	auipc	a5,0x1
    1460:	cdc78793          	addi	a5,a5,-804 # 2138 <current>
    1464:	639c                	ld	a5,0(a5)
    1466:	fef43023          	sd	a5,-32(s0)
    146a:	fe043783          	ld	a5,-32(s0)
    146e:	fd878793          	addi	a5,a5,-40
    1472:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    1476:	fe843783          	ld	a5,-24(s0)
    147a:	0007871b          	sext.w	a4,a5
    147e:	00001797          	auipc	a5,0x1
    1482:	cc278793          	addi	a5,a5,-830 # 2140 <threading_system_time>
    1486:	439c                	lw	a5,0(a5)
    1488:	2781                	sext.w	a5,a5
    148a:	9fb9                	addw	a5,a5,a4
    148c:	2781                	sext.w	a5,a5
    148e:	0007871b          	sext.w	a4,a5
    1492:	00001797          	auipc	a5,0x1
    1496:	cae78793          	addi	a5,a5,-850 # 2140 <threading_system_time>
    149a:	c398                	sw	a4,0(a5)
     __release();
    149c:	00000097          	auipc	ra,0x0
    14a0:	ce0080e7          	jalr	-800(ra) # 117c <__release>
    current_thread->remaining_time -= elapsed_time;
    14a4:	fd843783          	ld	a5,-40(s0)
    14a8:	47fc                	lw	a5,76(a5)
    14aa:	0007871b          	sext.w	a4,a5
    14ae:	fe843783          	ld	a5,-24(s0)
    14b2:	2781                	sext.w	a5,a5
    14b4:	40f707bb          	subw	a5,a4,a5
    14b8:	2781                	sext.w	a5,a5
    14ba:	0007871b          	sext.w	a4,a5
    14be:	fd843783          	ld	a5,-40(s0)
    14c2:	c7f8                	sw	a4,76(a5)

    if (threading_system_time > current_thread->current_deadline || 
    14c4:	fd843783          	ld	a5,-40(s0)
    14c8:	4bb8                	lw	a4,80(a5)
    14ca:	00001797          	auipc	a5,0x1
    14ce:	c7678793          	addi	a5,a5,-906 # 2140 <threading_system_time>
    14d2:	439c                	lw	a5,0(a5)
    14d4:	02f74163          	blt	a4,a5,14f6 <switch_handler+0xae>
        (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    14d8:	fd843783          	ld	a5,-40(s0)
    14dc:	4bb8                	lw	a4,80(a5)
    14de:	00001797          	auipc	a5,0x1
    14e2:	c6278793          	addi	a5,a5,-926 # 2140 <threading_system_time>
    14e6:	439c                	lw	a5,0(a5)
    if (threading_system_time > current_thread->current_deadline || 
    14e8:	02f71e63          	bne	a4,a5,1524 <switch_handler+0xdc>
        (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    14ec:	fd843783          	ld	a5,-40(s0)
    14f0:	47fc                	lw	a5,76(a5)
    14f2:	02f05963          	blez	a5,1524 <switch_handler+0xdc>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
    14f6:	fd843783          	ld	a5,-40(s0)
    14fa:	5398                	lw	a4,32(a5)
    14fc:	00001797          	auipc	a5,0x1
    1500:	c4478793          	addi	a5,a5,-956 # 2140 <threading_system_time>
    1504:	439c                	lw	a5,0(a5)
    1506:	863e                	mv	a2,a5
    1508:	85ba                	mv	a1,a4
    150a:	00001517          	auipc	a0,0x1
    150e:	b0e50513          	addi	a0,a0,-1266 # 2018 <schedule_rm+0x368>
    1512:	fffff097          	auipc	ra,0xfffff
    1516:	672080e7          	jalr	1650(ra) # b84 <printf>
        exit(0);
    151a:	4501                	li	a0,0
    151c:	fffff097          	auipc	ra,0xfffff
    1520:	122080e7          	jalr	290(ra) # 63e <exit>
    }

    if (current_thread->remaining_time <= 0) {
    1524:	fd843783          	ld	a5,-40(s0)
    1528:	47fc                	lw	a5,76(a5)
    152a:	00f04663          	bgtz	a5,1536 <switch_handler+0xee>
        __finish_current();
    152e:	00000097          	auipc	ra,0x0
    1532:	e56080e7          	jalr	-426(ra) # 1384 <__finish_current>
    }

    __release();
    1536:	00000097          	auipc	ra,0x0
    153a:	c46080e7          	jalr	-954(ra) # 117c <__release>
    __schedule();
    153e:	00000097          	auipc	ra,0x0
    1542:	1b6080e7          	jalr	438(ra) # 16f4 <__schedule>
    __dispatch();
    1546:	00000097          	auipc	ra,0x0
    154a:	026080e7          	jalr	38(ra) # 156c <__dispatch>
    thrdresume(main_thrd_id);
    154e:	00001797          	auipc	a5,0x1
    1552:	bc278793          	addi	a5,a5,-1086 # 2110 <main_thrd_id>
    1556:	439c                	lw	a5,0(a5)
    1558:	853e                	mv	a0,a5
    155a:	fffff097          	auipc	ra,0xfffff
    155e:	18c080e7          	jalr	396(ra) # 6e6 <thrdresume>
}
    1562:	0001                	nop
    1564:	70e2                	ld	ra,56(sp)
    1566:	7442                	ld	s0,48(sp)
    1568:	6121                	addi	sp,sp,64
    156a:	8082                	ret

000000000000156c <__dispatch>:

void __dispatch()
{
    156c:	7179                	addi	sp,sp,-48
    156e:	f406                	sd	ra,40(sp)
    1570:	f022                	sd	s0,32(sp)
    1572:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    1574:	00001797          	auipc	a5,0x1
    1578:	bc478793          	addi	a5,a5,-1084 # 2138 <current>
    157c:	6398                	ld	a4,0(a5)
    157e:	00001797          	auipc	a5,0x1
    1582:	b6a78793          	addi	a5,a5,-1174 # 20e8 <run_queue>
    1586:	16f70263          	beq	a4,a5,16ea <__dispatch+0x17e>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    158a:	00001797          	auipc	a5,0x1
    158e:	bae78793          	addi	a5,a5,-1106 # 2138 <current>
    1592:	639c                	ld	a5,0(a5)
    1594:	fef43423          	sd	a5,-24(s0)
    1598:	fe843783          	ld	a5,-24(s0)
    159c:	fd878793          	addi	a5,a5,-40
    15a0:	fef43023          	sd	a5,-32(s0)
     if (allocated_time == 0) { // miss deadline, abort
    15a4:	00001797          	auipc	a5,0x1
    15a8:	ba478793          	addi	a5,a5,-1116 # 2148 <allocated_time>
    15ac:	639c                	ld	a5,0(a5)
    15ae:	e795                	bnez	a5,15da <__dispatch+0x6e>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
    15b0:	fe043783          	ld	a5,-32(s0)
    15b4:	5398                	lw	a4,32(a5)
    15b6:	fe043783          	ld	a5,-32(s0)
    15ba:	4bbc                	lw	a5,80(a5)
    15bc:	863e                	mv	a2,a5
    15be:	85ba                	mv	a1,a4
    15c0:	00001517          	auipc	a0,0x1
    15c4:	a5850513          	addi	a0,a0,-1448 # 2018 <schedule_rm+0x368>
    15c8:	fffff097          	auipc	ra,0xfffff
    15cc:	5bc080e7          	jalr	1468(ra) # b84 <printf>
        exit(0);
    15d0:	4501                	li	a0,0
    15d2:	fffff097          	auipc	ra,0xfffff
    15d6:	06c080e7          	jalr	108(ra) # 63e <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    15da:	fe043783          	ld	a5,-32(s0)
    15de:	5398                	lw	a4,32(a5)
    15e0:	00001797          	auipc	a5,0x1
    15e4:	b6078793          	addi	a5,a5,-1184 # 2140 <threading_system_time>
    15e8:	4390                	lw	a2,0(a5)
    15ea:	00001797          	auipc	a5,0x1
    15ee:	b5e78793          	addi	a5,a5,-1186 # 2148 <allocated_time>
    15f2:	639c                	ld	a5,0(a5)
    15f4:	86be                	mv	a3,a5
    15f6:	85ba                	mv	a1,a4
    15f8:	00001517          	auipc	a0,0x1
    15fc:	a4850513          	addi	a0,a0,-1464 # 2040 <schedule_rm+0x390>
    1600:	fffff097          	auipc	ra,0xfffff
    1604:	584080e7          	jalr	1412(ra) # b84 <printf>

    if (current_thread->buf_set) {
    1608:	fe043783          	ld	a5,-32(s0)
    160c:	5f9c                	lw	a5,56(a5)
    160e:	c7a1                	beqz	a5,1656 <__dispatch+0xea>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1610:	00001797          	auipc	a5,0x1
    1614:	b3878793          	addi	a5,a5,-1224 # 2148 <allocated_time>
    1618:	639c                	ld	a5,0(a5)
    161a:	0007871b          	sext.w	a4,a5
    161e:	fe043783          	ld	a5,-32(s0)
    1622:	03c78593          	addi	a1,a5,60
    1626:	00001797          	auipc	a5,0x1
    162a:	b2278793          	addi	a5,a5,-1246 # 2148 <allocated_time>
    162e:	639c                	ld	a5,0(a5)
    1630:	86be                	mv	a3,a5
    1632:	00000617          	auipc	a2,0x0
    1636:	e1660613          	addi	a2,a2,-490 # 1448 <switch_handler>
    163a:	853a                	mv	a0,a4
    163c:	fffff097          	auipc	ra,0xfffff
    1640:	0a2080e7          	jalr	162(ra) # 6de <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    1644:	fe043783          	ld	a5,-32(s0)
    1648:	5fdc                	lw	a5,60(a5)
    164a:	853e                	mv	a0,a5
    164c:	fffff097          	auipc	ra,0xfffff
    1650:	09a080e7          	jalr	154(ra) # 6e6 <thrdresume>
    1654:	a071                	j	16e0 <__dispatch+0x174>
    } else {
        current_thread->buf_set = 1;
    1656:	fe043783          	ld	a5,-32(s0)
    165a:	4705                	li	a4,1
    165c:	df98                	sw	a4,56(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    165e:	fe043783          	ld	a5,-32(s0)
    1662:	6f9c                	ld	a5,24(a5)
    1664:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    1668:	fe043783          	ld	a5,-32(s0)
    166c:	577d                	li	a4,-1
    166e:	dfd8                	sw	a4,60(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1670:	00001797          	auipc	a5,0x1
    1674:	ad878793          	addi	a5,a5,-1320 # 2148 <allocated_time>
    1678:	639c                	ld	a5,0(a5)
    167a:	0007871b          	sext.w	a4,a5
    167e:	fe043783          	ld	a5,-32(s0)
    1682:	03c78593          	addi	a1,a5,60
    1686:	00001797          	auipc	a5,0x1
    168a:	ac278793          	addi	a5,a5,-1342 # 2148 <allocated_time>
    168e:	639c                	ld	a5,0(a5)
    1690:	86be                	mv	a3,a5
    1692:	00000617          	auipc	a2,0x0
    1696:	db660613          	addi	a2,a2,-586 # 1448 <switch_handler>
    169a:	853a                	mv	a0,a4
    169c:	fffff097          	auipc	ra,0xfffff
    16a0:	042080e7          	jalr	66(ra) # 6de <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
    16a4:	fe043783          	ld	a5,-32(s0)
    16a8:	5fdc                	lw	a5,60(a5)
    16aa:	0207d063          	bgez	a5,16ca <__dispatch+0x15e>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    16ae:	00001597          	auipc	a1,0x1
    16b2:	9c258593          	addi	a1,a1,-1598 # 2070 <schedule_rm+0x3c0>
    16b6:	4509                	li	a0,2
    16b8:	fffff097          	auipc	ra,0xfffff
    16bc:	474080e7          	jalr	1140(ra) # b2c <fprintf>
            exit(1);
    16c0:	4505                	li	a0,1
    16c2:	fffff097          	auipc	ra,0xfffff
    16c6:	f7c080e7          	jalr	-132(ra) # 63e <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    16ca:	fd843783          	ld	a5,-40(s0)
    16ce:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    16d0:	fe043783          	ld	a5,-32(s0)
    16d4:	6398                	ld	a4,0(a5)
    16d6:	fe043783          	ld	a5,-32(s0)
    16da:	679c                	ld	a5,8(a5)
    16dc:	853e                	mv	a0,a5
    16de:	9702                	jalr	a4
    }
    thread_exit();
    16e0:	00000097          	auipc	ra,0x0
    16e4:	bfc080e7          	jalr	-1028(ra) # 12dc <thread_exit>
    16e8:	a011                	j	16ec <__dispatch+0x180>
        return;
    16ea:	0001                	nop
}
    16ec:	70a2                	ld	ra,40(sp)
    16ee:	7402                	ld	s0,32(sp)
    16f0:	6145                	addi	sp,sp,48
    16f2:	8082                	ret

00000000000016f4 <__schedule>:

void __schedule(void)
{
    16f4:	711d                	addi	sp,sp,-96
    16f6:	ec86                	sd	ra,88(sp)
    16f8:	e8a2                	sd	s0,80(sp)
    16fa:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    16fc:	00001797          	auipc	a5,0x1
    1700:	a4478793          	addi	a5,a5,-1468 # 2140 <threading_system_time>
    1704:	439c                	lw	a5,0(a5)
    1706:	fcf42c23          	sw	a5,-40(s0)
    170a:	00001797          	auipc	a5,0x1
    170e:	9de78793          	addi	a5,a5,-1570 # 20e8 <run_queue>
    1712:	fef43023          	sd	a5,-32(s0)
    1716:	00001797          	auipc	a5,0x1
    171a:	9e278793          	addi	a5,a5,-1566 # 20f8 <release_queue>
    171e:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_EDF
    r = schedule_edf(args);
#endif

#ifdef THREAD_SCHEDULER_RM
    r = schedule_rm(args);
    1722:	fd843783          	ld	a5,-40(s0)
    1726:	faf43023          	sd	a5,-96(s0)
    172a:	fe043783          	ld	a5,-32(s0)
    172e:	faf43423          	sd	a5,-88(s0)
    1732:	fe843783          	ld	a5,-24(s0)
    1736:	faf43823          	sd	a5,-80(s0)
    173a:	fa040793          	addi	a5,s0,-96
    173e:	853e                	mv	a0,a5
    1740:	00000097          	auipc	ra,0x0
    1744:	570080e7          	jalr	1392(ra) # 1cb0 <schedule_rm>
    1748:	872a                	mv	a4,a0
    174a:	87ae                	mv	a5,a1
    174c:	fce43423          	sd	a4,-56(s0)
    1750:	fcf43823          	sd	a5,-48(s0)
#endif

    current = r.scheduled_thread_list_member;
    1754:	fc843703          	ld	a4,-56(s0)
    1758:	00001797          	auipc	a5,0x1
    175c:	9e078793          	addi	a5,a5,-1568 # 2138 <current>
    1760:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    1762:	fd042783          	lw	a5,-48(s0)
    1766:	873e                	mv	a4,a5
    1768:	00001797          	auipc	a5,0x1
    176c:	9e078793          	addi	a5,a5,-1568 # 2148 <allocated_time>
    1770:	e398                	sd	a4,0(a5)
}
    1772:	0001                	nop
    1774:	60e6                	ld	ra,88(sp)
    1776:	6446                	ld	s0,80(sp)
    1778:	6125                	addi	sp,sp,96
    177a:	8082                	ret

000000000000177c <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    177c:	1101                	addi	sp,sp,-32
    177e:	ec06                	sd	ra,24(sp)
    1780:	e822                	sd	s0,16(sp)
    1782:	1000                	addi	s0,sp,32
    1784:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    1788:	00001797          	auipc	a5,0x1
    178c:	9bc78793          	addi	a5,a5,-1604 # 2144 <sleeping>
    1790:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    1794:	fe843783          	ld	a5,-24(s0)
    1798:	0007871b          	sext.w	a4,a5
    179c:	00001797          	auipc	a5,0x1
    17a0:	9a478793          	addi	a5,a5,-1628 # 2140 <threading_system_time>
    17a4:	439c                	lw	a5,0(a5)
    17a6:	2781                	sext.w	a5,a5
    17a8:	9fb9                	addw	a5,a5,a4
    17aa:	2781                	sext.w	a5,a5
    17ac:	0007871b          	sext.w	a4,a5
    17b0:	00001797          	auipc	a5,0x1
    17b4:	99078793          	addi	a5,a5,-1648 # 2140 <threading_system_time>
    17b8:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    17ba:	00001797          	auipc	a5,0x1
    17be:	95678793          	addi	a5,a5,-1706 # 2110 <main_thrd_id>
    17c2:	439c                	lw	a5,0(a5)
    17c4:	853e                	mv	a0,a5
    17c6:	fffff097          	auipc	ra,0xfffff
    17ca:	f20080e7          	jalr	-224(ra) # 6e6 <thrdresume>
}
    17ce:	0001                	nop
    17d0:	60e2                	ld	ra,24(sp)
    17d2:	6442                	ld	s0,16(sp)
    17d4:	6105                	addi	sp,sp,32
    17d6:	8082                	ret

00000000000017d8 <thread_start_threading>:

void thread_start_threading()
{
    17d8:	1141                	addi	sp,sp,-16
    17da:	e406                	sd	ra,8(sp)
    17dc:	e022                	sd	s0,0(sp)
    17de:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    17e0:	00001797          	auipc	a5,0x1
    17e4:	96078793          	addi	a5,a5,-1696 # 2140 <threading_system_time>
    17e8:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    17ec:	00001797          	auipc	a5,0x1
    17f0:	94c78793          	addi	a5,a5,-1716 # 2138 <current>
    17f4:	00001717          	auipc	a4,0x1
    17f8:	8f470713          	addi	a4,a4,-1804 # 20e8 <run_queue>
    17fc:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    17fe:	4681                	li	a3,0
    1800:	00000617          	auipc	a2,0x0
    1804:	f7c60613          	addi	a2,a2,-132 # 177c <back_to_main_handler>
    1808:	00001597          	auipc	a1,0x1
    180c:	90858593          	addi	a1,a1,-1784 # 2110 <main_thrd_id>
    1810:	3e800513          	li	a0,1000
    1814:	fffff097          	auipc	ra,0xfffff
    1818:	eca080e7          	jalr	-310(ra) # 6de <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    181c:	00001797          	auipc	a5,0x1
    1820:	8f478793          	addi	a5,a5,-1804 # 2110 <main_thrd_id>
    1824:	439c                	lw	a5,0(a5)
    1826:	4581                	li	a1,0
    1828:	853e                	mv	a0,a5
    182a:	fffff097          	auipc	ra,0xfffff
    182e:	ec4080e7          	jalr	-316(ra) # 6ee <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    1832:	a0c9                	j	18f4 <thread_start_threading+0x11c>
        __release();
    1834:	00000097          	auipc	ra,0x0
    1838:	948080e7          	jalr	-1720(ra) # 117c <__release>
        __schedule();
    183c:	00000097          	auipc	ra,0x0
    1840:	eb8080e7          	jalr	-328(ra) # 16f4 <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    1844:	00001797          	auipc	a5,0x1
    1848:	8cc78793          	addi	a5,a5,-1844 # 2110 <main_thrd_id>
    184c:	439c                	lw	a5,0(a5)
    184e:	4581                	li	a1,0
    1850:	853e                	mv	a0,a5
    1852:	fffff097          	auipc	ra,0xfffff
    1856:	e9c080e7          	jalr	-356(ra) # 6ee <cancelthrdstop>
        __dispatch();
    185a:	00000097          	auipc	ra,0x0
    185e:	d12080e7          	jalr	-750(ra) # 156c <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
    1862:	00001517          	auipc	a0,0x1
    1866:	88650513          	addi	a0,a0,-1914 # 20e8 <run_queue>
    186a:	fffff097          	auipc	ra,0xfffff
    186e:	7a8080e7          	jalr	1960(ra) # 1012 <list_empty>
    1872:	87aa                	mv	a5,a0
    1874:	cb99                	beqz	a5,188a <thread_start_threading+0xb2>
    1876:	00001517          	auipc	a0,0x1
    187a:	88250513          	addi	a0,a0,-1918 # 20f8 <release_queue>
    187e:	fffff097          	auipc	ra,0xfffff
    1882:	794080e7          	jalr	1940(ra) # 1012 <list_empty>
    1886:	87aa                	mv	a5,a0
    1888:	ebd9                	bnez	a5,191e <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    188a:	00001797          	auipc	a5,0x1
    188e:	8be78793          	addi	a5,a5,-1858 # 2148 <allocated_time>
    1892:	639c                	ld	a5,0(a5)
    1894:	85be                	mv	a1,a5
    1896:	00001517          	auipc	a0,0x1
    189a:	81250513          	addi	a0,a0,-2030 # 20a8 <schedule_rm+0x3f8>
    189e:	fffff097          	auipc	ra,0xfffff
    18a2:	2e6080e7          	jalr	742(ra) # b84 <printf>
        sleeping = 1;
    18a6:	00001797          	auipc	a5,0x1
    18aa:	89e78793          	addi	a5,a5,-1890 # 2144 <sleeping>
    18ae:	4705                	li	a4,1
    18b0:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    18b2:	00001797          	auipc	a5,0x1
    18b6:	89678793          	addi	a5,a5,-1898 # 2148 <allocated_time>
    18ba:	639c                	ld	a5,0(a5)
    18bc:	0007871b          	sext.w	a4,a5
    18c0:	00001797          	auipc	a5,0x1
    18c4:	88878793          	addi	a5,a5,-1912 # 2148 <allocated_time>
    18c8:	639c                	ld	a5,0(a5)
    18ca:	86be                	mv	a3,a5
    18cc:	00000617          	auipc	a2,0x0
    18d0:	eb060613          	addi	a2,a2,-336 # 177c <back_to_main_handler>
    18d4:	00001597          	auipc	a1,0x1
    18d8:	83c58593          	addi	a1,a1,-1988 # 2110 <main_thrd_id>
    18dc:	853a                	mv	a0,a4
    18de:	fffff097          	auipc	ra,0xfffff
    18e2:	e00080e7          	jalr	-512(ra) # 6de <thrdstop>
        while (sleeping) {
    18e6:	0001                	nop
    18e8:	00001797          	auipc	a5,0x1
    18ec:	85c78793          	addi	a5,a5,-1956 # 2144 <sleeping>
    18f0:	439c                	lw	a5,0(a5)
    18f2:	fbfd                	bnez	a5,18e8 <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    18f4:	00000517          	auipc	a0,0x0
    18f8:	7f450513          	addi	a0,a0,2036 # 20e8 <run_queue>
    18fc:	fffff097          	auipc	ra,0xfffff
    1900:	716080e7          	jalr	1814(ra) # 1012 <list_empty>
    1904:	87aa                	mv	a5,a0
    1906:	d79d                	beqz	a5,1834 <thread_start_threading+0x5c>
    1908:	00000517          	auipc	a0,0x0
    190c:	7f050513          	addi	a0,a0,2032 # 20f8 <release_queue>
    1910:	fffff097          	auipc	ra,0xfffff
    1914:	702080e7          	jalr	1794(ra) # 1012 <list_empty>
    1918:	87aa                	mv	a5,a0
    191a:	df89                	beqz	a5,1834 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
    191c:	a011                	j	1920 <thread_start_threading+0x148>
            break;
    191e:	0001                	nop
}
    1920:	0001                	nop
    1922:	60a2                	ld	ra,8(sp)
    1924:	6402                	ld	s0,0(sp)
    1926:	0141                	addi	sp,sp,16
    1928:	8082                	ret

000000000000192a <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    192a:	715d                	addi	sp,sp,-80
    192c:	e4a2                	sd	s0,72(sp)
    192e:	e0a6                	sd	s1,64(sp)
    1930:	0880                	addi	s0,sp,80
    1932:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1934:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1938:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    193c:	649c                	ld	a5,8(s1)
    193e:	639c                	ld	a5,0(a5)
    1940:	fcf43c23          	sd	a5,-40(s0)
    1944:	fd843783          	ld	a5,-40(s0)
    1948:	fd878793          	addi	a5,a5,-40
    194c:	fef43023          	sd	a5,-32(s0)
    1950:	a81d                	j	1986 <schedule_default+0x5c>
    {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1952:	fe843783          	ld	a5,-24(s0)
    1956:	cb89                	beqz	a5,1968 <schedule_default+0x3e>
    1958:	fe043783          	ld	a5,-32(s0)
    195c:	5398                	lw	a4,32(a5)
    195e:	fe843783          	ld	a5,-24(s0)
    1962:	539c                	lw	a5,32(a5)
    1964:	00f75663          	bge	a4,a5,1970 <schedule_default+0x46>
        {
            thread_with_smallest_id = th;
    1968:	fe043783          	ld	a5,-32(s0)
    196c:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1970:	fe043783          	ld	a5,-32(s0)
    1974:	779c                	ld	a5,40(a5)
    1976:	fcf43823          	sd	a5,-48(s0)
    197a:	fd043783          	ld	a5,-48(s0)
    197e:	fd878793          	addi	a5,a5,-40
    1982:	fef43023          	sd	a5,-32(s0)
    1986:	fe043783          	ld	a5,-32(s0)
    198a:	02878713          	addi	a4,a5,40
    198e:	649c                	ld	a5,8(s1)
    1990:	fcf711e3          	bne	a4,a5,1952 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL)
    1994:	fe843783          	ld	a5,-24(s0)
    1998:	cf89                	beqz	a5,19b2 <schedule_default+0x88>
    {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    199a:	fe843783          	ld	a5,-24(s0)
    199e:	02878793          	addi	a5,a5,40
    19a2:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    19a6:	fe843783          	ld	a5,-24(s0)
    19aa:	47fc                	lw	a5,76(a5)
    19ac:	faf42c23          	sw	a5,-72(s0)
    19b0:	a039                	j	19be <schedule_default+0x94>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    19b2:	649c                	ld	a5,8(s1)
    19b4:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    19b8:	4785                	li	a5,1
    19ba:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    19be:	fb043783          	ld	a5,-80(s0)
    19c2:	fcf43023          	sd	a5,-64(s0)
    19c6:	fb843783          	ld	a5,-72(s0)
    19ca:	fcf43423          	sd	a5,-56(s0)
    19ce:	fc043703          	ld	a4,-64(s0)
    19d2:	fc843783          	ld	a5,-56(s0)
    19d6:	863a                	mv	a2,a4
    19d8:	86be                	mv	a3,a5
    19da:	8732                	mv	a4,a2
    19dc:	87b6                	mv	a5,a3
}
    19de:	853a                	mv	a0,a4
    19e0:	85be                	mv	a1,a5
    19e2:	6426                	ld	s0,72(sp)
    19e4:	6486                	ld	s1,64(sp)
    19e6:	6161                	addi	sp,sp,80
    19e8:	8082                	ret

00000000000019ea <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    19ea:	7135                	addi	sp,sp,-160
    19ec:	ed22                	sd	s0,152(sp)
    19ee:	e926                	sd	s1,144(sp)
    19f0:	1100                	addi	s0,sp,160
    19f2:	84aa                	mv	s1,a0
    struct thread *to_be_run = NULL;
    19f4:	fe043423          	sd	zero,-24(s0)
    struct thread *to_be_ret = NULL;
    19f8:	fe043023          	sd	zero,-32(s0)
    struct thread *i = NULL;
    19fc:	fc043c23          	sd	zero,-40(s0)
    list_for_each_entry(i, args.run_queue, thread_list)
    1a00:	649c                	ld	a5,8(s1)
    1a02:	639c                	ld	a5,0(a5)
    1a04:	faf43423          	sd	a5,-88(s0)
    1a08:	fa843783          	ld	a5,-88(s0)
    1a0c:	fd878793          	addi	a5,a5,-40
    1a10:	fcf43c23          	sd	a5,-40(s0)
    1a14:	a041                	j	1a94 <schedule_edf+0xaa>
    {
        if (i->current_deadline <= args.current_time)
    1a16:	fd843783          	ld	a5,-40(s0)
    1a1a:	4bb8                	lw	a4,80(a5)
    1a1c:	409c                	lw	a5,0(s1)
    1a1e:	02e7c163          	blt	a5,a4,1a40 <schedule_edf+0x56>
        {
            if (to_be_ret == NULL || i->ID < to_be_ret->ID)
    1a22:	fe043783          	ld	a5,-32(s0)
    1a26:	cb89                	beqz	a5,1a38 <schedule_edf+0x4e>
    1a28:	fd843783          	ld	a5,-40(s0)
    1a2c:	5398                	lw	a4,32(a5)
    1a2e:	fe043783          	ld	a5,-32(s0)
    1a32:	539c                	lw	a5,32(a5)
    1a34:	00f75663          	bge	a4,a5,1a40 <schedule_edf+0x56>
                to_be_ret = i;
    1a38:	fd843783          	ld	a5,-40(s0)
    1a3c:	fef43023          	sd	a5,-32(s0)
        }
        if (to_be_run == NULL || i->current_deadline < to_be_run->current_deadline || (i->current_deadline == to_be_run->current_deadline && i->ID < to_be_run->ID))
    1a40:	fe843783          	ld	a5,-24(s0)
    1a44:	cb8d                	beqz	a5,1a76 <schedule_edf+0x8c>
    1a46:	fd843783          	ld	a5,-40(s0)
    1a4a:	4bb8                	lw	a4,80(a5)
    1a4c:	fe843783          	ld	a5,-24(s0)
    1a50:	4bbc                	lw	a5,80(a5)
    1a52:	02f74263          	blt	a4,a5,1a76 <schedule_edf+0x8c>
    1a56:	fd843783          	ld	a5,-40(s0)
    1a5a:	4bb8                	lw	a4,80(a5)
    1a5c:	fe843783          	ld	a5,-24(s0)
    1a60:	4bbc                	lw	a5,80(a5)
    1a62:	00f71e63          	bne	a4,a5,1a7e <schedule_edf+0x94>
    1a66:	fd843783          	ld	a5,-40(s0)
    1a6a:	5398                	lw	a4,32(a5)
    1a6c:	fe843783          	ld	a5,-24(s0)
    1a70:	539c                	lw	a5,32(a5)
    1a72:	00f75663          	bge	a4,a5,1a7e <schedule_edf+0x94>
        {
            to_be_run = i;
    1a76:	fd843783          	ld	a5,-40(s0)
    1a7a:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(i, args.run_queue, thread_list)
    1a7e:	fd843783          	ld	a5,-40(s0)
    1a82:	779c                	ld	a5,40(a5)
    1a84:	f8f43023          	sd	a5,-128(s0)
    1a88:	f8043783          	ld	a5,-128(s0)
    1a8c:	fd878793          	addi	a5,a5,-40
    1a90:	fcf43c23          	sd	a5,-40(s0)
    1a94:	fd843783          	ld	a5,-40(s0)
    1a98:	02878713          	addi	a4,a5,40
    1a9c:	649c                	ld	a5,8(s1)
    1a9e:	f6f71ce3          	bne	a4,a5,1a16 <schedule_edf+0x2c>
        }
    }
    struct threads_sched_result ret;
    if (to_be_ret != NULL)
    1aa2:	fe043783          	ld	a5,-32(s0)
    1aa6:	cb91                	beqz	a5,1aba <schedule_edf+0xd0>
    {
        ret.scheduled_thread_list_member = &to_be_ret->thread_list;
    1aa8:	fe043783          	ld	a5,-32(s0)
    1aac:	02878793          	addi	a5,a5,40
    1ab0:	f6f43023          	sd	a5,-160(s0)
        ret.allocated_time = 0;
    1ab4:	f6042423          	sw	zero,-152(s0)
    1ab8:	a2f1                	j	1c84 <schedule_edf+0x29a>
    }
    else if (to_be_run == NULL)
    1aba:	fe843783          	ld	a5,-24(s0)
    1abe:	efa5                	bnez	a5,1b36 <schedule_edf+0x14c>
    {
        int min = 10001;
    1ac0:	6789                	lui	a5,0x2
    1ac2:	71178793          	addi	a5,a5,1809 # 2711 <__BSS_END__+0x5c1>
    1ac6:	fcf42a23          	sw	a5,-44(s0)
        struct release_queue_entry *j = NULL;
    1aca:	fc043423          	sd	zero,-56(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1ace:	689c                	ld	a5,16(s1)
    1ad0:	639c                	ld	a5,0(a5)
    1ad2:	f8f43823          	sd	a5,-112(s0)
    1ad6:	f9043783          	ld	a5,-112(s0)
    1ada:	17e1                	addi	a5,a5,-8
    1adc:	fcf43423          	sd	a5,-56(s0)
    1ae0:	a805                	j	1b10 <schedule_edf+0x126>
        {
            if (j->release_time < min)
    1ae2:	fc843783          	ld	a5,-56(s0)
    1ae6:	4f98                	lw	a4,24(a5)
    1ae8:	fd442783          	lw	a5,-44(s0)
    1aec:	2781                	sext.w	a5,a5
    1aee:	00f75763          	bge	a4,a5,1afc <schedule_edf+0x112>
                min = j->release_time;
    1af2:	fc843783          	ld	a5,-56(s0)
    1af6:	4f9c                	lw	a5,24(a5)
    1af8:	fcf42a23          	sw	a5,-44(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1afc:	fc843783          	ld	a5,-56(s0)
    1b00:	679c                	ld	a5,8(a5)
    1b02:	f8f43423          	sd	a5,-120(s0)
    1b06:	f8843783          	ld	a5,-120(s0)
    1b0a:	17e1                	addi	a5,a5,-8
    1b0c:	fcf43423          	sd	a5,-56(s0)
    1b10:	fc843783          	ld	a5,-56(s0)
    1b14:	00878713          	addi	a4,a5,8
    1b18:	689c                	ld	a5,16(s1)
    1b1a:	fcf714e3          	bne	a4,a5,1ae2 <schedule_edf+0xf8>
        }
        ret.scheduled_thread_list_member = args.run_queue;
    1b1e:	649c                	ld	a5,8(s1)
    1b20:	f6f43023          	sd	a5,-160(s0)
        ret.allocated_time = min - args.current_time;
    1b24:	409c                	lw	a5,0(s1)
    1b26:	fd442703          	lw	a4,-44(s0)
    1b2a:	40f707bb          	subw	a5,a4,a5
    1b2e:	2781                	sext.w	a5,a5
    1b30:	f6f42423          	sw	a5,-152(s0)
    1b34:	aa81                	j	1c84 <schedule_edf+0x29a>
    }
    else
    {
        ret.scheduled_thread_list_member = &to_be_run->thread_list;
    1b36:	fe843783          	ld	a5,-24(s0)
    1b3a:	02878793          	addi	a5,a5,40
    1b3e:	f6f43023          	sd	a5,-160(s0)
        int nearest_rel = 10001;
    1b42:	6789                	lui	a5,0x2
    1b44:	71178793          	addi	a5,a5,1809 # 2711 <__BSS_END__+0x5c1>
    1b48:	fcf42223          	sw	a5,-60(s0)
        struct release_queue_entry *j = NULL;
    1b4c:	fa043c23          	sd	zero,-72(s0)
        struct thread *nearest_rel_thrd = NULL;
    1b50:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1b54:	689c                	ld	a5,16(s1)
    1b56:	639c                	ld	a5,0(a5)
    1b58:	faf43023          	sd	a5,-96(s0)
    1b5c:	fa043783          	ld	a5,-96(s0)
    1b60:	17e1                	addi	a5,a5,-8
    1b62:	faf43c23          	sd	a5,-72(s0)
    1b66:	a0c1                	j	1c26 <schedule_edf+0x23c>
        {
            if (((j->release_time + j->thrd->period < to_be_run->current_deadline) || (j->release_time + j->thrd->period == to_be_run->current_deadline && j->thrd->ID < to_be_run->ID)) && (j->release_time < ((args.current_time + to_be_run->remaining_time < to_be_run->current_deadline) ? args.current_time + to_be_run->remaining_time : to_be_run->current_deadline)))
    1b68:	fb843783          	ld	a5,-72(s0)
    1b6c:	4f98                	lw	a4,24(a5)
    1b6e:	fb843783          	ld	a5,-72(s0)
    1b72:	639c                	ld	a5,0(a5)
    1b74:	43fc                	lw	a5,68(a5)
    1b76:	9fb9                	addw	a5,a5,a4
    1b78:	0007871b          	sext.w	a4,a5
    1b7c:	fe843783          	ld	a5,-24(s0)
    1b80:	4bbc                	lw	a5,80(a5)
    1b82:	02f74a63          	blt	a4,a5,1bb6 <schedule_edf+0x1cc>
    1b86:	fb843783          	ld	a5,-72(s0)
    1b8a:	4f98                	lw	a4,24(a5)
    1b8c:	fb843783          	ld	a5,-72(s0)
    1b90:	639c                	ld	a5,0(a5)
    1b92:	43fc                	lw	a5,68(a5)
    1b94:	9fb9                	addw	a5,a5,a4
    1b96:	0007871b          	sext.w	a4,a5
    1b9a:	fe843783          	ld	a5,-24(s0)
    1b9e:	4bbc                	lw	a5,80(a5)
    1ba0:	06f71963          	bne	a4,a5,1c12 <schedule_edf+0x228>
    1ba4:	fb843783          	ld	a5,-72(s0)
    1ba8:	639c                	ld	a5,0(a5)
    1baa:	5398                	lw	a4,32(a5)
    1bac:	fe843783          	ld	a5,-24(s0)
    1bb0:	539c                	lw	a5,32(a5)
    1bb2:	06f75063          	bge	a4,a5,1c12 <schedule_edf+0x228>
    1bb6:	fb843783          	ld	a5,-72(s0)
    1bba:	4f8c                	lw	a1,24(a5)
    1bbc:	fe843783          	ld	a5,-24(s0)
    1bc0:	4ba8                	lw	a0,80(a5)
    1bc2:	4098                	lw	a4,0(s1)
    1bc4:	fe843783          	ld	a5,-24(s0)
    1bc8:	47fc                	lw	a5,76(a5)
    1bca:	9fb9                	addw	a5,a5,a4
    1bcc:	2781                	sext.w	a5,a5
    1bce:	883e                	mv	a6,a5
    1bd0:	0005071b          	sext.w	a4,a0
    1bd4:	0008079b          	sext.w	a5,a6
    1bd8:	00e7d363          	bge	a5,a4,1bde <schedule_edf+0x1f4>
    1bdc:	8542                	mv	a0,a6
    1bde:	0005079b          	sext.w	a5,a0
    1be2:	872e                	mv	a4,a1
    1be4:	02f75763          	bge	a4,a5,1c12 <schedule_edf+0x228>
            {
                if (nearest_rel_thrd == NULL || nearest_rel > j->release_time)
    1be8:	fb043783          	ld	a5,-80(s0)
    1bec:	cb89                	beqz	a5,1bfe <schedule_edf+0x214>
    1bee:	fb843783          	ld	a5,-72(s0)
    1bf2:	4f98                	lw	a4,24(a5)
    1bf4:	fc442783          	lw	a5,-60(s0)
    1bf8:	2781                	sext.w	a5,a5
    1bfa:	00f75c63          	bge	a4,a5,1c12 <schedule_edf+0x228>
                {
                    nearest_rel_thrd = j->thrd;
    1bfe:	fb843783          	ld	a5,-72(s0)
    1c02:	639c                	ld	a5,0(a5)
    1c04:	faf43823          	sd	a5,-80(s0)
                    nearest_rel = j->release_time;
    1c08:	fb843783          	ld	a5,-72(s0)
    1c0c:	4f9c                	lw	a5,24(a5)
    1c0e:	fcf42223          	sw	a5,-60(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1c12:	fb843783          	ld	a5,-72(s0)
    1c16:	679c                	ld	a5,8(a5)
    1c18:	f8f43c23          	sd	a5,-104(s0)
    1c1c:	f9843783          	ld	a5,-104(s0)
    1c20:	17e1                	addi	a5,a5,-8
    1c22:	faf43c23          	sd	a5,-72(s0)
    1c26:	fb843783          	ld	a5,-72(s0)
    1c2a:	00878713          	addi	a4,a5,8
    1c2e:	689c                	ld	a5,16(s1)
    1c30:	f2f71ce3          	bne	a4,a5,1b68 <schedule_edf+0x17e>
                }
            }
        }
        if (nearest_rel_thrd != NULL) // higher priority will interrupt
    1c34:	fb043783          	ld	a5,-80(s0)
    1c38:	cb91                	beqz	a5,1c4c <schedule_edf+0x262>
        {
            ret.allocated_time = nearest_rel - args.current_time;
    1c3a:	409c                	lw	a5,0(s1)
    1c3c:	fc442703          	lw	a4,-60(s0)
    1c40:	40f707bb          	subw	a5,a4,a5
    1c44:	2781                	sext.w	a5,a5
    1c46:	f6f42423          	sw	a5,-152(s0)
    1c4a:	a82d                	j	1c84 <schedule_edf+0x29a>
        }
        else
        {
            if (to_be_run->current_deadline - args.current_time < to_be_run->remaining_time)
    1c4c:	fe843783          	ld	a5,-24(s0)
    1c50:	4bb8                	lw	a4,80(a5)
    1c52:	409c                	lw	a5,0(s1)
    1c54:	40f707bb          	subw	a5,a4,a5
    1c58:	0007871b          	sext.w	a4,a5
    1c5c:	fe843783          	ld	a5,-24(s0)
    1c60:	47fc                	lw	a5,76(a5)
    1c62:	00f75c63          	bge	a4,a5,1c7a <schedule_edf+0x290>
            {
                ret.allocated_time = to_be_run->current_deadline - args.current_time;
    1c66:	fe843783          	ld	a5,-24(s0)
    1c6a:	4bb8                	lw	a4,80(a5)
    1c6c:	409c                	lw	a5,0(s1)
    1c6e:	40f707bb          	subw	a5,a4,a5
    1c72:	2781                	sext.w	a5,a5
    1c74:	f6f42423          	sw	a5,-152(s0)
    1c78:	a031                	j	1c84 <schedule_edf+0x29a>
            }
            else
            {
                ret.allocated_time = to_be_run->remaining_time;
    1c7a:	fe843783          	ld	a5,-24(s0)
    1c7e:	47fc                	lw	a5,76(a5)
    1c80:	f6f42423          	sw	a5,-152(s0)
            }
        }
    }
    return ret;
    1c84:	f6043783          	ld	a5,-160(s0)
    1c88:	f6f43823          	sd	a5,-144(s0)
    1c8c:	f6843783          	ld	a5,-152(s0)
    1c90:	f6f43c23          	sd	a5,-136(s0)
    1c94:	f7043703          	ld	a4,-144(s0)
    1c98:	f7843783          	ld	a5,-136(s0)
    1c9c:	863a                	mv	a2,a4
    1c9e:	86be                	mv	a3,a5
    1ca0:	8732                	mv	a4,a2
    1ca2:	87b6                	mv	a5,a3
}
    1ca4:	853a                	mv	a0,a4
    1ca6:	85be                	mv	a1,a5
    1ca8:	646a                	ld	s0,152(sp)
    1caa:	64ca                	ld	s1,144(sp)
    1cac:	610d                	addi	sp,sp,160
    1cae:	8082                	ret

0000000000001cb0 <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    1cb0:	7135                	addi	sp,sp,-160
    1cb2:	ed22                	sd	s0,152(sp)
    1cb4:	e926                	sd	s1,144(sp)
    1cb6:	1100                	addi	s0,sp,160
    1cb8:	84aa                	mv	s1,a0
    struct thread *to_be_run = NULL;
    1cba:	fe043423          	sd	zero,-24(s0)
    struct thread *to_be_ret = NULL;
    1cbe:	fe043023          	sd	zero,-32(s0)
    struct thread *i = NULL;
    1cc2:	fc043c23          	sd	zero,-40(s0)
    list_for_each_entry(i, args.run_queue, thread_list)
    1cc6:	649c                	ld	a5,8(s1)
    1cc8:	639c                	ld	a5,0(a5)
    1cca:	faf43423          	sd	a5,-88(s0)
    1cce:	fa843783          	ld	a5,-88(s0)
    1cd2:	fd878793          	addi	a5,a5,-40
    1cd6:	fcf43c23          	sd	a5,-40(s0)
    1cda:	a041                	j	1d5a <schedule_rm+0xaa>
    {
        if (i->current_deadline <= args.current_time)
    1cdc:	fd843783          	ld	a5,-40(s0)
    1ce0:	4bb8                	lw	a4,80(a5)
    1ce2:	409c                	lw	a5,0(s1)
    1ce4:	02e7c163          	blt	a5,a4,1d06 <schedule_rm+0x56>
        {
            if (to_be_ret == NULL || i->ID < to_be_ret->ID)
    1ce8:	fe043783          	ld	a5,-32(s0)
    1cec:	cb89                	beqz	a5,1cfe <schedule_rm+0x4e>
    1cee:	fd843783          	ld	a5,-40(s0)
    1cf2:	5398                	lw	a4,32(a5)
    1cf4:	fe043783          	ld	a5,-32(s0)
    1cf8:	539c                	lw	a5,32(a5)
    1cfa:	00f75663          	bge	a4,a5,1d06 <schedule_rm+0x56>
                to_be_ret = i;
    1cfe:	fd843783          	ld	a5,-40(s0)
    1d02:	fef43023          	sd	a5,-32(s0)
        }
        if (to_be_run == NULL || i->period < to_be_run->period || (i->period == to_be_run->period && i->ID < to_be_run->ID))
    1d06:	fe843783          	ld	a5,-24(s0)
    1d0a:	cb8d                	beqz	a5,1d3c <schedule_rm+0x8c>
    1d0c:	fd843783          	ld	a5,-40(s0)
    1d10:	43f8                	lw	a4,68(a5)
    1d12:	fe843783          	ld	a5,-24(s0)
    1d16:	43fc                	lw	a5,68(a5)
    1d18:	02f74263          	blt	a4,a5,1d3c <schedule_rm+0x8c>
    1d1c:	fd843783          	ld	a5,-40(s0)
    1d20:	43f8                	lw	a4,68(a5)
    1d22:	fe843783          	ld	a5,-24(s0)
    1d26:	43fc                	lw	a5,68(a5)
    1d28:	00f71e63          	bne	a4,a5,1d44 <schedule_rm+0x94>
    1d2c:	fd843783          	ld	a5,-40(s0)
    1d30:	5398                	lw	a4,32(a5)
    1d32:	fe843783          	ld	a5,-24(s0)
    1d36:	539c                	lw	a5,32(a5)
    1d38:	00f75663          	bge	a4,a5,1d44 <schedule_rm+0x94>
        {
            to_be_run = i;
    1d3c:	fd843783          	ld	a5,-40(s0)
    1d40:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(i, args.run_queue, thread_list)
    1d44:	fd843783          	ld	a5,-40(s0)
    1d48:	779c                	ld	a5,40(a5)
    1d4a:	f8f43023          	sd	a5,-128(s0)
    1d4e:	f8043783          	ld	a5,-128(s0)
    1d52:	fd878793          	addi	a5,a5,-40
    1d56:	fcf43c23          	sd	a5,-40(s0)
    1d5a:	fd843783          	ld	a5,-40(s0)
    1d5e:	02878713          	addi	a4,a5,40
    1d62:	649c                	ld	a5,8(s1)
    1d64:	f6f71ce3          	bne	a4,a5,1cdc <schedule_rm+0x2c>
        }
    }
    struct threads_sched_result ret;
    if (to_be_ret != NULL)
    1d68:	fe043783          	ld	a5,-32(s0)
    1d6c:	cb91                	beqz	a5,1d80 <schedule_rm+0xd0>
    {
        ret.scheduled_thread_list_member = &to_be_ret->thread_list;
    1d6e:	fe043783          	ld	a5,-32(s0)
    1d72:	02878793          	addi	a5,a5,40
    1d76:	f6f43023          	sd	a5,-160(s0)
        ret.allocated_time = 0;
    1d7a:	f6042423          	sw	zero,-152(s0)
    1d7e:	aa55                	j	1f32 <schedule_rm+0x282>
    }
    else if (to_be_run == NULL)
    1d80:	fe843783          	ld	a5,-24(s0)
    1d84:	efa5                	bnez	a5,1dfc <schedule_rm+0x14c>
    {
        int min = 10001;
    1d86:	6789                	lui	a5,0x2
    1d88:	71178793          	addi	a5,a5,1809 # 2711 <__BSS_END__+0x5c1>
    1d8c:	fcf42a23          	sw	a5,-44(s0)
        struct release_queue_entry *j = NULL;
    1d90:	fc043423          	sd	zero,-56(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1d94:	689c                	ld	a5,16(s1)
    1d96:	639c                	ld	a5,0(a5)
    1d98:	f8f43823          	sd	a5,-112(s0)
    1d9c:	f9043783          	ld	a5,-112(s0)
    1da0:	17e1                	addi	a5,a5,-8
    1da2:	fcf43423          	sd	a5,-56(s0)
    1da6:	a805                	j	1dd6 <schedule_rm+0x126>
        {
            if (j->release_time < min)
    1da8:	fc843783          	ld	a5,-56(s0)
    1dac:	4f98                	lw	a4,24(a5)
    1dae:	fd442783          	lw	a5,-44(s0)
    1db2:	2781                	sext.w	a5,a5
    1db4:	00f75763          	bge	a4,a5,1dc2 <schedule_rm+0x112>
                min = j->release_time;
    1db8:	fc843783          	ld	a5,-56(s0)
    1dbc:	4f9c                	lw	a5,24(a5)
    1dbe:	fcf42a23          	sw	a5,-44(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1dc2:	fc843783          	ld	a5,-56(s0)
    1dc6:	679c                	ld	a5,8(a5)
    1dc8:	f8f43423          	sd	a5,-120(s0)
    1dcc:	f8843783          	ld	a5,-120(s0)
    1dd0:	17e1                	addi	a5,a5,-8
    1dd2:	fcf43423          	sd	a5,-56(s0)
    1dd6:	fc843783          	ld	a5,-56(s0)
    1dda:	00878713          	addi	a4,a5,8
    1dde:	689c                	ld	a5,16(s1)
    1de0:	fcf714e3          	bne	a4,a5,1da8 <schedule_rm+0xf8>
        }
        ret.scheduled_thread_list_member = args.run_queue;
    1de4:	649c                	ld	a5,8(s1)
    1de6:	f6f43023          	sd	a5,-160(s0)
        ret.allocated_time = min - args.current_time;
    1dea:	409c                	lw	a5,0(s1)
    1dec:	fd442703          	lw	a4,-44(s0)
    1df0:	40f707bb          	subw	a5,a4,a5
    1df4:	2781                	sext.w	a5,a5
    1df6:	f6f42423          	sw	a5,-152(s0)
    1dfa:	aa25                	j	1f32 <schedule_rm+0x282>
    }
    else
    {
        ret.scheduled_thread_list_member = &to_be_run->thread_list;
    1dfc:	fe843783          	ld	a5,-24(s0)
    1e00:	02878793          	addi	a5,a5,40
    1e04:	f6f43023          	sd	a5,-160(s0)
        int nearest_rel = 10001;
    1e08:	6789                	lui	a5,0x2
    1e0a:	71178793          	addi	a5,a5,1809 # 2711 <__BSS_END__+0x5c1>
    1e0e:	fcf42223          	sw	a5,-60(s0)
        struct release_queue_entry *j = NULL;
    1e12:	fa043c23          	sd	zero,-72(s0)
        struct thread *nearest_rel_thrd = NULL;
    1e16:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1e1a:	689c                	ld	a5,16(s1)
    1e1c:	639c                	ld	a5,0(a5)
    1e1e:	faf43023          	sd	a5,-96(s0)
    1e22:	fa043783          	ld	a5,-96(s0)
    1e26:	17e1                	addi	a5,a5,-8
    1e28:	faf43c23          	sd	a5,-72(s0)
    1e2c:	a065                	j	1ed4 <schedule_rm+0x224>
        {
            if ((j->thrd->period < to_be_run->period || (j->thrd->period == to_be_run->period && j->thrd->ID < to_be_run->ID)) && (j->release_time < ((args.current_time + to_be_run->remaining_time < to_be_run->current_deadline) ? args.current_time + to_be_run->remaining_time : to_be_run->current_deadline)))
    1e2e:	fb843783          	ld	a5,-72(s0)
    1e32:	639c                	ld	a5,0(a5)
    1e34:	43f8                	lw	a4,68(a5)
    1e36:	fe843783          	ld	a5,-24(s0)
    1e3a:	43fc                	lw	a5,68(a5)
    1e3c:	02f74463          	blt	a4,a5,1e64 <schedule_rm+0x1b4>
    1e40:	fb843783          	ld	a5,-72(s0)
    1e44:	639c                	ld	a5,0(a5)
    1e46:	43f8                	lw	a4,68(a5)
    1e48:	fe843783          	ld	a5,-24(s0)
    1e4c:	43fc                	lw	a5,68(a5)
    1e4e:	06f71963          	bne	a4,a5,1ec0 <schedule_rm+0x210>
    1e52:	fb843783          	ld	a5,-72(s0)
    1e56:	639c                	ld	a5,0(a5)
    1e58:	5398                	lw	a4,32(a5)
    1e5a:	fe843783          	ld	a5,-24(s0)
    1e5e:	539c                	lw	a5,32(a5)
    1e60:	06f75063          	bge	a4,a5,1ec0 <schedule_rm+0x210>
    1e64:	fb843783          	ld	a5,-72(s0)
    1e68:	4f8c                	lw	a1,24(a5)
    1e6a:	fe843783          	ld	a5,-24(s0)
    1e6e:	4ba8                	lw	a0,80(a5)
    1e70:	4098                	lw	a4,0(s1)
    1e72:	fe843783          	ld	a5,-24(s0)
    1e76:	47fc                	lw	a5,76(a5)
    1e78:	9fb9                	addw	a5,a5,a4
    1e7a:	2781                	sext.w	a5,a5
    1e7c:	883e                	mv	a6,a5
    1e7e:	0005071b          	sext.w	a4,a0
    1e82:	0008079b          	sext.w	a5,a6
    1e86:	00e7d363          	bge	a5,a4,1e8c <schedule_rm+0x1dc>
    1e8a:	8542                	mv	a0,a6
    1e8c:	0005079b          	sext.w	a5,a0
    1e90:	872e                	mv	a4,a1
    1e92:	02f75763          	bge	a4,a5,1ec0 <schedule_rm+0x210>
            {
                if (nearest_rel_thrd == NULL || nearest_rel > j->release_time)
    1e96:	fb043783          	ld	a5,-80(s0)
    1e9a:	cb89                	beqz	a5,1eac <schedule_rm+0x1fc>
    1e9c:	fb843783          	ld	a5,-72(s0)
    1ea0:	4f98                	lw	a4,24(a5)
    1ea2:	fc442783          	lw	a5,-60(s0)
    1ea6:	2781                	sext.w	a5,a5
    1ea8:	00f75c63          	bge	a4,a5,1ec0 <schedule_rm+0x210>
                {
                    nearest_rel_thrd = j->thrd;
    1eac:	fb843783          	ld	a5,-72(s0)
    1eb0:	639c                	ld	a5,0(a5)
    1eb2:	faf43823          	sd	a5,-80(s0)
                    nearest_rel = j->release_time;
    1eb6:	fb843783          	ld	a5,-72(s0)
    1eba:	4f9c                	lw	a5,24(a5)
    1ebc:	fcf42223          	sw	a5,-60(s0)
        list_for_each_entry(j, args.release_queue, thread_list)
    1ec0:	fb843783          	ld	a5,-72(s0)
    1ec4:	679c                	ld	a5,8(a5)
    1ec6:	f8f43c23          	sd	a5,-104(s0)
    1eca:	f9843783          	ld	a5,-104(s0)
    1ece:	17e1                	addi	a5,a5,-8
    1ed0:	faf43c23          	sd	a5,-72(s0)
    1ed4:	fb843783          	ld	a5,-72(s0)
    1ed8:	00878713          	addi	a4,a5,8
    1edc:	689c                	ld	a5,16(s1)
    1ede:	f4f718e3          	bne	a4,a5,1e2e <schedule_rm+0x17e>
                }
            }
        }
        if (nearest_rel_thrd != NULL) // higher priority will interrupt
    1ee2:	fb043783          	ld	a5,-80(s0)
    1ee6:	cb91                	beqz	a5,1efa <schedule_rm+0x24a>
        {
            ret.allocated_time = nearest_rel - args.current_time;
    1ee8:	409c                	lw	a5,0(s1)
    1eea:	fc442703          	lw	a4,-60(s0)
    1eee:	40f707bb          	subw	a5,a4,a5
    1ef2:	2781                	sext.w	a5,a5
    1ef4:	f6f42423          	sw	a5,-152(s0)
    1ef8:	a82d                	j	1f32 <schedule_rm+0x282>
        }
        else
        {
            if (to_be_run->current_deadline - args.current_time < to_be_run->remaining_time)
    1efa:	fe843783          	ld	a5,-24(s0)
    1efe:	4bb8                	lw	a4,80(a5)
    1f00:	409c                	lw	a5,0(s1)
    1f02:	40f707bb          	subw	a5,a4,a5
    1f06:	0007871b          	sext.w	a4,a5
    1f0a:	fe843783          	ld	a5,-24(s0)
    1f0e:	47fc                	lw	a5,76(a5)
    1f10:	00f75c63          	bge	a4,a5,1f28 <schedule_rm+0x278>
            {
                ret.allocated_time = to_be_run->current_deadline - args.current_time;
    1f14:	fe843783          	ld	a5,-24(s0)
    1f18:	4bb8                	lw	a4,80(a5)
    1f1a:	409c                	lw	a5,0(s1)
    1f1c:	40f707bb          	subw	a5,a4,a5
    1f20:	2781                	sext.w	a5,a5
    1f22:	f6f42423          	sw	a5,-152(s0)
    1f26:	a031                	j	1f32 <schedule_rm+0x282>
            }
            else
            {
                ret.allocated_time = to_be_run->remaining_time;
    1f28:	fe843783          	ld	a5,-24(s0)
    1f2c:	47fc                	lw	a5,76(a5)
    1f2e:	f6f42423          	sw	a5,-152(s0)
            }
        }
    }
    return ret;
    1f32:	f6043783          	ld	a5,-160(s0)
    1f36:	f6f43823          	sd	a5,-144(s0)
    1f3a:	f6843783          	ld	a5,-152(s0)
    1f3e:	f6f43c23          	sd	a5,-136(s0)
    1f42:	f7043703          	ld	a4,-144(s0)
    1f46:	f7843783          	ld	a5,-136(s0)
    1f4a:	863a                	mv	a2,a4
    1f4c:	86be                	mv	a3,a5
    1f4e:	8732                	mv	a4,a2
    1f50:	87b6                	mv	a5,a3
    1f52:	853a                	mv	a0,a4
    1f54:	85be                	mv	a1,a5
    1f56:	646a                	ld	s0,152(sp)
    1f58:	64ca                	ld	s1,144(sp)
    1f5a:	610d                	addi	sp,sp,160
    1f5c:	8082                	ret
