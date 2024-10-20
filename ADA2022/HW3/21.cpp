#include <bits/stdc++.h>
using namespace std;
#define ll long long

typedef struct node
{
    int destination;
    int distance;
    struct node *next;
} Node;

typedef struct adj_list
{
    Node *head;
    Node *tail;
} ADJ_List;

typedef struct SET
{
    ll idx;
    ll dis;
} Set;

class cmp
{
public:
    int operator()(const Set a, const Set b)
    {
        return a.dis > b.dis;
    }
};

int N, M, a, b, length;
ll ans = __LONG_LONG_MAX__;

int main(void)
{
    cin >> N >> M;
    ADJ_List *List = (ADJ_List *)malloc(sizeof(ADJ_List) * (N + 1));
    for (int i = 1; i <= N; i++)
    {
        List[i].head = NULL;
    }
    for (int i = 0; i < M; i++)
    {
        cin >> a >> b >> length;
        Node *newNode = (Node *)malloc(sizeof(Node));
        newNode->destination = b;
        newNode->distance = length;
        newNode->next = NULL;
        if (List[a].head == NULL)
        {
            List[a].head = newNode;
            List[a].tail = newNode;
        }
        else
        {
            List[a].tail->next = newNode;
            List[a].tail = List[a].tail->next;
        }
    }
    for (int i = 1; i <= N; i++)
    {
        priority_queue<Set, vector<Set>, cmp> min_heap;
        for (int j = 1; j <= N; j++)
        {
            Set tmp;
            tmp.idx = j;
            tmp.dis = (i == j || j == 1) ? 0 : __LONG_LONG_MAX__;
            min_heap.push(tmp);
        }
        int visited[N + 1];
        for (int j = 0; j <= N; j++)
            visited[j] = 0;
        ll sum = 0;
        while (!min_heap.empty())
        {
            ll now = min_heap.top().idx;
            ll dist = min_heap.top().dis;
            sum += dist;
            min_heap.pop();
            visited[now] = 1;
            Node *current = List[now].head;
            while (current != NULL)
            {
                Set newSet;
                newSet.idx = current->destination;
                newSet.dis = current->distance + dist;
                min_heap.push(newSet);
                current = current->next;
            }
            while ((!min_heap.empty()) && visited[min_heap.top().idx] != 0)
                min_heap.pop();
        }
        if (sum < ans)
            ans = sum;
    }
    cout << ans << "\n";
    return 0;
}