#include <bits/stdc++.h>
using namespace std;
int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    char str1[3001], str2[3001];
    cin >> str1 >> str2;
    int len1 = strlen(str1), len2 = strlen(str2);
    int table[len1 + 1][len2 + 1];
    for (int i = 0; i < len1 + 1; i++)
    {
        table[i][0] = i;
    }
    for (int i = 0; i < len2 + 1; i++)
    {
        table[0][i] = i;
    }
    for (int i = 1; i < len1 + 1; i++)
    {
        for (int j = 1; j < len2 + 1; j++)
        {
            if (str1[i - 1] == str2[j - 1])
                table[i][j] = table[i - 1][j - 1];
            else
            {
                int tmp = min(table[i - 1][j - 1], table[i - 1][j]);
                table[i][j] = min(tmp, table[i][j - 1]) + 1;
            }
        }
    }
    cout << table[len1][len2] << "\n";
    return 0;
}