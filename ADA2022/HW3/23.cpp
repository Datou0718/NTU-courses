#include <bits/stdc++.h>
using namespace std;
#define ll long long
int visited[400010];
typedef struct edge
{
    ll dest;
    ll src;
    ll len;
    ll cost;
} Edge;

typedef struct C
{
    ll largest;
    ll sum;
} COST;

COST Cost[400010];

struct cmp
{
    bool operator()(Edge a, Edge b)
    {
        if (a.len > b.len)
            return true;
        else if (a.len == b.len)
        {
            if (a.cost > b.cost)
                return true;
        }
        return false;
    }
};
vector<Edge> path[400010];
priority_queue<Edge, vector<Edge>, cmp> pq;
ll ans = 0;
int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll N, M;
    cin >> N >> M;
    ll min_a = -1, min_b = -1, min_len = __LONG_LONG_MAX__;
    for (int i = 0; i < M; i++)
    {
        ll a, b, len, cost;
        cin >> a >> b >> len >> cost;
        Edge A, B;
        A.src = a;
        A.dest = b;
        A.len = len;
        A.cost = cost;
        B.src = b;
        B.dest = a;
        B.len = len;
        B.cost = cost;
        path[a].push_back(A);
        path[b].push_back(B);
    }
    visited[0] = 1;
    for (int i = 0; i < path[0].size(); i++)
    {
        pq.push(path[0][i]);
    }
    for (int i = 0; i < N - 1; i++)
    {
        while (visited[pq.top().dest])
        {
            pq.pop();
        }
        Edge top = pq.top();
        visited[top.dest] = 1;
        Cost[top.dest].sum = top.cost;
        if (top.len > Cost[top.src].largest)
        {
            Cost[top.dest].largest = top.len;
        }
        else
        {
            Cost[top.dest].largest = Cost[top.src].largest;
        }
        for (int i = 0; i < path[top.dest].size(); i++)
        {
            if (!visited[path[top.dest][i].dest])
            {
                if (path[top.dest][i].len == Cost[top.dest].largest)
                    path[top.dest][i].cost += Cost[top.dest].sum;
                else if (path[top.dest][i].len < Cost[top.dest].largest)
                    path[top.dest][i].cost = Cost[top.dest].sum;
                pq.push(path[top.dest][i]);
            }
        }
    }
    for (int i = 1; i < N; i++)
    {
        // cout << Cost[i].sum << " " << Cost[i].largest << "\n";
        ans += Cost[i].sum;
    }
    cout << ans;
    return 0;
}