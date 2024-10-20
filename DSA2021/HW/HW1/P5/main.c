#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Usb{
    int group;
    int id;
    int line;
    struct Usb *next;
    struct Usb *before;
}USB;

typedef struct list{
    USB *head;
    USB *tail;
}List;

typedef struct toilet{
    int id; //which toilet
    int group[100000]; //the order of group
    int start, end; //the index of first and last+1
    List list[100000];
    int cnt;
}toilet;

USB *genUSB(int group, int id, int line){
    USB *new = malloc(sizeof(USB));
    new -> group = group;
    new -> id = id;
    new -> line = line;
    new -> next = NULL;
    new -> before = NULL;
    return new;
}

void enter(int group, int id, int line, toilet t[]){
    t[line].cnt++;
    USB *new = genUSB(group, id, line);
    int flag = 0;
    for(int i = t[line].start; i < t[line].end; i++){
        if(group == t[line].group[i]){
            t[line].list[i].tail -> next = new;
            new -> before = t[line].list[i].tail;
            t[line].list[i].tail = t[line].list[i].tail -> next;
            flag = 1;
        }
    }
    if(flag == 0){
        t[line].group[t[line].end] = group;
        t[line].list[t[line].end].head = new;
        t[line].list[t[line].end].tail = new;
        t[line].end += 1;
    }
    return;
}

void leave(int line, toilet t[]){
    t[line].cnt--;
    if(t[line].list[t[line].end-1].head == t[line].list[t[line].end-1].tail)
        t[line].end -= 1;
    else{
        t[line].list[t[line].end-1].tail -> before -> next = NULL;
    }
    return;
}

void go(int line, toilet t[]){
    t[line].cnt--;
    if(t[line].list[t[line].start].head == t[line].list[t[line].start].tail)
        t[line].start++;
    else{
        t[line].list[t[line].start].head = t[line].list[t[line].start].head -> next;
        t[line].list[t[line].start].head -> before = NULL;
    }
    return;
}

void close(int line, toilet t[]){
    return;
}

void print(toilet t){
    if(t.cnt == 0){
        printf("\n");
    }
    else{
        USB *new = t.list->head;
        while(new -> next != NULL){
            printf("%d ",new);
            new = new -> next;
        }
        printf("%d\n", new);
    }
}
int main(void){
    int m, n, k;
    scanf("%d%d%d", &m, &n, &k);
    char cmd[10];
    toilet *t = malloc(sizeof(toilet)*k);
    for(int i = 0; i < k; i++){
        t[i].start = 0;
        t[i].end = 0;
    }
    int id, line, group;
    for(int i = 0; i < k; i++){
        scanf("%s", cmd);
        if(strcmp(cmd, "enter") == 0){
            scanf("%d%d%d", &group, &id, &line);
            enter(group, id, line, t);
        }
        else if(strcmp(cmd, "leave") == 0){
            scanf("%d", &line);
            leave(line, t);
        }
        else if(strcmp(cmd, "go") == 0){
            scanf("%d", &line);
            go(line, t);
        }
        else if(strcmp(cmd, "close") == 0){
            scanf("%d", &line);
            go(line, t);
        }
    }
    for(int i = 0; i < m; i++){
        if(t[i].cnt == 0)
            printf("\n");
        else{
            printf("%d", t[i].list[t[i].start].head->id);
            for(int j = t[i].start; j < t[i].end; j++){
                USB *node = t[i].list[j].head;
                if(node -> next != NULL){
                    while(node -> next != NULL){
                        printf(" %d", node -> id);
                        node = node -> next;
                    }
                    printf(" %d\n", node -> id);
                }
                else
                    printf("\n");
            }
        }
    }
    return 0;
}