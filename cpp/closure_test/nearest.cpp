// Reads a pile of numbers
// Store them in a BST
// Output the pair of nearest numbers

#include <iostream>
#include <algorithm>
#include <vector>
#include <functional>

using namespace std;

struct Node {
    Node* left;
    Node* right;
    int value;
};

class BST {
public:
    Node *root;
    BST() {root = 0;}
    ~BST() {Clear();}
    void Insert (int v) {
        Node* n = new Node();
        n->left = 0;
        n->right = 0;
        n->value = v;
        Insert (n, root);
    }
    static void Insert (Node *n, Node *&root) {
        if (root == 0) {
            root = n;
            return;
        }
        Insert (n, (n->value < root->value) ? root->left : root->right);
    }
    void Clear() {
        Clear(root);
    }
    static void Clear (Node *root) {
        if (root != 0) {
           Clear (root->left);
           Clear (root->right);
           cout << "Deleting " << root->value << "." << endl;
           delete root;
        }
    }
    /*
    ForEach(std::function <void(int)>) {
    }
    */
};


int main() {
    BST tree;
    int raw_data[] = {20, 30, 50, 70, 110, 130, 170, 175, 190, 230};
    int n = sizeof(raw_data) / sizeof(int);
    random_shuffle(raw_data, raw_data + n);
    //vector<int> data (raw_data, raw_data + sizeof(raw_data) / sizeof(int));
    //for_each(raw_data, raw_data + n, [](int) {tree->Insert(v);} );
}


