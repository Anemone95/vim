/* If you want to use listFind ,please check the element.std!! */
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
struct Node
{
    ElementType element;
    ListPos next;
}Node;

List listCreatList ();
int listIsEmpty ( List list );
ListPos listInsert ( ListPos list,ElementType newElement );
int listDel ( List list,ElementType std );
ListPos listFindPrevious ( List list,ElementType std );
int elementcmp ( ElementType elementOne,ElementType elementTwo );
int printElement ( ElementType ele );
ListPos listFind ( List list,ElementType no );
int listWalk ( List list,int (*walkWay)(ElementType ele) );
int listSort ( List list );
int listGetLen ( List list );
int listSwap ( pNode i,pNode j );
int listInsertInRange ( List list,ElementType newElement );

int printElement ( ElementType ele )
{
    printf("%5d\n",ele.no);
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

List listCreatList ()
{
    List firstNode,endNode;
    firstNode=(List)malloc(sizeof(Node));
    endNode=(List)malloc(sizeof(Node));
    firstNode->next=endNode;
    endNode->next=NULL;
    return firstNode;
}		/* -----  end of function creatList  ----- */

int listIsEmpty ( List list )
{
    if(list->next->next==NULL)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}    /* -----  end of function nodeIsEmpty  ----- */
ListPos listInsert ( ListPos list,ElementType newElement )
{
    pNode pTmpCell;
    pTmpCell=(List)malloc(sizeof(Node));
    pTmpCell->element=newElement;
    pTmpCell->next=list->next;
    list->next=pTmpCell;
    return pTmpCell;
}		/* -----  end of function listInsert  ----- */
int listDel ( List list,ElementType std )
{
    ListPos prePos,delPos;
    prePos=listFindPrevious(list,std);
    if(prePos==NULL)
    {
        return 1;
    }
    delPos=prePos->next;
    prePos->next=delPos->next;
    free(delPos);
    return 0;
}		/* -----  end of function delete  ----- */
ListPos listFindPrevious ( List list,ElementType std )
{
    ListPos position=list;
    while(position->next!=NULL)
    {
        if(!elementcmp(position->next->element,std))
        {
            return position;
            break;
        }
        else
        {
            position=position->next;
        }
    }
    return NULL;
}		/* -----  end of function listFindPrevious  ----- */
ListPos listFind ( List list,ElementType no )
{
    return listFindPrevious(list,no)->next;
}		/* -----  end of function listFind  ----- */
int listWalk ( List list,int (*walkWay)(ElementType ele) )
{
    ListPos pos=list;
    if(listIsEmpty(list))
    {
        printf("Empty!\n");
    }
    while(pos->next->next!=NULL)
    {
        (*walkWay)(pos->next->element);
        pos=pos->next;
    }
    return 0;
}		/* -----  end of function listWalk  ----- */
int listGetLen ( List list )
{
    int n=0;
    pNode pos=list;
    while(pos->next!=NULL)
    {
        n++;
        pos=pos->next;
    }
    return n-1;
}		/* -----  end of function listGetLen  ----- */
int listSwap ( pNode i,pNode j )
{
    ElementType temp;
    temp=i->element;
    i->element=j->element;
    j->element=temp;
    return 0;
}		/* -----  end of function listSwap  ----- */
int listSort ( List list )
{
    pNode p,q;
    for(p=list->next;p->next!=NULL;p=p->next)
    {
        for(q=p->next;q->next!=NULL;q=q->next)
        {
            if(elementcmp(p->element,q->element)>0)
            {
                listSwap(p,q);
            }
        }
    }
    return 0;
}		/* -----  end of function listBubbleSort  ----- */
int listInsertInRange ( List list,ElementType newElement )
{
    ListPos position=list;
    while(position->next!=NULL)
    {
        if(elementcmp(position->next->element,newElement)>0)
        {
            break;
        }
        else
        {
            position=position->next;
        }
    }
    listInsert(position,newElement);   
    return 0;
}		/* -----  end of function listInsertInRange  ----- */
