#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

struct pizza
{
    int s, t, r;
};

bool comp(pizza a, pizza b)
{
    return (a.t * b.r) < (b.t * a.r);
}

int solve(vector<pizza> &pizzas, int N, int T)
{
    sort(pizzas.begin(), pizzas.end(), comp);

    vector<vector<int> > dp(N + 1, vector<int>(T + 1));

    for (int i = N - 1; i >= 0; i--)
    {
        for (int t = 0; t <= T; t++)
        {
            int sabor = 0;

            pizza pizzaAtual = pizzas[i];

            if (t + pizzaAtual.t <= T)
            {
                sabor = pizzaAtual.s - pizzaAtual.r * (t + pizzaAtual.t);
                sabor += dp[i + 1][t + pizzaAtual.t];
            }

            sabor = max(sabor, dp[i + 1][t]);

            dp[i][t] = sabor;
        }
    }

    return dp[0][0];
}

int main()
{
    int N, T;
    cin >> N >> T;

    vector<pizza> pizzas(N);
    for (int i = 0; i < N; ++i)
        cin >> pizzas[i].s >> pizzas[i].t >> pizzas[i].r;

    cout << solve(pizzas, N, T) << endl;
    return 0;
}