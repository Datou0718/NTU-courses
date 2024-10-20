#include <bits/stdc++.h>
#define ll long long
using namespace std;

typedef struct member
{
    ll eat_time;
    ll cook_time;
} Member;

typedef struct group
{
    ll member_number;
    ll total_cook_time;
    ll total_time;
    double per_min;
} Group;

bool compare(Member a, Member b)
{
    return a.eat_time > b.eat_time;
}

bool cmp(Group a, Group b)
{
    return a.per_min > b.per_min;
}

Member people[100000];
Group gp[100000];

int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll group_number;
    cin >> group_number;
    for (int i = 0; i < group_number; i++)
    {
        cin >> gp[i].member_number;
        gp[i].total_cook_time = 0;
        gp[i].total_time = 0;
        for (int j = 0; j < gp[i].member_number; j++)
        {
            cin >> people[j].cook_time >> people[j].eat_time;
            gp[i].total_cook_time += people[j].cook_time;
        }
        sort(people, people + gp[i].member_number, compare);
        gp[i].total_time = people[gp[i].member_number - 1].eat_time + gp[i].total_cook_time;
        ll add = people[0].cook_time;
        for (int j = 0; j < gp[i].member_number; j++)
        {
            gp[i].total_time = max(gp[i].total_time, people[j].eat_time + add);
            add += people[j + 1].cook_time;
        }
        gp[i].per_min = double(gp[i].member_number) / double(gp[i].total_cook_time);
    }
    sort(gp, gp + group_number, cmp);
    ll t_time = 0, accumulate_time = 0;
    for (int i = 0; i < group_number; i++)
    {
        t_time += (gp[i].total_time + accumulate_time) * gp[i].member_number;
        accumulate_time += gp[i].total_cook_time;
    }
    cout << t_time << "\n";
    return 0;
}