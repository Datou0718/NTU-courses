#include<bits/stdc++.h>
using namespace std;
int left_cnt[100001], right_cnt[100001];
long long cnt = 0;

void clean(){
    for(int i = 0; i < 100001; i++){
        left_cnt[i] = 0;
        right_cnt[i] = 0;
    }
    return;
}

void teleport(int power[], int left, int right){
    if(left >= right){
        return;
    }
    int mid = (left + right)/2;
    teleport(power, left, mid);
    teleport(power, mid+1, right);
    clean();
    int l = mid, r = mid+1;
    int min = power[l] > power[r]? power[r] : power[l];
    int min_dir = power[l] > power[r]? 1 : -1;
    int dir = power[l] > power[r]? -1 : 1;
    left_cnt[power[l]]++;
    right_cnt[power[r]]++;
    if(dir == -1)
        l--;
    else
        r++;
    while(l >= left && r <= right){
        left_cnt[power[l]]++;
        right_cnt[power[r]]++;
        if(power[l] < min){
            min = power[l];
            min_dir = -1;
        }
        if(power[r] < min){
            min = power[r];
            min_dir = 1;
        }
        if(min_dir == -1){
            cnt += right_cnt[power[l]+min];
            cnt += right_cnt[power[l]-min];
        }
        else if(min_dir == 1){
            cnt += left_cnt[power[r]+min];
            cnt += left_cnt[power[r]-min];
        }
        if(dir == 1){
            r++;
        }
        else{
            l--;
        }
    }
    while(l > left){
        l--;
        left_cnt[power[l]]++;
        if(power[l] < min){
            min = power[l];
            min_dir = -1;
        }
        if(min_dir == -1){
            cnt += right_cnt[power[l]+min];
            cnt += right_cnt[power[l]-min];
        }
        else if(min_dir == 1){
            cnt += left_cnt[power[r]+min];
            cnt += left_cnt[power[r]-min];
        }
    }
    while(r < right){
        r++;
        right_cnt[power[r]]++;
        if(power[r] < min){
            min = power[r];
            min_dir = 1;
        }
        if(min_dir == -1){
            cnt += right_cnt[power[l]+min];
            cnt += right_cnt[power[l]-min];
        }
        else if(min_dir == 1){
            cnt += left_cnt[power[r]+min];
            cnt += left_cnt[power[r]-min];
        }
    }
    return;
}

int main(void){
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    int power[500000];
    for(int i = 0; i < n; i++){
        cin >> power[i];
    }
    teleport(power, 0, n-1);
    cout << cnt << "\n";
    return 0;
}