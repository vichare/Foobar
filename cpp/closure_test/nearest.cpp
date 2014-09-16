// Reads a pile of numbers
// Store them in a BST
// Output the pair of nearest numbers

#include <iostream>
#include <algorithm>
#include <vector>
#include <functional>
#include <cassert>

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
    //void ForEach(std::function <void(int)> func, Node *root) {
    //}
    static void ForEach(Node* root, std::function <void(int)> func) {
        if (root == 0) {
            return;
        }
        ForEach(root->left, func);
        func(root->value);
        ForEach(root->right, func);
    }
};

void FindNearest(Node* root) {
    int flag = 0;
    int smallest;
    int num1;
    int num2;
    int last_v;
    BST::ForEach(root, [&] (int v) {
        if (flag == 2) {
            if (v - last_v < smallest) {
                smallest = v - last_v;
                num1 = last_v;
                num2 = v;
            }
            last_v = v;
        } else if (flag == 0) {
            num1 = v;
            flag = 1;
        } else if (flag == 1) {
            num2 = v;
            smallest = num2 - num1;
            last_v = v;
            flag = 2;
        }
    });
    assert(flag == 2);
    cout << "The nearest 2 numbers are :" << num1 << " and " << num2 << "." << endl;
}


int main() {
    BST tree;
    int raw_data[] = {20, 30, 50, 70, 110, 130, 170, 175, 190, 230};
    int n = sizeof(raw_data) / sizeof(int);
    random_shuffle(raw_data, raw_data + n);
    auto display = [](int v) {cout << v << ' ';};

    for_each(raw_data, raw_data + n, display);
    cout << endl;

    for_each(raw_data, raw_data + n, [&tree](int v) {tree.Insert(v);} );

    BST::ForEach(tree.root, display);
    cout << endl;

    // Find nearest
    FindNearest(tree.root); // The objective function in the interview
}


