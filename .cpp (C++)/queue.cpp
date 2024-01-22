#include <iostream>

typedef struct node{
    int value;
    node* next;
}node;

typedef struct queue{
    node* head;
}queue;

typedef queue *q_ptr;

q_ptr queue_new(){

}

void queue_free(){

}

void enqueue(q_ptr q, int value){

}

int dequeue(q_ptr){
    
}



int main(){

    return 0;
}