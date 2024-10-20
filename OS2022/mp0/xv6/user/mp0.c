#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char key;
int dir_cnt, file_cnt;

int key_cnt(char *path)
{
    int len = strlen(path);
    int key_counter = 0;
    for (int i = 0; i < len; i++)
    {
        if (path[i] == key)
            key_counter++;
    }
    return key_counter;
}

void ls(char *path)
{
    char buf[64], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, 0)) < 0)
    {
        fprintf(2, "%s [error opening dir]\n", path);
        return;
    }
    if (fstat(fd, &st) < 0)
    {
        fprintf(2, "mp0: cannot stat %s\n", path);
        close(fd);
        return;
    }
    int num = 0;
    switch (st.type)
    {
    case T_FILE:
        num = key_cnt(path);
        fprintf(2, "%s %d\n", path, num);
        file_cnt++;
        break;
    case T_DIR:
        num = key_cnt(path);
        fprintf(2, "%s %d\n", path, num);
        dir_cnt++;
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';
        while (read(fd, &de, sizeof(de)) == sizeof(de))
        {
            if (de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            ls(buf);
        }
        break;
    }
    close(fd);
}

int main(int argc, char *argv[])
{
    int pid;
    key = *argv[2];
    int p[2];
    pipe(p);
    if ((pid = fork()) == 0)
    {
        ls(argv[1]);
        close(p[0]);
        write(p[1], &dir_cnt, sizeof(int));
        write(p[1], &file_cnt, sizeof(int));
    }
    else
    {
        int status;
        wait(&status); // to prevent zombie process
        close(p[1]);
        read(p[0], &dir_cnt, sizeof(int));
        read(p[0], &file_cnt, sizeof(int));
        if (dir_cnt)
        {
            dir_cnt--;
        }
        printf("\n%d directories, %d files\n", dir_cnt, file_cnt);
    }
    exit(0);
}
