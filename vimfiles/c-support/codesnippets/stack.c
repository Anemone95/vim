#include <errno.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct Node * pNode;
typedef pNode Stack;

typedef struct Element
{
    int num;
}ElementType;

typedef struct Node
{
    ElementType element;
    pNode next;
}Node;


Stack stackCreate (  );
int stackIsEmpty ( Stack pSta );
int stackPush ( Stack pSta,ElementType newElement );
int stackPop ( Stack pSta,ElementType * popElement );
int stackMakeEmpty ( Stack pSta );
int printElement ( ElementType ele );


int main()
{
    return 0;
}

Stack stackCreate (  )
{
    Stack pSta;
    pSta=(Stack)malloc(sizeof(Node));
    pSta->next=NULL;
    return pSta;
}		/* -----  end of function stackCreate  ----- */
int stackIsEmpty ( Stack pSta )
{
    return pSta->next==NULL;
}		/* -----  end of function stackIsEmpty  ----- */
int stackPush ( Stack pSta,ElementType newElement )
{
    pNode pTmpCell;
    pTmpCell=(Stack)malloc(sizeof(Node));
    pTmpCell->element=newElement;
    pTmpCell->next=pSta->next;
    pSta->next=pTmpCell;
    return 0;
}		/* -----  end of function stackPush  ----- */
int stackPop ( Stack pSta,ElementType * popElement )
{
    pNode firstCell;
    if(stackIsEmpty(pSta))
    {
        return 1;
    }
    else
    {
        firstCell=pSta->next;
        pSta->next=pSta->next->next;
        *popElement=firstCell->element;
        free(firstCell);
    }
    return 0;
}		/* -----  end of function stackPop  ----- */
int stackMakeEmpty ( Stack pSta )
{
    ElementType tmpCell;
    while(!(stackIsEmpty(pSta)))
    {
        stackPop(pSta,&tmpCell);
    }
    return 0;
}		/* -----  end of function stackMakeEmpty  ----- */
int printElement ( ElementType ele )
{
    printf("%d\n",ele.num);
    return 0;
}		/* -----  end of function printElement  ----- */
