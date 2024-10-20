#include<bits/stdc++.h>
using namespace std;

int compare(const void *a, const void *b){
    const int *x = (int*) a;
    const int *y = (int*) b;
    return (*x - *y);
}

int main(void){
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n, w; // n for how many kinds of gems, w for the amount of money
    cin >> n >> w;
    int price[n+1];
    price[0] = __INT_MAX__;
    for(int i = 1; i <= n; i++){
        cin >> price[i];
    }
    qsort(price, n+1, sizeof(int), compare);
    int origin[w+1];
    for(int i = 0; i <= w; i++){
        origin[i] = i;
    }
    int index = 0;
    for(int i = 1; i <= w; i++){
        while(index < n && i >= price[index+1]){
            index++;
        }
        int tmp = index;
        while(tmp >= 0 && origin[i] != 0){
            origin[i] %= price[tmp];
            tmp--;
        }
    }
    int dp[w+1];
    dp[0] = 0;
    int cnt = 1;
    int flag = 0;
    for(int i = 1; i <= w; i++){
        for(int j = 0; j < n; j++){
            if(price[j] > i)
                break;
            if(dp[i - price[j]] == 0){
                cnt = 1;
                dp[i] = 0;
                flag = 1;
                break;
            }
        }
        if(flag == 0){
            dp[i] = cnt;
            cnt++;
        }
        flag = 0;
    }
    for(int i = 1; i <= w; i++){
        cout << origin[i] - dp[i] << endl;
    }
    return 0;
}