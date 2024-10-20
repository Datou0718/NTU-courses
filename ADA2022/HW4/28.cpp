#include <bits/stdc++.h>
using namespace std;
#define ll long long
ll ans[401];
ll dp[401][401];
ll init[401][801];
int main(void)
{
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= n; j++)
        {
            ll x;
            cin >> x;
            init[i][j] = x;
            init[i][j + n] = x;
        }
    }
    for (int i = 1; i <= n; i++) // round
    {
        if (ans[1] < init[i][i])
            ans[1] = init[i][i];
        for (int j = 1; j <= n - i; j++)
        {
            if (j == 1)
            {
                for (int k = i; k < n; k++)
                {
                    dp[1][k] = init[i][k + 1];
                    ans[2] = max(ans[2], dp[1][k] + init[k + 1][i]);
                }
            }
            else
            {
                for (int k = j + i - 1; k < n; k++)
                {
                    dp[j][k] = 0;
                    for (int l = i + j - 2; l < k; l++)
                    {
                        dp[j][k] = max(dp[j][k], dp[j - 1][l] + init[l + 1][k + 1]);
                        ans[j + 1] = max(ans[j + 1], dp[j][k] + init[k + 1][i]);
                    }
                }
            }
        }
    }
    for (int i = 1; i <= n; i++)
    {
        cout << ans[i] << " ";
    }
    cout << "\n";
    return 0;
}