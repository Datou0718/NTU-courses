#include "kernel/param.h"
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/riscv.h"
#include "kernel/fcntl.h"
#include "kernel/spinlock.h"
#include "kernel/sleeplock.h"
#include "kernel/fs.h"
#include "kernel/file.h"
#include "user/user.h"

#define fail(msg)                 \
  do                              \
  {                               \
    printf("FAILURE: " msg "\n"); \
    failed = 1;                   \
    goto done;                    \
  } while (0);
static int failed = 0;

static void public12(void);
static void fish(void);
static void cucumber123(void);
static void cucumber456(void);
static void cleanup(void);

int main(int argc, char *argv[])
{
  cleanup();
  public12();
  fish();
  cleanup();
  cucumber123();
  cucumber456();
  cleanup();
  exit(failed);
}

static void
cleanup(void)
{
  unlink("/testsymlink2/p");
  unlink("/testsymlink3/q");
  unlink("/testsymlink2");
  unlink("/testsymlink3");

  unlink("/testsymlink4/t12");
  unlink("/testsymlink4/t11");
  unlink("/testsymlink4/t10");
  unlink("/testsymlink4/t9");
  unlink("/testsymlink4/t8");
  unlink("/testsymlink4/t7");
  unlink("/testsymlink4/t6");
  unlink("/testsymlink4/t5");
  unlink("/testsymlink4/t4");
  unlink("/testsymlink4/t3");
  unlink("/testsymlink4/t2");
  unlink("/testsymlink4/t1");

  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10/dir11/dir12/a2");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10/dir11/dir12");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10/dir11");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4/dir5");
  unlink("/testsymlink4/dir1/dir2/dir3/dir4");

  unlink("/testsymlink4/dir1/dir2/dir3/a1");
  unlink("/testsymlink4/dir1/dir2/dir3");
  unlink("/testsymlink4/dir1/dir2");
  unlink("/testsymlink4/dir1/CYCLE");
  unlink("/testsymlink4/dir1");
  unlink("/testsymlink4/cycle");
  unlink("/testsymlink4/DIR1/XD");
  unlink("/testsymlink4/DIR1");
  unlink("/testsymlink4/DIR2/QQ");
  unlink("/testsymlink4/DIR2");
  unlink("/testsymlink4");

  unlink("/D");
  unlink("/C");
  unlink("/A/B/E");
  unlink("/A/B/b");
  unlink("/A/B");
  unlink("/A/a");
  unlink("/A/d");
  unlink("/A/e");
  unlink("/A");
}

static void
public12()
{
  int r, fd1 = -1, fd2 = -1;
  char c = 0, c2 = 0;

  printf("Start: test symlinks to directory\n");
  printf("public testcase 1:\n");

  mkdir("/testsymlink2");
  mkdir("/testsymlink3");

  fd1 = open("/testsymlink2/p", O_CREATE | O_RDWR);
  if (fd1 < 0)
    fail("failed to open p");

  r = symlink("/testsymlink2", "/testsymlink3/q");
  if (r < 0)
    fail("symlink q -> p failed");

  fd2 = open("/testsymlink3/q/p", O_RDWR);
  if (fd2 < 0)
    fail("Failed to open /testsymlink3/q/p\n");

  printf("public testcase 1: ok\n");

  printf("public testcase 2:\n");
  c = '#';
  r = write(fd1, &c, 1);
  if (r != 1)
    fail("Failed to write to /testsymlink2/p\n");
  r = read(fd2, &c2, 1);
  if (r != 1)
    fail("Failed to read from /testsymlink3/q/p\n");
  if (c != c2)
    fail("Value read from /testsymlink2/p differs from value written to /testsymlink3/q/p\n");

  printf("public testcase 2: ok\n");
done:
  close(fd1);
  close(fd2);
}

