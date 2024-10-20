#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int compare(char *a, char *b, int len){
    char *str = malloc(sizeof(char)*2*len+100);
    str = strcpy(str,a);
    strcat(str, b);
    int max = 0;
    int k = 0;
    int pi[len*2];
    pi[0] = 0;
    for(int i = 1; i < len*2; i++){
        if(i == len){
            k = 0;
        }
        while(k > 0 && str[i] != str[k]){
            k = pi[k-1];
        }
        if(str[i] == str[k])
            k++;
        pi[i] = k;
        if(i > len && k > max)
            max = k;
    }
    return len-max;
}

int main(void){
    char *str = malloc(sizeof(char)*20000000);
    int cnt = 0;
    scanf("%s", str);
    int len = strlen(str);
    char opposite[len+1];
    for(int i = len-1; i >= 0; i--){
        opposite[i] = str[len-1-i];
    }
    opposite[len] = '\0'; 
    int before = compare(str, opposite, len);
    int after = compare(opposite, str, len);
    printf("%d\n", (before < after)? before : after);
    if(before <= after){
        for(int i = 0; i < before; i++){
            printf("%c", opposite[i]);
        }
        printf("%s\n", str);
    }
    if(before >= after){
        if(before == 0)
            return 0;
        printf("%s", str);
        for(int i = len - after; i < len; i++){
            printf("%c", opposite[i]);
        }
        printf("\n");
    }
    return 0;
}