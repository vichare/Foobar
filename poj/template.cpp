#include <iostream>
#include <sstream>
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

    char *str = argv[1];
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
    char * name = argv[1];

    ostringstream cmd;

    cmd << "mkdir " << name;
    cout << cmd.str() << endl;
    system(cmd.str().c_str());
    cmd.str("");

    cmd << "cp _t.cpp " << name << "/" << name << ".cpp";
    cout << cmd.str() << endl;
    system(cmd.str().c_str());
    cmd.str("");

    cmd << "touch " << name << "/" << name << ".in";
    cout << cmd.str() << endl;
    system(cmd.str().c_str());
    cmd.str("");

    cmd << "sed \"s/#/" << name << "/g\" < _run.bat > " << name << "/run.bat";
    cout << cmd.str() << endl;
    system(cmd.str().c_str());
    cmd.str("");

    cmd << "sed \"s/%PROGRAM%/" << name << "/g\" < _run > " << name << "/run";
    cout << cmd.str() << endl;
    system(cmd.str().c_str());
    cmd.str("");

    return 0;
}


