#include <iostream>
#include <vector>
#include <cstring>
#include <cassert>

using namespace std;

const char name[10][10] = {
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
};

const char count[11][20] = {
    "",
    "",
    "double",
    "triple",
    "quadruple",
    "quintuple",
    "sextuple",
    "septuple",
    "octuple",
    "nonuple",
    "decuple"
};

void Output(int digit, int num) {
    if (num <= 0) return;
    if (num >=2 && num <= 10) {
        cout << " " << count[num] << " " << name[digit];
        return;
    } else  {
        for (int i = 0; i < num; i++) {
            cout << " " << name[digit];
        }
        return;
    }
}

int main()
{
    int coden, t;
    cin >> t;
    // define vars
    const int MAX_LEN = 110;
    char number[MAX_LEN+1];
    int number_len;
    int sep_len;

    int prev_digit = -1;
    int prev_number = 0;
    int cur_digit;

    for (coden = 1; coden <= t; coden++) {
        cin >> number;
        number_len = strlen(number);
        // output result
        cout << "Case #" << coden << ":";

        int pos = 0;
        while (number_len > 0) {
            cin >> sep_len;
            prev_digit = -1;
            prev_number = 0;
            for (int i = 0; i < sep_len; i++) {
                cur_digit = number[pos+i] - '0';
                //cout << "(" << cur_digit << ")";

                assert(prev_number >= 0);
                if (prev_number == 0) {
                    prev_digit = cur_digit;
                    prev_number = 1;
                } else if (cur_digit != prev_digit) {
                    Output(prev_digit, prev_number);
                    prev_digit = cur_digit;
                    prev_number = 1;
                } else {
                    ++prev_number;
                }
            }
            Output(prev_digit, prev_number);

            pos += sep_len;
            number_len -= sep_len;
            if (number_len <= 0) break;
            cin.get();
        }
        cout << endl;
    }
    return 0;
}

