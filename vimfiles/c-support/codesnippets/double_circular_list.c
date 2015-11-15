#include <errno.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
typedef struct Node * pNode;
typedef pNode List;
typedef pNode ListPos;
typedef struct ElementType
{
    int no;
}ElementType;
typedef struct Node
{
    pNode prior;
    ElementType element;
    pNode next;
}Node;


pNode listCreate ( ElementType newelement );
int printElement ( ElementType element );
ListPos listInsert ( ListPos pos,ElementType newelement );
int elementcmp ( ElementType elementOne,ElementType elementTwo );
int listGetLen ( List list );
int listDelete ( List list,ElementType delElement );
ListPos listFind ( List list,ElementType findElement );
int listWalkOrder ( List list,int (*walkWay)(ElementType ele) );
int listWalkReverse ( List list,int (*walkWay)(ElementType ele) );
List listSort ( List list );

int printElement ( ElementType element )
{
    printf("%d\n",element.no);
    return 0;
}		/* -----  end of function printElement  ----- */

int elementcmp ( ElementType elementOne,ElementType elementTwo )
{
    if(elementOne.no==elementTwo.no)
    {
        return 0;
    }
    else if(elementOne.no>elementTwo.no)
    {
        return 1;
    }
    else
    {
        return -1;
    }
}		/* -----  end of function elementcmp  ----- */

int main()
{
    return 0;
}

pNode listCreate ( ElementType newelement )
{
    pNode list;
    list=(pNode)malloc(sizeof(Node));
    list->element=newelement;
    list->prior=list;
    list->next=list;
    return list;
}		/* -----  end of function listCreateList  ----- */

ListPos listInsert ( ListPos pos,ElementType newelement )
{
    pNode pTmpCell;
    pNode nextPos=pos->next;
    pTmpCell=(pNode)malloc(sizeof(Node));
    pTmpCell->element=newelement;
    pTmpCell->next=pos->next;
    pos->next=pTmpCell;
    pTmpCell->prior=pos;
    //printElement(nextPos->element);
    nextPos->prior=pTmpCell;
    pTmpCell->prior=pos;
    return pTmpCell;
}		/* -----  end of function listInsert  ----- */

int listDelete ( List list,ElementType delElement )
{
    ListPos prePos,delPos;
    delPos=listFind(list,delElement);
    prePos=delPos->prior;
    prePos->next=delPos->next;
    delPos->next->prior=prePos;
    free(delPos);
    return 0;
}		/* -----  end of function listDelete  ----- */

ListPos listFind ( List list,ElementType findElement )
{
    ListPos pos=list;
    ListPos end=list;
    do
    {
        if(!elementcmp(pos->element,findElement))
        {
            return pos;
            break;
        }
        else
        {
            pos=pos->next;
        }
    }while(pos!=end);
    return NULL;
}		/* -----  end of function listFind  ----- */
int listGetLen ( List list )
{
    int count=1;
    ListPos pos=list->next;
    while(pos!=list)
    {
        count++;
        pos=pos->next;
    }
    return count;
}		/* -----  end of function listGetLen  ----- */
int listWalkOrder ( List list,int (*walkWay)(ElementType ele) )
{
    ListPos pos=list;
    ListPos end=list;
    do
    {
        (*walkWay)(pos->element);
        pos=pos->next;
    }while(pos!=end);
    return 0;
}		/* -----  end of function listWalkOrder  ----- */
int listWalkReverse ( List list,int (*walkWay)(ElementType ele) )
{
    ListPos pos=list;
    ListPos end=list;
    do
    {
        pos=pos->prior;
        (*walkWay)(pos->element);
    }while(pos!=end);
    return 0;
}		/* -----  end of function listWalkReverse  ----- */
int listSwap ( pNode i,pNode j )
{
    ElementType temp;
    temp=i->element;
    i->element=j->element;
    j->element=temp;
    return 0;
}		/* -----  end of function listSwap  ----- */
List listSort ( List list )
{
    pNode p=list;
    pNode q=list;
    pNode end=list;
    do
    {
        q=p->next;
        do
        {
            if(elementcmp(p->element,q->element)<0)
            {
                listSwap(p,q);
            }
            q=q->next;
        }
        while(q!=end);
        p=p->next;
    }
    while(p!=end);
    return list;
}		/* -----  end of function listBubbleSort  ----- */
