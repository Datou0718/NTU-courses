#include <bits/stdc++.h>
using namespace std;
#define ll long long
int cmp(ll a, ll b)
{
    return a > b;
}

int n, weight, a, b;
char str[10], c;

int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    vector<ll> v;
    v.push_back(0);
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> str;
        char c = str[0];
        int len = v.size();
        if (c == 'P')
        {
            cin >> weight;
            v.push_back(v[len - 1] + weight);
        }
        else if (c == 'T')
        {
            cout << v[len - 1] - v[len - 2] << "\n";
            v.pop_back();
        }
        else if (c == 'C')
        {
            cin >> a >> b;
            ll arr[a], eat = 0;
            vector<ll> stack;
            for (int i = 0; i < a; i++)
            {
                ll tmp = v[len - 1] - v[len - 2];
                stack.push_back(tmp);
                arr[i] = tmp;
                v.pop_back();
                len--;
            }
            sort(arr, arr + a, cmp);
            ll border = (a % b == 0) ? arr[(a / b) - 1] : arr[a / b];
            for (int i = 0; i < a; i++)
            {
                if (stack[a - 1 - i] < border)
                {
                    v.push_back(v[len - 1] + stack[a - 1 - i]);
                    len++;
                }
                else
                    eat += stack[a - 1 - i];
                stack.pop_back();
            }
            cout << eat << "\n";
        }
        else if (c == 'D')
        {
            cin >> a;
            cout << v[len - 1] - v[len - 1 - a] << "\n";
        }
    }
    return 0;
}