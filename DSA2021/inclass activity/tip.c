#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct disjointSet{
    int root;
} DisjointSet;

DisjointSet ds[1 << 24];
bool set[1 << 24] = {};

int c2i(char c) { 
    if ('0' <= c && c <= '9') return c - '0';
    else if ('a' <= c && c <= 'z') return c - 'a' + 10;
    else if ('A' <= c && c <= 'Z') return c - 'A' + 36;
    return -1;
}

int hash(const char* s) {  
    int ret = 0;
    int mask = (1<<24)-1;
    int len = strlen(s);
    for (int i = 0; i < len; i++)
        ret = mask & (ret << 4) | c2i(s[i]);
    return ret;
}

void makeset(const char* s){
    int num = hash(s);
    ds[num].root= num;
    return;
}

inline void static init(const char* s) {
    int i = hash(s);
    if (!set[i]) {
        makeset(s);
        set[i] = 1;
    }
}

int find_set(const char* s) {
    init(s);
    int i = hash(s);
    int tmp = i;
    while(ds[tmp].root != tmp){
        tmp = ds[tmp].root;
    }
    int TMP = i;
    while(TMP != tmp){
        int ttmp = ds[TMP].root;
        ds[TMP].root = tmp;
        TMP = ttmp;
    }
    return ds[i].root;
}

void group(const char *ra, const char *rb) {
    int a = find_set(ra), b = find_set(rb);
    if(ds[a].root != ds[b].root){
        ds[b].root = ds[a].root;
    }
    return;
}

bool same_set(const char*a, const char* b) {
    int num1 = hash(a);
    int num2 = hash(b);
    return(ds[num1].root == ds[num2].root);
}

int main() {
    int time;
    scanf("%d", &time);
    char cmd[10];
    char name1[15], name2[15];
    for(int i = 0; i < time; i++){
        scanf("%s%s%s", cmd, name1, name2);
        if(cmd[0] == 'g'){
            group(name1, name2);
        }
        else{
            if(same_set(name1, name2)){
                printf("Positive\n");
            }
            else
                printf("Negative\n");
        }
    }
    return 0;
}