#include <algorithm>
template <class T>int printList ( T *parr,int len );
int combine ( int *book,int m,int len );
int combine ( int *book,int m,int len )
{
    int search01 ( int *parr,int len );
    int __count=1;
    int pos;
    for(int i=1;i<=m;i++)
    {
        book[i]=1;
    }
    while(true)
    {
        printList(book,len+1);
        pos=search01(book,len);

        if(pos==0)
        {
            break;
        }
        swap(book[pos],book[pos+1]);
        sort(book+1,book+1+pos,greater<int>());
        __count++;
    }
    return __count;
}		/* -----  end of function combine  ----- */
int search01 ( int *parr,int len )
{
    int i;
    for(i=0;i<len;i++)
    {
        if(parr[i]==1&&parr[i+1]==0)
        {
            return i;
        }
    }
    return 0;
}		/* -----  end of function search01  ----- */

    template <class T>
int printList ( T *parr,int len )
{
    int i;
    cout<<"Array:"<<endl;
    for(i=0;i<len;i++)
    {
        cout<<parr[i]<<" ";
    }
    cout<<endl;
    return 0;
}		/* -----  end of template function printList  ----- */
