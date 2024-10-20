#include <bits/stdc++.h>
using namespace std;
#define ll long long
int visited[1000001];

typedef struct edge
{
    ll dest;
    ll len;
} Edge;

struct cmp
{
    bool operator()(Edge a, Edge b)
    {
        return a.len > b.len;
    }
};
vector<Edge> path[1000001];
priority_queue<Edge, vector<Edge>, cmp> pq;
int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll N, M;
    cin >> N >> M;
    ll min_a = -1, min_b = -1, min_len = __LONG_LONG_MAX__;
    for (int i = 0; i < M; i++)
    {
        ll a, b, len;
        cin >> a >> b >> len;
        Edge A, B;
        A.dest = b;
        A.len = len;
        B.dest = a;
        B.len = len;
        path[a].push_back(A);
        path[b].push_back(B);
    }
    visited[1] = 1;
    for (int i = 0; i < path[1].size(); i++)
    {
        pq.push(path[1][i]);
    }
    ll cnt = 0;
    for (int i = 0; i < N - 1; i++)
    {
        while (visited[pq.top().dest])
        {
            pq.pop();
        }
        Edge top = pq.top();
        visited[top.dest] = 1;
        cnt += top.len;
        for (int i = 0; i < path[top.dest].size(); i++)
        {
            pq.push(path[top.dest][i]);
        }
    }
    cout << cnt << "\n";
    return 0;
}