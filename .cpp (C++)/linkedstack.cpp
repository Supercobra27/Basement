#include <iostream>

// Purpose for practice

using namespace std;

typedef struct stack *stk_ptr;

typedef struct stack{
    struct node* head;
}stack;

struct node{
    int value;
    struct node* next;

}node;

void push(stk_ptr s, int value){ //pushes an item onto the stack
    struct node *newNode = new struct node;
    newNode->value = value;
    newNode->next = s->head;
    s->head = newNode;
}

int pop(stk_ptr s){
    return s->head->value;
}



int main(){

    return 0;
}