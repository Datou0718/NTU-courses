#include <bits/stdc++.h>
#define ll long long
using namespace std;

ll arr[1000], maximum_sub_array[1000][1000];

int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll N, K;
    cin >> N >> K;
    for (ll i = 0; i < N; i++)
    {
        cin >> arr[i];
    }
    for (ll i = 0; i < N; i++)
    {
        ll max = arr[i], cur = 0;
        for (ll j = i; j < N; j++)
        {
            if (cur < 0)
                cur = 0;
            cur += arr[j];
            if (cur > max)
                max = cur;
            maximum_sub_array[i][j] = max * (j - i + 1);
        }
    }
    ll dp[1000][1001] = {{0}}; //[cut-1][len-1]
    for (ll i = 0; i < N; i++)
    {
        dp[0][i] = maximum_sub_array[i][N - 1];
    }
    for (int k = 1; k < K; k++) // cut
    {
        for (int n = 0; n < N - k; n++) // left_bound
        {
            ll minimum = __LONG_LONG_MAX__;
            for (int i = n; i < N - k; i++)
            {
                minimum = min(minimum, maximum_sub_array[n][i] + dp[k - 1][i + 1]);
            }
            dp[k][n] = minimum;
        }
    }
    cout << dp[K - 1][0] << "\n";
    return 0;
}