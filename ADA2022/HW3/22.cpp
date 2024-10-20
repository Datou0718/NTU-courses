#include <bits/stdc++.h>
using namespace std;
#define ll long long

int N, M, parent, cnt;
typedef struct vertex
{
    ll start_time, end_time, c, d, total_c;
} Vertex;
vector<Vertex> VCT;
ll DP[3001][3001];
ll DFS(int v, vector<int> *path, Vertex *vtx)
{
    vtx[v].start_time = ++cnt;
    for (int i = 0; i < path[v].size(); i++)
    {
        vtx[v].total_c += DFS(path[v][i], path, vtx);
    }
    vtx[v].end_time = ++cnt;
    VCT.push_back(vtx[v]);
    return vtx[v].total_c;
}
int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cin >> N >> M;
    vector<int> path[N];
    vector<int> root;
    Vertex *v = (Vertex *)malloc(sizeof(Vertex) * N);
    for (int i = 0; i < N; i++)
    {
        cin >> parent;
        v[i].start_time = -1;
        v[i].end_time = -1;
        v[i].total_c = 0;
        if (parent == -1)
        {
            root.push_back(i);
        }
        else
        {
            path[parent].push_back(i);
        }
    }
    for (int i = 0; i < N; i++)
    {
        cin >> v[i].c >> v[i].d;
        v[i].total_c = v[i].c;
    }
    for (int i = 0; i < root.size(); i++)
    {
        DFS(root[i], path, v);
    }
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j <= M; j++)
        {
            if (VCT[i].c > j && VCT[i].d > j)
            {
                if (i > 0)
                    DP[i][j] = DP[i - 1][j];
            }
            else if (VCT[i].c <= j && VCT[i].d > j)
            {
                if (i == 0)
                    DP[i][j] = VCT[i].c;
                else
                    DP[i][j] = max(DP[i - 1][j - VCT[i].c] + VCT[i].c, DP[i - 1][j]);
            }
            else if (VCT[i].c > j && VCT[i].d <= j)
            {
                if (i > 0)
                {
                    if (i - (VCT[i].end_time - VCT[i].start_time + 1) / 2 >= 0)
                        DP[i][j] = max(DP[i - (VCT[i].end_time - VCT[i].start_time + 1) / 2][j - VCT[i].d] + VCT[i].total_c, DP[i - 1][j]);
                    else
                        DP[i][j] = max(VCT[i].total_c, DP[i - 1][j]);
                }
                else
                    DP[i][j] = VCT[i].c;
            }
            else
            {
                DP[i][j] = (i > 0) ? max(DP[i - 1][j - VCT[i].c] + VCT[i].c, DP[i - 1][j]) : VCT[i].c;
                if (i > 0)
                {
                    if (i - (VCT[i].end_time - VCT[i].start_time + 1) / 2 >= 0)
                        DP[i][j] = max(DP[i - (VCT[i].end_time - VCT[i].start_time + 1) / 2][j - VCT[i].d] + VCT[i].total_c, DP[i][j]);
                    else
                        DP[i][j] = max(VCT[i].total_c, DP[i][j]);
                }
            }
        }
    }
    cout << DP[N - 1][M] << "\n";
    return 0;
}