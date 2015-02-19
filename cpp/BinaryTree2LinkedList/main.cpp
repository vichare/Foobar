#include <iostream>
#include <vector>

using namespace std;

typedef struct node_base {
  struct node_base *left, *right;
  int value;
} node_base;
//typedef node_base Node;

template<typename F>
void inorder_traversal_recursive(node_base *root, F visit){
    if (root == 0) return;
    inorder_traversal_recursive(root->left, visit);
    visit(root);
    inorder_traversal_recursive(root->right, visit);
}

template<typename F>
void inorder_traversal_nonrecursive(node_base *root, F visit){
    node_base *&cur = root;
    vector<node_base*> stack;
    while(1) {
        while(cur != 0) {
            stack.push_back(cur);
            cur = cur->left;
        }
        if (stack.empty()) {
            break; // Finished
        }
        cur = stack.back();
        stack.pop_back();
        node_base *temp = cur;
        cur = cur->right;
        visit(temp); // assume that visit may change the node
    }
}

node_base *BinaryTree2LinkedList(node_base *root) {
    node_base guard = {};
    node_base *tail = &guard;
//
//    inorder_traversal_recursive(root, [&tail] (node_base *n) {
//        cout << "Visit " << n->value << endl;
//    });

    inorder_traversal_nonrecursive(root, [&tail] (node_base *n) {
        tail->right = n;
        n->left = tail;
        tail = n;
    });
    tail->right = 0;
    if (guard.right != 0) {
        guard.right->left = 0;
    }
    return guard.right;
}

void display(const node_base &n) {
    cout << "Node #" << n.value << ": <-#" 
         << (n.left ? char(n.left->value + '0') : '?') 
         << " ->#" << char(n.right ? (n.right->value + '0') : '?')
         << endl;
}

int main() {
    node_base n1, n2, n3, n4, n5;
    n1.value = 1;
    n1.left = 0;
    n1.right = 0;
    n2.value = 2;
    n2.left = &n1;
    n2.right = &n5;
    n3.value = 3;
    n3.left = 0;
    n3.right = 0;
    n4.value = 4;
    n4.left = &n3;
    n4.right = 0;
    n5.value = 5;
    n5.left = &n4;
    n5.right = 0;
    display(n1);
    display(n2);
    display(n3);
    display(n4);
    display(n5);

    BinaryTree2LinkedList(&n2);

    display(n1);
    display(n2);
    display(n3);
    display(n4);
    display(n5);

    return 0;
}

