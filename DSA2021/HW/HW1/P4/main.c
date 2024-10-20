#include <stdio.h>
#include <string.h>
#include <ctype.h>

int isop(char c){
    if(c == '+' || c == '-' || c == '*' || c == '/' || c == '%')
        return 1;
    return 0;
}

int type(char c){
    if(c == '+')
        return 1;
    else if(c == '-')
        return 2;
    else if(c == '*')
        return 3;
    else if(c == '/')
        return 4;
    else if(c == '%')
        return 5;   
    return 0;
}

long long int divide(long long int a, long long int b){
    if(((a > 0 && b < 0) || (a < 0 && b > 0)) && a % b != 0){
        return (a/b-1);
    }
    else
        return (a/b);
}

int main(void){
    long long int ans = 0,cur = 0, mul = 1;
    int op = -1;
    char c;
    int mod = 0; //flag for mod
    int div = 0; //flag for divide
    while(1){
        scanf("%c", &c);
        if(c == EOF || c == ' ' || c == '\n'){
            return 0;
        }
        if(mod == 1 && !(isdigit(c)) && c != '('){
            mul %= cur;
            if(mul < 0)
                mul += cur;
            mod = 0;
            cur = 1;
        }
        if(div == 1 && !(isdigit(c)) && c != '('){
            mul = divide(mul, cur);
            div = 0;
            cur = 1;
        }
        if(c == ')'){
            ans += cur * mul;
            return ans;
        }
        if(c == '('){
            cur = main();
        }
        
        if(c == '='){
            ans += cur * mul;
            mul = ans;
            ans = 0;
            cur = 1;
            printf("Print: %lld\n", mul);
        }
        if(isdigit(c)){
            cur = cur*10 + c - '0';
        }
        if(isop(c)){
            op = type(c);
            switch(op){
                case 1:
                    ans += cur * mul;
                    cur = 0;
                    mul = 1; 
                    break;
                case 2:
                    ans += cur * mul;
                    cur = 0;
                    mul = -1;
                    break;
                case 3:
                    mul *= cur;
                    cur = 0;
                    break;
                case 4:
                    mul *= cur;
                    cur = 0;
                    div = 1;
                    break;
                case 5:
                    mul *= cur;
                    cur = 0;
                    mod = 1;
                    break;
            }
        }
    }
    return 0;
}
