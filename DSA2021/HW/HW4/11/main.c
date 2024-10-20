#include<stdio.h>
#include<stdlib.h>
typedef struct treap{
    int priority;
    int value;
    int cnt;
    struct treap *left, *right;
}Treap;

Treap *genTreap(int Value){
    Treap *new = malloc(sizeof(Treap));
    new -> priority = rand();
    new -> value = Value;
    new -> cnt = 0;
    new -> left = NULL;
    new -> right = NULL;
    return new;
}

int main(void){
    int N, Q;
    scanf("%d%d", &N, &Q);
    int time;
    for(int i = 0; i < Q; i++){
        scanf("%d", &time);

    }
    int cmd;
    scanf("%d", &cmd);
    int p, k, l, r, x, y;
    switch(cmd){
        case 1:
            scanf("%d%d", &p, &k);
            break;
        case 2:
            scanf("%d", &p);
            break;
        case 3:
            scanf("%d%d", &l, &r);
            break;
        case 4:
            scanf("%d%d%d%d", &l, &r, &x, &y);
            break;
        case 5:
            scanf("%d%d%d", &l, &r, &k);
            break;
        case 6:
            scanf("%d%d", &l, &r);
            break;
    }
    return 0;
}