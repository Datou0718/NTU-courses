#include <stdio.h>
#include <string.h>

int fpow(int a, int b, int m)
{
    if (!b) return 1;
    int ans = fpow(a * a % m, b / 2, m);
    return (b % 2 ? ans * a % m : ans);
}

int d = 10;
int q = 17;

int main()
{
    char sT[100] = "3141592653589793", sP[10] = "41592";
    int p = 0, t = 0, AC = 0, WA = 0;
    int n = strlen(sT), m = strlen(sP), T[100], P[10];

    for (int i = 0; i < n; i++)
        T[i] = sT[i] - '0';
    for (int i = 0; i < m; i++)
        P[i] = sP[i] - '0';
    int h = fpow(d, m - 1, q);

    for (int i = 0; i < m; i++)
    {
        p = (d * p + (P[i])) % q;
        t = (d * t + (T[i])) % q;
    }

    printf("n = %d, m = %d, d = %d, h = %d, p = %d\n\n", n, m, d, h, p);

    for (int s = 0; s <= (n - m); s++)
    {
        for (int j = 0; j < m; j++)
            printf("%c", sT[s + j]);
        printf(": t = %d\n", t);

        if (p == t)
        {
            int ult = 1;
            for (int i = 0; i < m && ult; i++)
                if (P[i] != T[s + i])
                    ult = 0;
            if (ult)
                AC++;
            else
                WA++;
        }
        if (s < n - m)
        {
            t = (d * (t - h * T[s]) + T[s + m]) % q;
            if (t < 0)
                t += q;
        }
    }
    printf("\nexactly same = %d, spurious hits = %d\n", AC, WA);
}