static void
fish()
{
  int r, fd1 = -1, fd2 = -1, fd3 = -1, fd4 = -1, fd5 = -1;
  char c = 0, c2 = 0, c3 = 0;

  printf("fish testcase 1:\n");

  mkdir("/testsymlink4");
  chdir("/testsymlink4");
  mkdir("dir1");
  mkdir("DIR1");
  mkdir("DIR2");
  chdir("dir1");
  mkdir("dir2");
  chdir("dir2");
  mkdir("dir3");
  chdir("dir3");
  mkdir("dir4");
  chdir("dir4");
  mkdir("dir5");
  chdir("dir5");
  mkdir("dir6");
  chdir("dir6");
  mkdir("dir7");
  chdir("dir7");
  mkdir("dir8");
  chdir("dir8");
  mkdir("dir9");
  chdir("dir9");
  mkdir("dir10");
  chdir("dir10");
  mkdir("dir11");
  chdir("dir11");
  mkdir("dir12");

  fd1 = open("/testsymlink4/dir1/dir2/dir3/a1", O_CREATE | O_RDWR);
  if (fd1 < 0)
    fail("failed to open a1");

  r = symlink("/testsymlink4/dir1/dir2", "/testsymlink4/DIR1/XD");
  if (r < 0)
    fail("symlink XD -> dir2 failed");

  r = symlink("/testsymlink4/DIR1/XD/dir3", "/testsymlink4/DIR2/QQ");
  if (r < 0)
    fail("symlink QQ -> dir3 failed");

  fd2 = open("/testsymlink4/DIR2/QQ/a1", O_RDWR);
  if (fd2 < 0)
    fail("Failed to open QQ\n");

  fd4 = open("/testsymlink4/DIR1/XD/dir3/a1", O_RDWR);
  if (fd4 < 0)
    fail("Failed to open /testsymlink4/DIR1/XD/dir3/a1\n");

  printf("fish testcase 1: ok\n");

  printf("fish testcase 2:\n");

  c = 'F';
  r = write(fd2, &c, 1);
  if (r != 1)
    fail("Failed to write to /testsymlink4/DIR2/QQ/a1\n");
  r = read(fd1, &c2, 1);
  if (r != 1)
    fail("Failed to read from /testsymlink4/dir1/dir2/dir3/a1\n");
  r = read(fd4, &c3, 1);
  if (r != 1)
    fail("Failed to read from /testsymlink4/DIR1/XD/dir3/a1\n");
  if (c != c2 || c != c3)
    fail("Value read differs!\n");

  printf("fish testcase 2: ok\n");

  printf("fish testcase 3:\n");

  fd5 = open("/testsymlink4/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10/dir11/dir12/a2", O_CREATE | O_RDWR);
  r = symlink("/testsymlink4/dir1", "/testsymlink4/t1");
  r = symlink("/testsymlink4/t1/dir2", "/testsymlink4/t2");
  r = symlink("/testsymlink4/t2/dir3", "/testsymlink4/t3");
  r = symlink("/testsymlink4/t3/dir4", "/testsymlink4/t4");
  r = symlink("/testsymlink4/t4/dir5", "/testsymlink4/t5");
  r = symlink("/testsymlink4/t5/dir6", "/testsymlink4/t6");
  r = symlink("/testsymlink4/t6/dir7", "/testsymlink4/t7");
  r = symlink("/testsymlink4/t7/dir8", "/testsymlink4/t8");
  r = symlink("/testsymlink4/t8/dir9", "/testsymlink4/t9");
  r = symlink("/testsymlink4/t9/dir10", "/testsymlink4/t10");
  r = symlink("/testsymlink4/t10/dir11", "/testsymlink4/t11");
  r = symlink("/testsymlink4/t11/dir12", "/testsymlink4/t12");
  close(fd5);
  fd5 = open("/testsymlink4/t12/a2", O_RDWR);
  if (fd5 < 0)
  {
    fail("Failed to open /testsymlink4/t12/a2\n");
  }
  else
  {
    r = write(fd5, &c, 1);
    if (r == 1)
      printf("fish testcase 3: ok\n");
    else
    {
      fail("Failed to write to /testsymlink4/t12/a2\n");
    }
  }

  printf("fish testcase 4:\n");

  r = symlink("/testsymlink4/dir1/CYCLE/IM", "/testsymlink4/cycle");
  if (r < 0)
    fail("symlink cycle -> dir1 failed");
  r = symlink("/testsymlink4/cycle/NT", "/testsymlink4/dir1/CYCLE");
  if (r < 0)
    fail("symlink CYCLE -> cycle failed");
  fd3 = open("/testsymlink4/cycle/invalid", O_RDWR);
  if (fd3 < 0)
    printf("fish testcase 4: ok\n");

done:
  close(fd1);
  close(fd2);
  close(fd4);
  close(fd5);
}

