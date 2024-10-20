#include <bits/stdc++.h>
using namespace std;
#define ll long long
int dp[2][301][301];
int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll N, K, M;
    cin >> N >> K >> M;
    for (int i = 0; i <= N; i++)
    {
        for (int j = 0; j <= K; j++)
        {
            for (int k = 0; k <= j; k++)
            {
                if (i == 0)
                    dp[1][j][k] = 1;
                else
                {
                    if (j == 0 && k == 0)
                        dp[1][j][k] = 1;
                    else if (k == 0)
                        dp[1][j][k] = (dp[1][j - 1][k] + dp[0][j][k] >= M) ? -M + dp[1][j - 1][k] + dp[0][j][k] : dp[1][j - 1][k] + dp[0][j][k];
                    else
                    {
                        if (j != k)
                        {
                            ll a = dp[1][j - 1][k] + dp[1][j][k - 1] >= M ? -M + dp[1][j - 1][k] +
                                                                                dp[1][j][k - 1]
                                                                          : dp[1][j - 1][k] + dp[1][j][k - 1];
                            a = a + dp[0][j][k] >= M ? -M + a + dp[0][j][k] : a + dp[0][j][k];
                            dp[1][j][k] = a - dp[1][j - 1][k - 1] - dp[0][j - 1][k - 1];
                            while (dp[1][j][k] < 0)
                                dp[1][j][k] += M;
                        }
                        else
                        {
                            ll a = dp[1][j][k - 1] + dp[0][j][k] >= M ? -M + dp[1][j][k - 1] + dp[0][j][k] : dp[1][j][k - 1] + dp[0][j][k];
                            dp[1][j][k] = a - dp[0][j - 1][k - 1];
                            while (dp[1][j][k] < 0)
                                dp[1][j][k] += M;
                        }
                    }
                }
            }
        }
        for (int i = 0; i <= K; i++)
        {
            for (int j = 0; j <= K; j++)
            {
                dp[0][i][j] = dp[1][i][j];
            }
        }
    }
    cout << dp[0][K][K] << "\n";
    return 0;
}