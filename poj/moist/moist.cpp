#include <iostream>
#include <cstring>

using namespace std;

int main()
{
    int coden, t;
    cin >> t;
    // define vars
    char prev_name[110];
    char current[110];

    for (coden = 1; coden <= t; coden++) {
        int card_num;
        cin >> card_num;
        cin.getline(prev_name, 100);
        int result = 0;

        cin.getline(prev_name, 100);

        for (int i = 1; i < card_num; i++) {
            cin.getline(current, 100);
            //cout << "Get " " \"" << current << "\"" << endl;
            if (strcmp(current, prev_name) < 0) {
                //cout << "\"" << current << "\" < \"" << prev_name << "\"" << endl;
                ++result;
            } else {
                strcpy(prev_name, current);
            }
        }

        // output result
        cout << "Case #" << coden << ": " << result << endl;
    }
    return 0;
}

