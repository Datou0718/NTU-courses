#include <bits/stdc++.h>
#define ll long long
using namespace std;

vector<ll> edge[200010], reverse_edge[200010], group[200010], path;
int visited[200010];

void dfs(int i)
{
    if (visited[i] == 1)
        return;
    visited[i] = 1;
    for (auto tmp : edge[i])
        dfs(tmp);
    path.push_back(i);
    return;
}

void rev_dfs(int i, int root)
{
    if (visited[i] == 1)
        return;
    visited[i] = 1;
    group[root].push_back(i);
    for (auto tmp : reverse_edge[i])
        rev_dfs(tmp, root);
    return;
}

int main(void)
{
    int a, b;
    cin >> a >> b;
    int tmpA, tmpB;
    for (int i = 0; i < b; i++)
    {
        cin >> tmpA >> tmpB;
        edge[tmpA].push_back(tmpB);
        reverse_edge[tmpB].push_back(tmpA);
    }
    for (int i = 0; i < a; i++)
    {
        if (visited[i] == 0)
            dfs(i);
    }
    memset(visited, 0, sizeof(visited));
    for (int i = path.size() - 1; i >= 0; i--)
    {
        if (visited[path[i]] == 0)
            rev_dfs(path[i], path[i]);
    }
    ll cnt = 0;
    for (int i = 0; i < a; i++)
    {
        cnt += (group[i].size() * (group[i].size() - 1) / 2);
    }
    cout << cnt << "\n";
    return 0;
}