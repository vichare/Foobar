#include <iostream>
#include <cassert>

using namespace std;

const int MAX_MEMBER_NUM = 200;

struct Member {
    string name;
    int color; // -1 for no color, 0 for white, 1 for black
} member[MAX_MEMBER_NUM];
int member_num;

char pairs[MAX_MEMBER_NUM][MAX_MEMBER_NUM];

int AddMember(const string& name) { 
    // add the member if the name has not been add
    // return the id of the member;

    // check for duplicate
    for (int i = 0; i < member_num; i++) {
        if (member[i].name == name) {
            // duplicate
            return i;
        }
    }
    // no duplicate
    member[member_num].name = name;
    member[member_num].color = -1;
    ++member_num;
    assert(member_num <= MAX_MEMBER_NUM);

    return (member_num - 1);
}

// paint an member and its enemy
// return false if not feasible
bool Paint(int id, int color) {
    //cout << "Paint " << id << ", " << color << endl;
    assert(color == 0 || color == 1);
    if (member[id].color == -1) {
        // unpaint: paint and paint all its enemy
        member[id].color = color;
        for (int i = 0; i < member_num; i++) {
            if(pairs[id][i]) {
                if (!Paint(i, 1 - color)){
                    return false;
                }
            }
        }
        return true;
    } else {
        // paint: if color = its color, then feasible, otherwise unfeasible
        return (member[id].color == color);
    }
    //cout << "@Paint " << id << ", " << color << endl;
}

bool Feasible() {
    // input: member[0 ... member_num-1], pairs[0 ... pair_num-1][0...1]
    // return: feasible
    for (int i = 0; i < member_num; i++) {
        // if i has not been painted, paint and paint its enemy
        //cout << "Feasible #" << i << endl;
        if (member[i].color == -1) {
            // DFS
            if (!Paint(i, 0)) { // abitraryly paint an color
                return false;
            }
        }
    }
    return true;
}

int main()
{
    int coden, t;
    cin >> t;
    // define vars
    //cout << t << " cases." << endl;

    for (coden = 1; coden <= t; coden++) {
        bool feasible = true;
        string name;
        member_num = 0;

        int pair_num;
        cin >> pair_num;

        //cout << "OK 1" << endl;
        // TODO:clear pairs
        for (int i = 0; i < MAX_MEMBER_NUM; i++)
        for (int j = 0; j < MAX_MEMBER_NUM; j++) {
            pairs[i][j] = 0;
        }
        //cout << "OK 2" << endl;

        for (int i = 0; i < pair_num; i++) {
            cin >> name;
            int m1 = AddMember(name);
            cin >> name;
            int m2 = AddMember(name);
            pairs[m1][m2] = 1;
            pairs[m2][m1] = 1;
        }
        //cout << "OK 3" << endl;

        feasible = Feasible();
        //cout << "OK 4" << endl;

        // output result
        cout << "Case #" << coden << ": ";
        cout << (feasible ? "Yes" : "No") << endl;
    }
    return 0;
}

