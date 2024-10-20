#include<bits/stdc++.h>
using namespace std;
int main(void){
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int arr[300010];
    int n;
    cin >> n;
    cin >> arr[0];
    long long max = arr[0];
    long long cur = arr[0];
    for(int i = 1; i < n; i++){
        cin >> arr[i];
        if(cur < 0)
            cur = 0;
        cur += arr[i];
        if(cur > max)
            max = cur;
    }
    cout << max;
    return 0;
}