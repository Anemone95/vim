typedef int (*fCmp)(const void *,const void *);
typedef int ElementType;

ElementType elementCmp ( const ElementType *eleOne,const ElementType *eleTwo );

    int *result;
    int key;

    key=80;

    qsort(array,len,sizeof(ElementType),(fCmp)(elementCmp));

    result=(int*)bsearch(&key,array,len,sizeof(ElementType),(fCmp)(elementCmp));

ElementType elementCmp ( const ElementType *eleOne,const ElementType *eleTwo )
{
    ElementType value;
    value=*eleOne-*eleTwo;
    if(value==0)
    {
        return 0;
    }
    else if(value<0)
    {
        return -1;
    }
    else
    {
        return 1;
    }
}		/* -----  end of function numcmp  ----- */
