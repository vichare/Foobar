#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

const double PI = 3.1415926535897983;

int main()
{
    int coden, t;
    cin >> t;
    // define vars

    for (coden = 1; coden <= t; coden++) {
        int V;
        int D;
        cin >> V >> D;
        double f = D * double(9.8);
        f /= V;
        f /= V;
        if (f > 1) f = 1;
        double ang = asin(f)*(180/PI) / 2;

        // output result
        cout.precision(10);
        cout << "Case #" << coden << ": " << ang << endl;

    }
    return 0;
}

