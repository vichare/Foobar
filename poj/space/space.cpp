#include <iostream>
#include <vector>

using namespace std;

//单源最短路径,bellman_ford算法,邻接阵形式,复杂度O(n^3)
//求出源s到所有点的最短路经,传入图的大小n和邻接阵mat
//返回到各点最短距离min[]和路径pre[],pre[i]记录s到i路径上i的父结点,pre[s]=-1
//可更改路权类型,路权可为负,若图包含负环则求解失败,返回0
//优化:先删去负边使用dijkstra求出上界,加速迭代过程
const int MAX_COLOR = 3000;
const int MAXN = MAX_COLOR;
#define inf 1000000000
typedef int elem_t;

int bellman_ford(int n,elem_t mat[][MAX_COLOR],int s,elem_t* minl,int* pre){
	int v[MAXN],i,j,k,tag;
	for (i=0;i<n;i++)
		minl[i]=inf,v[i]=0,pre[i]=-1;
	for (minl[s]=0,j=0;j<n;j++){
		for (k=-1,i=0;i<n;i++)
			if (!v[i]&&(k==-1||minl[i]<minl[k]))
				k=i;
		for (v[k]=1,i=0;i<n;i++)
			if (!v[i]&&mat[k][i]>=0&&minl[k]+mat[k][i]<minl[i])
				minl[i]=minl[k]+mat[pre[i]=k][i];
	}
	for (tag=1,j=0;tag&&j<=n;j++)
		for (tag=i=0;i<n;i++)
			for (k=0;k<n;k++)
				if (minl[k]+mat[k][i]<minl[i])
					minl[i]=minl[k]+mat[pre[i]=k][i],tag=1;
	return j<=n;
}

//string color[80010];
int color_num; // <= 36*36
int room_color[80010];
int room_num;
int color_id[37][37];
int mat[MAX_COLOR][MAX_COLOR];
int pre[MAX_COLOR];
int minl[MAX_COLOR];

int t_num;
int t_from[3001];
int t_to[3001];
int t_time[3001];

int color2int(char c) {
    if (c >= '0' && c <= '9') {
        return (c - '0' + 1); // 1-10
    } else if (c >= 'a' && c <= 'z') {
        return (c - 'a' + 11); // 11-36
    }
    return 0;
}

int main()
{
    int coden, t;
    cin >> t;
    // define vars

    for (coden = 1; coden <= t; coden++) {
        // init color_id
        for (int i = 0; i < 37; i++)
        for (int j = 0; j < 37; j++) {
            color_id[i][j] = -1;
        }

        cin >> room_num;
        color_num = 0;
        for (int i = 0; i < room_num; i++) {
            string c;
            cin >> c;
            // chack for duplicate
            int c1 = color2int(c[0]);
            int c2 = color2int(c[1]);
            if (color_id[c1][c2] < 0) {
                color_id[c1][c2] = color_num;
                ++color_num;
            }
            room_color[i] = color_id[c1][c2];
        }
        for (int i = 0; i < room_num; i++) {
            cout << "room_color[" << i << "] = " << room_color[i] << endl;
        }

        for (int i = 0; i < color_num; i++)
        for (int j = 0; j < color_num; j++) {
            mat[i][j] = -1;
        }

        cin >> t_num;
        for (int i = 0; i < t_num; i++) {
            int from, to, time;
            cin >> from >> to >> time;
            from = room_color[from-1];
            to = room_color[to-1];
            t_from[i] = from;
            t_to[i] = to;
            t_time[i] = to;
            mat[from][to] = time;
            cout << from << " " << to << " = " << time << endl;
        }
        for (int i = 0; i < color_num; i++) {
            mat[i][i] = 0;
        }

        int s_num;
        cin >> s_num;
        // output result
        cout << "Case #" << coden << ":" << endl;
        for (int i = 0; i < s_num; i++) {
            int from, to;
            cin >> from >> to;
            from = room_color[from-1];
            to = room_color[to-1];
            cout << from << " " << to << endl;
            //int bellman_ford(int n,elem_t mat[][MAXN],int s,elem_t* min,int* pre)
            int result = bellman_ford(color_num, mat,from,minl,pre);
            if (!result) {
                cout << -1 << endl;
            } else {
                cout << minl[to] << endl;
            }
        }


    }
    return 0;
}

