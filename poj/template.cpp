#include <iostream>
#include <cstring>
#include <cstdio>
#include <cstdlib>

using namespace std;

void display_help() {
    cout << "Usage: template <program_name>" << endl;
    cout << "<program_name> should only contains letters, numbers, '-' and '_'." << endl;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        display_help();
        //cout << "argc == " << argc << endl;
        return 1;
    }

    char *str = argv[0];
    while (*str) {
        // if any char in the string is not valid
        if ( !(
            (*str >= 'a' && *str <= 'z') ||
            (*str >= 'A' && *str <= 'Z') ||
            (*str >= '0' && *str <= '9') ||
            (*str == '-') ||
            (*str == '_')
           )  )
        {
            display_help();
            //cout << "argv[1] == " << argv[1] << endl;
            return 1;
        }
        ++str;
    }
    cout << "argv[1] == " << argv[1] << endl;
    char * name = argv[1];
    char cmd[200];
    sprintf(cmd, "mkdir %s", name); system (cmd);
    sprintf(cmd, "cp _t.cpp %s/%s.cpp", name, name); system (cmd);
    sprintf(cmd, "touch %s/%s.in", name); system (cmd);
    sprintf(cmd, "sed \"s/#/%s/g\" < _run.bat > %s/run.bat", name, name, name); system (cmd);
    return 0;
}


