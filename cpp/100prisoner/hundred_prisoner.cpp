// 
// Monte Carlo method to testify a math problem
// http://www.zhihu.com/question/27050108
//
// Randomly generate a permutation of number 0-99
// Find the probability that the longest loop is longer than 50
//
#include <iostream>
#include <ctime>
#include <cstdlib>

using namespace std;

const int N = 100;

void display_tables(int p[]) {
    for (int i = 0; i < N; i++) {
        cout << p[i] << ' ';
    }
    cout << endl;
}

void generate_tables(int p[]) {
    for (int i = 0; i < N; i++) {
        p[i] = i;
    }
    for (int i = 0; i < N; i++) {
        int n = rand() % (N - i);

        // swap p[i], p[i + n]
        int t = p[i];
        p[i] = p[i + n];
        p[i + n] = t;
    }
}

// return the length of the longest loop
int longest_loop(const int p[]) {
    static bool flag[N];
    int max_length = 0;
    for (int i = 0; i < N; i++) {
        flag[i] = false;
    }
    for (int i = 0; i < N; i++) {
        if (flag[i]) continue;

        int count = 1;
        int ind = i;
        flag[ind] = true;
        while (p[ind] != i) {
            ind = p[ind];
            flag[ind] = true;
            ++count;
        }

        if (count > max_length) {
            max_length = count;
        }
    }
    return max_length;
}

int main() {
    int p[N];
    srand(time(0));
    
    long long win_count = 0;
    for (long long i = 0; i >= 0; i++) {
        generate_tables(p);
        //display_tables(p);
        int l = longest_loop(p);
        if (l <= 50) {
            ++win_count;
        }
        if (!(i & (i - 1))) {
            cout << (double(win_count) / i) << "(" << win_count << "/" << i << ")" << endl;
        }
    }
    return 0;
}

