#include "choose.h"
#include <bits/stdc++.h>
using namespace std;
bool cmp(int a, int b)
{
    return (compare_task(a, b) == 1);
}
void schedule(int N)
{
    int arr[N];
    for (int i = 0; i < N; i++)
    {
        arr[i] = i + 1;
    }
    sort(arr, arr + N, cmp);
    int time1 = 0, time2 = 0;
    for (int i = 0; i < N; i++)
    {
        if (time1 <= time2)
            time1 = assign_task(1, arr[i]);
        else
            time2 = assign_task(2, arr[i]);
    }
    return;
}