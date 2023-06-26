#include "lib.hpp"
#include <iostream>
#include <vector>

using namespace std;

vector<int> combine(vector<int> path1, vector<int> path2)
{
    int s1 = path1.size(), s2 = path2.size();
    int i = 0, j = 0;
    vector<int> helper;

    while (i < s1 && j < s2)
    {
        if (has_edge(path1[i], path2[j]))
        {
            helper.push_back(path1[i]);
            i++;
        }
        else
        {
            helper.push_back(path2[j]);
            j++;
        }
    }

    // se path1 não foi percorrido até o final
    while (i < s1)
    {
        helper.push_back(path1[i]);
        i++;
    }

    // se path2 não foi percorrido até o final
    while (j < s2)
    {
        helper.push_back(path2[j]);
        j++;
    }

    return helper;
}

vector<int> solve_aux(int inicio, int fim)
{
    vector<int> path_aux;
    if (inicio < fim)
    {
        int k = floor((fim + inicio) / 2);
        vector<int> path1 = solve_aux(inicio, k);
        vector<int> path2 = solve_aux(k + 1, fim);
        path_aux = combine(path1, path2);
    }
    else
    {
        path_aux.push_back(inicio);
    }

    return path_aux;
}

vector<int> solve(int n)
{
    vector<int> path = solve_aux(1, n);

    return path;
}

int main(int argc, char *argv[])
{

    char *filename = NULL;
    if (argc > 1)
        filename = argv[1];

    int n;
    initialize_has_edge(n, filename);

    vector<int> path = solve(n);
    int result = check_path(path, n);
    cout << result << '\n';
    return result;
}
