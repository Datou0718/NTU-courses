#include<bits/stdc++.h>
using namespace std;
int cnt = 0;
void tower(int l, int r){
    if(l == r){
        return;
    }
    tower(l, (l+r)/2);
    for(int i = l; i <= r; i++){
        cout << "POP\n";
        cnt++;
    }
    for(int i = (l+r)/2; i >= l; i--){
        cout << "PLACE " << i << "\n";
        cnt++;
    }
    for(int i = r; i >= (l+r)/2+1; i--){
        cout << "PLACE " << i << "\n";
        cnt++;
    }
    cout << "PHOTO\n";
    cnt++;
    tower((l+r)/2+1, r);
    return;
}

int main(void){
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    cout << 40 * n << endl;
    for(int i = n; i > 0; i--){
        cout << "PLACE " << i << "\n";
        cnt++;
    }
    cout << "PHOTO\n";
    cnt++;
    tower(1, n);
    cout << "POP\n";
    cnt++;
    for(int i = cnt; i <= 40*n; i++){
        cout << "PLACE " << n << "\n";
        cnt++;
        if(cnt == 40*n)
            return 0;
        cout << "POP\n";
        cnt++;
    }
    return 0;
}