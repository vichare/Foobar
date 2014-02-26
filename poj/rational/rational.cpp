#include <iostream>
#include <vector>

using namespace std;

typedef unsigned long long ull;

int main()
{
    int coden, t;
    cin >> t;
    // define vars
    ull p, q, n;
    int pid;
    ull pos;
    int level;

    for (coden = 1; coden <= t; coden++) {
        cin >> pid;
        if (pid == 1) {
            cin >> n;
            p = 1;
            q = 1;

            int bitnum = 0;
            ull temp = n;
            while(temp > 0) {
                temp >>= 1;
                ++bitnum;
            }
            //cout << "bitnum = " << bitnum << endl;

            for (int i = bitnum-2; i >= 0; --i) {
                if (n & (((ull)1) << i)) {
                    // to the right
                    p += q;
                } else {
                    // to the left
                    q += p;
                }
            }

            // output result
            cout << "Case #" << coden << ": " << p << " " << q << endl;
        } else {
            cin >> p >> q;

            pos = 0;
            level = 0;
            while (p > 1 || q > 1) {
                if (p < q) { 
                    // on the left tree
                    // p/q -> p/(p+q)
                    q -= p;
                } else {
                    // on the right tree
                    // p/q -> (p+q)/q
                    p -= q;
                    pos |= ((ull)(1)) << level;
                }
                ++level;
            }
            pos |= ((ull)(1)) << level;

            // output result
            cout << "Case #" << coden << ": " << pos << endl;;
        }
    }
    return 0;
}

