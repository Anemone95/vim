#include <errno.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
typedef struct Node * pNode;
typedef struct Queue * pQueue;
typedef struct ElementType
{
    int num;
}ElementType;
typedef struct Node
{
    ElementType element;
    pNode next;
}Node;

typedef struct Queue
{
    pNode front;
    pNode rear;
}Queue;

int queueCreate ( pQueue pQue );
int queueIsEmpty ( pQueue pQue );
int queueEnter ( pQueue pQue,ElementType newElement );
int queueDelete ( pQueue pQue,ElementType * delElement );
int queueGetLen ( pQueue pQue );
int queueClear ( pQueue pQue );
pNode getHead ( pQueue pQue );
int queueWalk ( pQueue pQue,int (*walkWay)(ElementType ele) );
int printElement ( ElementType ele );

int main()
{
    return 0;
}

int queueCreate ( pQueue pQue )
{
    pQue->front=pQue->rear=(pNode)malloc(sizeof(Node));
    pQue->rear->next=NULL;
    return 0;
}		/* -----  end of function queueCreate  ----- */
int queueClear ( pQueue pQue )
{
    ElementType tmpCell;
    while(pQue->front!=pQue->rear)
    {
        queueDelete(pQue,&tmpCell);
    }
    return 0;
}		/* -----  end of function queueClear  ----- */
int queueIsEmpty ( pQueue pQue )
{
    return pQue->front==pQue->rear;
}		/* -----  end of function queueIsEmpty  ----- */
int queueGetLen ( pQueue pQue )
{
    int n=0;
    pNode start=pQue->front->next;
    while(start!=NULL)
    {
        n++;
        start=start->next;
    }
    return n;
}		/* -----  end of function queueLength  ----- */
pNode getHead ( pQueue pQue )
{
    return pQue->front;
}		/* -----  end of function getHead  ----- */
int queueEnter ( pQueue pQue,ElementType newElement )
{
    pNode pTmpCell;
    pTmpCell=(pNode)malloc(sizeof(Node));
    pTmpCell->element=newElement;
    pTmpCell->next=NULL;
    pQue->rear->next=pTmpCell;
    pQue->rear=pTmpCell;
    return 0;
}		/* -----  end of function queueAdd  ----- */
int queueDelete ( pQueue pQue,ElementType * delElement )
{
    if(queueIsEmpty(pQue))
    {
        return 1;
    }
    pNode pTmpCell;
    pTmpCell=pQue->front->next;
    pQue->front->next=pTmpCell->next;
    if(pQue->rear==pTmpCell)
    {
        pQue->rear=pQue->front;
    }
    *delElement=pTmpCell->element;
    free(pTmpCell);
    return 0;
}		/* -----  end of function queueDelete  ----- */
int queueWalk ( pQueue pQue,int (*walkWay)(ElementType ele) )
{
    if(queueIsEmpty(pQue))
    {
        return 1;
    }
    pNode start=pQue->front->next;
    while(start!=NULL)
    {
        (*walkWay)(start->element);
        start=start->next;
    }
    return 0;
}		/* -----  end of function queueWalk  ----- */
int printElement ( ElementType ele )
{
    printf("%d\n",ele.num);
    return 0;
}		/* -----  end of function printElement  ----- */
