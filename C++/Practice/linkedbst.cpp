#include <iostream>

using namespace std;

struct node;

typedef node* bst;

typedef struct node{
    int value;
    bst left, right;
}node;

bst bst_new(){
    return nullptr;
}

void bst_free(bst root){
    while(root != nullptr){
        bst_free(root->left);
        bst_free(root->right);
    }
    delete root;

}

void insert(bst &b, int value){
     bst newNode = new node{value, nullptr, nullptr};

    if (b == nullptr) {
        b = newNode;
        return;
    }

    bst current = b;
    while (true) {
        if (value < current->value) {
            if (current->left == nullptr) {
                current->left = newNode;
                return;
            }
            current = current->left;
        } else if (value > current->value) {
            if (current->right == nullptr) {
                current->right = newNode;
                return;
            }
            current = current->right;
        } else {
            // Value already exists in the BST (you can decide what to do in this case)
            delete newNode;
            return;
        }
    }
}

void search(bst b){
    if(b != nullptr){
        search(b->left);
        cout << b->value;
        search(b->right);
    }
}

int main(){

    bst b = bst_new();

    insert(b, 10);
    insert(b, 5);
    insert(b, 15);
    insert(b, 3);
    insert(b, 7);

    search(b);

    bst_free(b);

    return 0;
}