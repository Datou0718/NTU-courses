#include <bits/stdc++.h>

using namespace std;

double n, tau;
bool violation = false;

vector<vector<double>> read_input()
{
    cin >> n;
    cin >> tau;
    vector<vector<double>> input_data(n, vector<double>(3));
    for (int i = 0; i < n; i++)
        cin >> input_data[i][0] >> input_data[i][1] >> input_data[i][2];
    return input_data;
}

double calc(vector<vector<double>> data)
{
    double sum = 0;
    for (int i = 0; i < n; i++)
    {
        double LHS = -1, RHS = data[i][1];
        while (LHS != RHS)
        {
            LHS = RHS;
            double blocking_time = 0, sigma = 0;
            for (int j = 0; j < n; j++)
            {
                if (data[j][0] >= data[i][0])
                    blocking_time = max(blocking_time, data[j][1]);
            }
            for (int j = 0; j < n; j++)
            {
                if (data[j][0] < data[i][0])
                    sigma += ceil((LHS + tau) / data[j][2]) * data[j][1];
            }
            RHS = blocking_time + sigma;
            if (RHS + data[i][1] > data[i][2])
                violation = true;
        }
        sum += RHS + data[i][1];
    }
    return sum;
}

void swap_priority(vector<vector<double>> &data)
{
    int size = data.size();
    int i = rand() % size, j = rand() % size;
    swap(data[i][0], data[j][0]);
}

void print_answer(vector<vector<double>> input_data, double sum)
{
    cout << "Priority: \n";
    for (int i = 0; i < n; i++)
        cout << input_data[i][0] << "\n";

    cout << "Objective Value: " << sum << "\n";
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    srand(time(NULL));

    // priority, transmission_time, period
    vector<vector<double>> input_data = read_input();

    double T = 1000, r = 0.999;
    double sum = calc(input_data);
    double temp = sum;
    while (T > 0.0001)
    {
        vector<vector<double>> temp_data = input_data;
        swap_priority(temp_data);
        temp = calc(temp_data);
        if (violation)
        {
            violation = false;
            continue;
        }
        double delta = temp - sum;
        if (delta < 0)
        {
            sum = temp;
            input_data = temp_data;
        }
        else
        {
            double prob = exp(-delta / T);
            double random = (double)rand() / RAND_MAX;
            if (random < prob)
            {
                sum = temp;
                input_data = temp_data;
            }
        }
        T *= r;
    }
    print_answer(input_data, sum);
    return 0;
}