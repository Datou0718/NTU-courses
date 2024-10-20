#include<stdio.h>

int main(){
    int a = 1;
    char b = '+';
    char c = '=';
    printf("%d", a);
    for(int i = 0; i < 300000; i++){
        printf("%c%d%c", b, a, c);
    }
    return 0;
}