#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct day{
    int cmd; // 1 for merge, 2 for query, 3 for boom
    int a, b, c; // merge which two, c for AtoB or BtoA
    int valid; // validity of the cmd, 0 for invalid, 1 for valid
    int value; // answer to print
    int id; // which day
    int boom_root; // boom to which day
    int flag; // done or not
    struct day *Next_day; 
    struct day *Prev_day;
    struct day *next_boom;
}DAY;

typedef struct map{
    int parent;
    int value;
}MAP;

int find_root(MAP Map[], int a){
    int tmp = a;
    while(Map[tmp].parent != tmp){
        tmp = Map[tmp].parent;
    }
    return tmp;
}

int undo(MAP Map[], DAY Day[], int today){
    if(Day[today].valid == 1){
        if(Day[today].cmd == 1){
            int root = find_root(Map, Day[today].a);
            int tmpA = Day[today].a, tmpB = Day[today].b;
            while(Map[tmpA].parent != root){
                tmpA = Map[tmpA].parent;
            }
            while(Map[tmpB].parent != root){
                tmpB = Map[tmpB].parent;
            }
            if(Day[today].c == 1)
                Map[tmpB].parent = tmpB;
            else
                Map[tmpA].parent = tmpA;
            Map[0].value += 1;
        }
        else{
            today = Day[today].boom_root;
            if(today == 0)
                return today;
            undo(Map, Day, today);
        }
    }
    return today;
}

void print(DAY Day[], int d){
    for(int i = 1; i <= d; i++){
        if(Day[i].cmd == 2)
            printf("%d\n", Day[i].value);
    }
    return;
}

int main(void){
    int s, d; // numbers of shops and days
    scanf("%d%d", &s, &d);
    DAY *Day = malloc(sizeof(DAY)*(d+1));
    char cmd[10];
    //initialize Day, scan command, and struct a tree.
    for(int i = 0; i <= d; i++){
        Day[i].id = i;
        Day[i].cmd = 0;
        Day[i].flag = 0;
        Day[i].valid = 0;
        Day[i].value = 0;
        Day[i].boom_root = i;
        Day[i].Prev_day = NULL;
        Day[i].Next_day = NULL;
        Day[i].next_boom = NULL;
    }
    int Boom[d+1];
    for(int i = 0; i <= d; i++){
        Boom[i] = i;
    }
    for(int i = 1; i <= d; i++){
        scanf("%s", cmd);
        if(cmd[0] == 'm'){
            Day[i].cmd = 1;
            scanf("%d%d", &Day[i].a, &Day[i].b);
            Day[i].Prev_day = &Day[i-1];
            Day[i-1].Next_day = &Day[i];
        }
        else if(cmd[0] == 'q'){
            Day[i].cmd = 2;
            Day[i].Prev_day = &Day[i-1];
            Day[i-1].Next_day = &Day[i];
        }
        else{
            Day[i].cmd = 3;
            int boom;
            scanf("%d", &boom);
            Day[Boom[boom]].next_boom = &Day[i];
            Day[i].boom_root = Day[Boom[boom]].boom_root;
            Boom[boom] = i;
        }
    }
    /*
    for(int i = 0; i <= d; i++){
        if(Day[i].next_boom != NULL)
            printf("%d ", Day[i].next_boom->id);
        else
            printf("NULL ");
        if(Day[i].Next_day == NULL)
            printf("no next day\n");
        else
            printf("have next day\n");
    }
    */
    MAP *Map = malloc(sizeof(MAP)*(s+1));
    Map[0].value = s;
    for(int i = 1; i <= s; i++){
        Map[i].parent = i;
        Map[i].value = 1;
    }
    int today = 1;
    while(1){
        Day[today].flag = 1;
        if(Day[today].cmd == 1){
            int root1 = find_root(Map, Day[today].a);
            int root2 = find_root(Map, Day[today].b);
            if(root1 == root2){
                Day[today].valid = 0;
            }
            else{
                Day[today].valid = 1;
                if(Map[root1].value >= Map[root2].value){
                    Map[root2].parent = root1;
                    Map[root1].value += (Map[root1].value > Map[root2].value)? 0 : 1;
                    Day[today].c = 1;
                }
                else{
                    Map[root1].parent = root2;
                    Day[today].c = 2;
                }
                Map[0].value -= 1;
                
            }
        }
        else if(Day[today].cmd == 2){
            Day[today].valid = 0;
        } 
        else{
            Day[today].valid = 1;
        }
        Day[today].value = Map[0].value;
        if(Day[today].Next_day != NULL)
            today = Day[today].Next_day -> id;
        else{
            while(Day[today].next_boom == NULL){
                if(today == 0){
                    print(Day, d);
                    return 0;
                }
                today = undo(Map, Day, today);
                if(today == 0){
                    print(Day, d);
                    return 0;
                }
                today = Day[today].Prev_day -> id;
            }
            today = Day[today].next_boom -> id;
        }
    }
    return 0; 
}