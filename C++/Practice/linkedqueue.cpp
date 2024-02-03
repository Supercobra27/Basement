#include <iostream>

using namespace std;

typedef struct node{
    int value;
    node* next;
}node;

typedef struct queue{
    node* head;
    node* tail;
}queue;

typedef queue *q_ptr;

q_ptr queue_new(){
    q_ptr q = new queue;
    q->head = q->tail = NULL;
    return q;

}

void queue_free(q_ptr q){
    while(q->head != NULL){
        node* temp = q->head;
        q->head->next = q->head;
        delete temp;
    }
    delete q;
}

void enqueue(q_ptr q, int value){
    node* newNode = new node;
    newNode->next = NULL;
    newNode->value = value;

    if(q->head == NULL){
        q->head = q->tail = newNode;
    }else{
        q->tail->next = newNode;
        q->tail = newNode;
    }

}

int dequeue(q_ptr q){
    if(q->head == NULL){ cerr << "Error, cannot dequeue" << endl; exit(1);}

    int value = q->head->value;
    node* temp = q->head;
    q->head = q->head->next;

    delete temp;

    return value;
}



int main(){
    q_ptr q = queue_new();

    int num1, num2;
    cin >> num1;
    cin >> num2;
    enqueue(q,num1);
    enqueue(q,num2);

    cout << dequeue(q) << endl;
    cout << dequeue(q) << endl;



    queue_free(q);

    return 0;
}