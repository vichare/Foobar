#include <iostream>
#include <cstdlib>

using namespace std;

const int N = 11;
int color[N];

long long run() {
    long long count = 0;
    // At first, every ball is of different colors
    for (int i = 0; i < N; i++) {
        color[i] = i;
    }

    bool running = true;
    while (running) {
        ++count;
        // randomly pick two balls
        int b1 = rand() % N;
        int b2 = rand() % (N-1);
        if (b2 >= b1)
            ++b2;

        // change the color of second ball to the first
        color[b2] = color[b1];

        // if there is only one color, stop
        running = false;
        for (int i = 1; i < N; i++) {
            running = running || (color[i] != color[0]);
        }
    }

    return count;
}

int main() {
    long long testnum = 1;
    long long countsum = 0;

    while (1) {
        ++testnum;
        countsum += run();

        if (!(testnum & (testnum - 1))) {
            cout << "#" << testnum << "\taverage = " << (double(countsum) / testnum) << endl;
        }
    }

    return 0;
}

