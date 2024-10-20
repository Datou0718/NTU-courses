#include <bits/stdc++.h>
using namespace std;
#define ll long long

string code[50];

typedef struct MinHeapNode
{
    ll frequency;
    int index;
    struct MinHeapNode *left;
    struct MinHeapNode *right;
} Node;

struct compare
{
    bool operator()(Node *a, Node *b)
    {
        return (a->frequency > b->frequency);
    }
};

void print(Node *node, string str)
{
    if (node == NULL)
        return;
    if (node->index != -1)
        code[node->index] = str;
    print(node->left, str + "0");
    print(node->right, str + "1");
    return;
}

void HuffmanCode(int n)
{
    priority_queue<Node *, vector<Node *>, compare> pq;
    for (int i = 0; i < n; i++)
    {
        Node *node = new Node;
        cin >> node->frequency;
        node->index = i;
        node->left = NULL;
        node->right = NULL;
        pq.push(node);
    }
    Node *left, *right, *top;
    while (pq.size() > 1)
    {
        left = pq.top();
        pq.pop();
        right = pq.top();
        pq.pop();
        Node *NEW = new Node;
        NEW->left = left;
        NEW->right = right;
        NEW->frequency = left->frequency + right->frequency;
        NEW->index = -1;
        pq.push(NEW);
    }
    print(pq.top(), "");
    for (int i = 0; i < n; i++)
    {
        cout << code[i] << "\n";
    }
    return;
}

int main(void)
{
    int n;
    cin >> n;
    if (n == 1)
    {
        cout << 0 << "\n";
        return 0;
    }
    HuffmanCode(n);
    return 0;
}