static void
cucumber123()
{
  int r, fd1 = -1, fd2 = -1;
  char c = 0, c2 = 0;

  printf("cucumber testcase 1:\n");

  mkdir("/A");
  mkdir("/B");

  r = symlink("/A", "/B/C");
  if (r < 0)
    fail("symlink /B/C -> /A failed");

  fd1 = open("/B/C/a", O_CREATE | O_RDWR);
  if (fd1 < 0)
    fail("failed to open /B/C/a = /A/a");

  r = chdir("/B/C");
  if (r < 0)
    fail("chdir /B/C -> /A failed");

  fd2 = open("a", O_RDWR);
  if (fd2 < 0)
    fail("failed to open (/A)/a");

  c = '#';
  r = write(fd1, &c, 1);
  if (r != 1)
    fail("Failed to write to /B/C/a\n");
  r = read(fd2, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/a\n");
  if (c != c2)
    fail("Value read from /A/a differs from value written to /B/C/a\n");

  printf("cucumber testcase 1: ok\n");

  printf("cucumber testcase 2:\n");

  chdir("..");
  close(fd1);
  close(fd2);
  unlink("/B/C/a");
  fd1 = open("/A/a", O_CREATE | O_RDWR);
  if (fd1 < 0)
    fail("failed to open /A/a");
  unlink("/B/C");
  r = symlink("/A", "/B/C");
  if (r < 0)
    fail("symlink /B/C -> /A failed");
  r = symlink("/B/C/a", "B/C/b");
  fd2 = open("/A/b", O_RDWR);
  if (fd2 < 0)
    fail("failed to open /A/b -> /A/a");

  c = '#';
  r = write(fd1, &c, 1);
  if (r != 1)
    fail("Failed to write to /A/a\n");
  r = read(fd2, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/b -> /A/a\n");
  if (c != c2)
    fail("Value read from /A/a differs from value written to /A/b\n");

  printf("cucumber testcase 2: ok\n");

  printf("cucumber testcase 3:\n");

  mkdir("/D");
  r = symlink("/B/C", "D/E");
  if (r < 0)
    fail("symlink /D/E -> /B/C ->/A");
  chdir("/D");
  r = symlink("/D/E", "F");
  if (r < 0)
    fail("symlink /D/F -> /D/E -> /B/C ->/A");
  symlink("/D/F", "G");
  if (r < 0)
    fail("symlink /D/G -> /D/F -> /D/E -> /B/C ->/A");
  close(fd2);
  chdir("G");
  fd2 = open("b", O_RDWR);
  if (fd2 < 0)
    fail("failed to open /A/b");
  r = read(fd2, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/b -> /A/a\n");
  if (c != c2)
    fail("Value read from /A/a differs from value written to /A/b\n");
  close(fd2);
  chdir("/");
  symlink("/D/G/b", "D/F/c");
  fd2 = open("/D/E/c", O_RDWR);
  if (fd2 < 0)
    fail("failed to open /D/E/c -> /A/b -> /A/a");
  r = read(fd2, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/b -> /A/a\n");
  if (c != c2)
    fail("Value read from /A/a differs from value written to /A/b\n");
  close(fd1);
  close(fd2);

  unlink("/D/F/a");
  unlink("/D/E/b");
  unlink("/D/G/c");
  unlink("/B/C");
  unlink("/B");
  unlink("/D/F");
  unlink("/D/E");
  unlink("/D/G");
  unlink("/D");
  unlink("/A/a");
  unlink("/A/b");
  unlink("/A");

  printf("cucumber testcase 3: ok\n");

done:
  close(fd1);
  close(fd2);
}

static void
cucumber456()
{
  int r, fd1 = -1, fd2 = -1, fd3 = -1;
  char c = 0, c2 = 0;

  printf("cucumber testcase 4:\n");

  if (symlink("/A", "/B") < 0)
    fail("symlink /B -> /A failed");
  if (symlink("/B", "/C") < 0)
    fail("symlink /C -> /B failed");
  if (symlink("/C", "/A") < 0)
    fail("symlink /A -> /C failed");
  if (symlink("/A", "/D") < 0)
    fail("symlink /D -> /A failed");
  if (chdir("/A") != -1)
    fail("cd into loop not detected");
  if (chdir("/B") != -1)
    fail("cd into loop not detected");
  if (chdir("/C") != -1)
    fail("cd into loop not detected");
  if (chdir("/D") != -1)
    fail("cd into loop not detected");
  if (open("/D/a", O_CREATE | O_RDWR) != -1)
    fail("open inside loop not detected");
  if (open("/A/a", O_CREATE | O_RDWR) != -1)
    fail("open inside loop not detected");
  if (open("/B/a", O_CREATE | O_RDWR) != -1)
    fail("open inside loop not detected");
  if (open("/C/a", O_CREATE | O_RDWR) != -1)
    fail("open inside loop not detected");

  unlink("/A");
  unlink("/B");
  unlink("/C");
  unlink("/D");

  printf("cucumber testcase 4: ok\n");

  printf("cucumber testcase 5:\n");

  if (symlink("/C", "/D") < 0)
    fail("symlink /D -> /C failed");
  if (symlink("/A", "/C") < 0)
    fail("symlink /C -> /A failed");
  mkdir("/A");
  if (chdir("/D") < 0)
    fail("chdir /D -> /C -> /A failed");
  mkdir("B");
  if (symlink("/D/B", "B/E") < 0)
    fail("symlink /A/B/E -> /D/B = /A/B failed");
  if (chdir("B/E") < 0)
    fail("chdir (/A/)B/E -> /A/B failed");
  if (chdir("E") < 0)
    fail("chdir (/A/B/)E -> /A/B failed");
  if (chdir("E") < 0)
    fail("chdir (/A/B/)E -> /A/B failed");
  if (chdir("E") < 0)
    fail("chdir (/A/B/)E -> /A/B failed");

  fd1 = open("/D/a", O_CREATE | O_RDWR);
  if (fd1 < 0)
    fail("failed to open /D/a = /A/a");
  fd2 = open("E/../a", O_RDWR);
  if (fd2 < 0)
    fail("failed to open (/A/B/)E/../a = /A/a");

  c = '#';
  r = write(fd2, &c, 1);
  if (r != 1)
    fail("Failed to write to /A/a\n");
  r = read(fd1, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/a\n");
  if (c != c2)
    fail("Value read from /A/a differs from value written to /A/a\n");

  close(fd1);
  close(fd2);

  printf("cucumber testcase 5: ok\n");

  printf("cucumber testcase 6:\n");

  if (symlink("/C/e", "b") < 0)
    fail("symlink (/A/B/)b -> /A/e failed");
  if (symlink("/A/B/E/E/E/b", "E/E/../d") < 0)
    fail("symlink /A/d -> /A/B/b failed");
  chdir("E/E/E/../..");                 // to root
  fd3 = open("D/e", O_CREATE | O_RDWR); // assume cannot create through symlink
  if (fd3 < 0)
    fail("failed to open /A/e");
  fd1 = open("D/B/E/E/../d", O_RDWR);
  if (fd1 < 0)
    fail("failed to open /A/d -> /A/B/e -> /A/e");
  fd2 = open("/C/B/E/b", O_RDWR);
  if (fd2 < 0)
    fail("failed to open /A/B/b -> /A/e");

  c = '#';
  r = write(fd1, &c, 1);
  if (r != 1)
    fail("Failed to write to /A/e\n");
  r = read(fd2, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/e\n");
  if (c != c2)
    fail("Value read from /A/e differs from value written to /A/e\n");
  r = read(fd3, &c2, 1);
  if (r != 1)
    fail("Failed to read from /A/e\n");
  if (c != c2)
    fail("Value read from /A/e differs from value written to /A/e\n");

  close(fd1);
  close(fd2);

  printf("cucumber testcase 6: ok\n");

done:
  close(fd1);
  close(fd2);
}
