#include <stdio.h>
#include "price.h"
#include <stdlib.h>
#define ull unsigned long long int 

typedef struct STOCK{
    ull value;
    ull stock;
}Stock;

void insert(ull tmp, Stock min[]){
    while(min[tmp].value < min[tmp/2].value&&tmp!=1){
        ull TMP = min[tmp].value;
        min[tmp].value = min[tmp/2].value;
        min[tmp/2].value = TMP;
        ull s = min[tmp].stock;
        min[tmp].stock = min[tmp/2].stock;
        min[tmp/2].stock = s;
        tmp = tmp/2;
        if(tmp == 1 || tmp == 0)
            break;
    }
    return;
}

void reverse(Stock min[], ull a, ull n){
    ull tmp = 1;
    while((tmp*2 < a*n+1 && min[tmp].value > min[tmp*2].value) || (tmp*2+1 < a*n+1 && min[tmp].value > min[tmp*2+1].value)){
        if(tmp * 2 + 1 < a*n+1){
            ull smaller = (min[tmp*2].value > min[tmp*2+1].value)? tmp*2+1 : tmp*2;
            ull TMP = min[tmp].value;
            min[tmp].value = min[smaller].value;
            min[smaller].value = TMP;
            ull s = min[tmp].stock;
            min[tmp].stock = min[smaller].stock;
            min[smaller].stock = s;
            tmp = smaller;
        }
        else if(tmp * 2 + 1 >= a*n+1){
            ull TMP = min[tmp].value;
            min[tmp].value = min[tmp*2].value;
            min[tmp*2].value = TMP;
            ull s = min[tmp].stock;
            min[tmp].stock = min[tmp*2].stock;
            min[tmp*2].stock = s;
            tmp = tmp*2;
        }
    }
    return;
}

int main(void){
    ull A, Q, N; //A for stocks, Q for queries, N for increase days
    scanf("%llu%llu%llu", &A, &Q, &N);

    ull stock[A];
    for(ull i = 0; i < A; i++){
        scanf("%llu", &stock[i]);
    }

    Stock min[A*N+1];
    ull day[A];
    for(ull i = 0; i < A; i++){
        day[i] = N+1;
    }
    for(ull i = 0; i < A; i++){
        for(ull j = 1; j <= N; j++){
            min[i*N+j].value = price(stock[i],j);
            min[i*N+j].stock = i;
            insert(i*N+j, min);
        }
    }

    ull *ans=(ull *)malloc(1000000*sizeof(ull));

    for(ull i = 0; i < 1000000; i++){
        ans[i] = min[1].value;
        min[1].value = price(stock[min[1].stock], day[min[1].stock]);
        day[min[1].stock]++;
        reverse(min, A, N);
    }
    
    ull s, k;
    for(ull i = 0; i < Q; i++){
        scanf("%llu%llu", &s, &k);
        if(s == 0){
            printf("%llu\n", ans[k-1]);
        }
    }
    
    return 0;
}