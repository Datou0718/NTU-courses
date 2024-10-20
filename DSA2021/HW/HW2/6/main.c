#include <stdio.h>
#include <stdlib.h>

typedef struct node{
    int id;
    struct node *next;
}Node;

Node *gen_Node(int id){
    Node *new = malloc(sizeof(Node));
    new -> id = id;
    new -> next = NULL;
    return new;
}

typedef struct adj_list{
    Node *head;
    Node *tail;
}Adj_list;

Adj_list *gen_adj(){
    Adj_list *new = malloc(sizeof(Adj_list));
    new -> head = NULL;
    new -> tail = NULL;
    return new;
}

Adj_list **gen_list(int n){
    Adj_list **new = malloc(sizeof(Adj_list*)*n);
    for(int i = 0; i < n; i++){
        new[i] = gen_adj();
    }
    return new;
}

void Node_enter(Node *A, Adj_list *b){
    if(b -> head == NULL && b -> tail == NULL){
        b -> head = A;
        b -> tail = A;
        return;
    }
    b -> tail -> next = A;
    b -> tail = A;
    return;
}

void DFS(int road[], Adj_list **list, int start){
    Node *node = list[start] -> head;
    while(node != NULL){
        if(road[node -> id] == -1){
            road[node -> id] = start;
            DFS(road, list, node -> id);
            node = node -> next;
        }
        else
            node = node -> next;
    }
    return;
}

void make(int ans[], Adj_list **list, int road[], Node *node, int num){
    while(node != NULL){
        if(ans[node -> id] == -1){
            ans[node -> id] = num;
            make(ans, list, road, list[node -> id] -> head, num);
            node = node -> next;
        }
        else
            node = node -> next;
    }
    return;
}

int main(void){
    int n, q, s, r; // n for numbers of citys, numbers of queries, id of capital and id for resort
    scanf("%d%d%d%d", &n, &q, &s, &r);
    s -= 1;
    r -= 1;
    Adj_list **list = gen_list(n);
    int road[n];// road[i] stores the previous node of node i, starts from r
    int ans[n];
    int arr[n];
    for(int i = 0; i < n; i++){
        road[i] = -1;// -1 for empty
        ans[i] = -1;
        arr[i] = -1;
    }
    road[r] = r;
    for(int i = 0; i < n-1; i++){
        int a, b; // two cities that have road between them
        scanf("%d%d", &a, &b);
        a -= 1;
        b -= 1;
        Node *A = gen_Node(a);
        Node *B = gen_Node(b);
        Node_enter(A, list[b]);
        Node_enter(B, list[a]);
    }
    DFS(road, list, r);
    int tmp = s;
    int I = 0;
    while(tmp != r){
        arr[I] = tmp;
        ans[tmp] = tmp;
        I++;
        tmp = road[tmp]; 
    }
    arr[I] = r;
    ans[r] = r;
    for(int i = 0; i <= I; i++){
        make(ans, list, road, list[arr[i]] -> head, arr[i]);
    }
    for(int i = 0; i < q; i++){
        int o;
        scanf("%d", &o);
        o -= 1;
        printf("%d\n", ans[o]+1);
    }
    return 0;
}