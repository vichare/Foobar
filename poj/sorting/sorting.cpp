#include <iostream>
#include <vector>
#include <algorithm>
#include <cassert>

using namespace std;

int ori_book_value[2000];
int book_value[2000];
int odd[2000];
int even[2000];
int book_num;
int odd_num;
int even_num;

int main()
{
    int coden, t;
    cin >> t;
    // define vars

    for (coden = 1; coden <= t; coden++) {
        odd_num = 0;
        even_num = 0;
        cin >> book_num;
        
        for (int i = 0; i < book_num; i++) {
            cin >> ori_book_value[i];
            if (ori_book_value[i] % 2 == 0) {
                even[even_num] = ori_book_value[i];
                ++even_num;
            } else {
                odd[odd_num] = ori_book_value[i];
                ++odd_num;
            }
        }

        // sort
        sort(even, even+even_num);
        sort(odd, odd+odd_num);

        /*
        for (int i = 0; i < even_num; i++) {
            cout << even[i] << " ";
        }
        cout << endl;
        for (int i = 0; i < odd_num; i++) {
            cout << odd[i] << " ";
        }
        cout << endl;
        */

        // output result
        cout << "Case #" << coden << ":";
        int odd_pos = 0;
        for (int i = 0; i < book_num; i++) {
            if (ori_book_value[i] % 2 == 0) {
                // output a even number
                --even_num;
                assert(even_num >= 0);
                cout << " " << even[even_num];
            } else {
                cout << " " << odd[odd_pos];
                ++odd_pos;
                assert(odd_pos <= odd_num);
            }
        }
        cout << endl;
    }
    return 0;
}

