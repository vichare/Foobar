#include <iostream>

using namespace std;

template<typename F>
void TripleCall(F f) {
    f();
    f();
    f();
}

int main() {
    int n = 5;
    cout << "Capture by reference." << endl;
    TripleCall ( [&n] () { 
        ++n;
        cout << n << endl;
    });
    cout << "After triple call, n = " << n << endl;

    n = 5;
    cout << "Capture by value, plus mutable." << endl;
    TripleCall ( [n] () mutable { 
        ++n;
        cout << n << endl;
    });
    cout << "After triple call, n = " << n << endl;

    return 0;
}

