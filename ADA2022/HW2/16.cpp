#include <bits/stdc++.h>
using namespace std;
#define ll long long
// 0~9 A~Z a~z
int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll operation, substract[75] = {0};
    queue<ll> position[75];
    char word[500005];
    cin >> word >> operation;
    ll len = strlen(word);
    for (ll i = 0; i < len; i++)
    {
        ll cnt = 0;
        for (ll j = 74; j > word[i] - '0'; j--)
        {
            cnt += position[j].size();
        }
        position[word[i] - '0'].push(cnt);
    }
    char ans[500005];
    for (ll i = 0; i < len; i++)
    {
        for (ll j = 0; j < 75; j++)
        {
            if (position[j].size() == 0)
                continue;
            if (position[j].front() - substract[j] <= operation)
            {
                ans[i] = j + '0';
                operation -= (position[j].front() - substract[j]);
                position[j].pop();
                break;
            }
            else
                substract[j]++;
        }
    }
    for (ll i = 0; i < len; i++)
        cout << ans[i];
    return 0;
}