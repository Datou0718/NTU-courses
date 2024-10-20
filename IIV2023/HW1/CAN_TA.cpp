/*
1.44
2.04
2.56
3.16
3.68
4.28
5.2
8.4
9
9.68
10.2
19.36
19.8
20.32
29.4
29.76
30.28
*/

#include <bits/stdc++.h>
using namespace std;

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    double n, tau;
    cin >> n >> tau; // n = number of messages, tau = time doubleerval
    vector<double> priority(n), transmission_time(n), period(n), response_time(n, 0);

    for (int i = 0; i < n; i++)
        cin >> priority[i] >> transmission_time[i] >> period[i];

    for (int i = 0; i < n; i++)
    {
        double LHS = -1, RHS = transmission_time[i];
        while (LHS != RHS)
        {
            LHS = RHS;
            double blocking_time = 0, sigma = 0;
            for (int j = 0; j < n; j++)
            {
                if (priority[j] >= priority[i])
                    blocking_time = max(blocking_time, transmission_time[j]);
            }
            for (int j = 0; j < n; j++)
            {
                if (priority[j] < priority[i])
                    sigma += ceil((LHS + tau) / period[j]) * transmission_time[j];
            }
            RHS = blocking_time + sigma;
        }
        response_time[i] = RHS + transmission_time[i];
    }

    for (int i = 0; i < n; i++)
        cout << response_time[i] << "\n";

    return 0;
}