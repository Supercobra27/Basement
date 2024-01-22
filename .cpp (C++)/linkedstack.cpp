#include <iostream>

// Purpose for practice

using namespace std;

typedef struct stack *stk_ptr; //Pointer to the head of the stack

typedef struct stack{ //stack containing the head pointer
    struct node* head;
}stack;

struct node{ //nodes for stack
    int value;
    struct node* next;

}node;

stk_ptr stack_new() { 
    stk_ptr s = new stack;
    s->head = NULL;
    return s;
}

void stack_free(stk_ptr s){
    struct node* curr;
    while(curr != NULL){
        if(s->head->next == NULL){
            free(s->head);
        }else{
        curr = s->head;
        s->head = s->head->next;
        free(curr);
        }
    }
    free(s);
}

void push(stk_ptr s, int value){ //pushes an item onto the stack
    struct node *newNode = new struct node;
    newNode->value = value;
    newNode->next = s->head;
    s->head = newNode;
}

int pop(stk_ptr s){
    struct node *top = s->head;
    s->head = s->head->next;
    int value = top->value;
    free(top);

    return value;
}



int main(){
    stk_ptr s = stack_new();
    push(s,2);
    push(s,3);
    cout << pop(s) << '\n';
    push(s,4);
    cout << pop(s) << '\n';
    stack_free(s);

    return 0;
}