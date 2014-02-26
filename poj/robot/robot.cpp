#include <iostream>
#include <vector>

using namespace std;

const int dir[4][2] = {{0, -1}, {1, 0}, {0, 1}, {-1, 0}};
const char dirname[5] = "NESW";
char maze[1010][1010];
bool reached[1010][1010];
char path[10010];

int main()
{
    int coden, t;
    cin >> t;
    // define vars
    int N;
    int start_x, start_y;
    int x, y;
    int end_x, end_y;
    int face;

    for (coden = 1; coden <= t; coden++) {
        cin >> N;
        for (int i = 1; i <= N ; i++) {
            cin >> (maze[i]+1);
        }
        cin >> start_y >> start_x >> end_y >> end_x;

        // fill the outer wall
        for (int i = 0; i <= N+1; i++) {
            maze[0][i] = '#';
            maze[N+1][i] = '#';
            maze[i][0] = '#';
            maze[i][N+1] = '#';
        }

        if (start_x == 1 && start_y == 1) {
            face = 1; // East
        } else {
            face = 2; // South
        }

        /*
        // init reached
        for (int i = 0; i <= N+1; i++) {
            for (int j = 0; j <= N+1; j++) {
                reached[i][j] = false;
            }
        }
        */
        /*
        for (int i = 0; i <= N+1; i++) {
            for (int j = 0; j <= N+1; j++) {
                cout << maze[i][j];
            }
            cout << endl;
        }
        */

        x = start_x;
        y = start_y;
        bool getout = false;
        int step;
        for (step = 0; step < 10000; step++) {
            //cout << "(" << x << ", " << y <<")" << endl;
            if (step > 0) {
                // ture left first
                face += 3; 
                face %= 4;
            }
            for (int i = 0; i < 4; i++) {
                // if facing a wall, turn right
                // (x+dir[face][0], y+dir[face][1])
                if (maze[y + dir[face][1]][x + dir[face][0]] == '#') {
                    //cout << "(" << x+dir[face][0] << ", " << y+dir[face][1] <<") == #" << endl;
                    ++face;
                    face %= 4;
                }
            }
            // if still facing a wall, can't get out
            if (maze[y + dir[face][1]][x + dir[face][0]] == '#') {
                break;
            }

            // move forward
            x += dir[face][0];
            y += dir[face][1];
            path[step] = dirname[face];

            // if gets out
            if (x == end_x && y == end_y) {
                getout = true;
                ++step;
                path[step] = '\0';
                break;
            }

            /*
            // if been here, can't get out
            if (reached[y][x]) {
                break;
            }
            reached[y][x] = true;
            */
        }

        // output result
        cout << "Case #" << coden << ": ";
        if (getout) {
            cout << step << endl;
            cout << path << endl;
        } else  {
            cout << "Edison ran out of energy." << endl;
        }

    }
    return 0;
}

