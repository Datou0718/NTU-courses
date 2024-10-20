#include <bits/stdc++.h>
#define ll long long
using namespace std;

typedef struct coordinate
{
    ll x;
    ll y;
} cord;

int compare(const void *a, const void *b)
{
    const cord *A = (cord *)a;
    const cord *B = (cord *)b;
    if (A->x > B->x || (A->x == B->x && A->y > B->y))
    {
        return 1;
    }
    else if (A->x < B->x || (A->x == B->x && A->y < B->y))
    {
        return -1;
    }
    return 0;
}

ll Merge(cord arr[], cord tmp[], int left, int mid, int right)
{
    int left_index = left, right_index = mid, tmp_index = left;
    ll cnt = 0;
    while (left_index <= mid - 1 && right_index <= right)
    {
        if (arr[left_index].y <= arr[right_index].y)
        {
            tmp[tmp_index].x = arr[left_index].x;
            tmp[tmp_index].y = arr[left_index].y;
            tmp_index++;
            left_index++;
        }
        else
        {
            tmp[tmp_index].x = arr[right_index].x;
            tmp[tmp_index].y = arr[right_index].y;
            tmp_index++;
            right_index++;
            cnt += mid - left_index;
        }
    }
    while (left_index <= mid - 1)
    {
        tmp[tmp_index].x = arr[left_index].x;
        tmp[tmp_index].y = arr[left_index].y;
        tmp_index++;
        left_index++;
    }
    while (right_index <= right)
    {
        tmp[tmp_index].x = arr[right_index].x;
        tmp[tmp_index].y = arr[right_index].y;
        tmp_index++;
        right_index++;
    }
    for (int i = left; i <= right; i++)
    {
        arr[i].x = tmp[i].x;
        arr[i].y = tmp[i].y;
    }
    return cnt;
}

ll merge_sort(cord arr[], cord tmp[], int left, int right)
{
    int mid = (left + right) / 2;
    ll cnt = 0;
    if (left >= right)
    {
        return 0;
    }
    cnt += merge_sort(arr, tmp, left, mid);
    cnt += merge_sort(arr, tmp, mid + 1, right);
    cnt += Merge(arr, tmp, left, mid + 1, right);
    return cnt;
}

ll inv_merge_sort(cord arr[], int n)
{
    cord tmp[n];
    return merge_sort(arr, tmp, 0, n - 1);
}

int main(void)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    ll n, l1, l2, r1, r2;
    cin >> n >> l1 >> l2 >> r1 >> r2;
    cord pair[n];
    ll x, y;
    for (int i = 0; i < n; i++)
    {
        cin >> x >> y;
        pair[i].x = r1 * x - r2 * y;
        pair[i].y = -l1 * x + l2 * y;
    }
    qsort(pair, n, sizeof(cord), compare);
    cout << n * (n - 1) / 2 - inv_merge_sort(pair, n) << "\n";
    return 0;
}