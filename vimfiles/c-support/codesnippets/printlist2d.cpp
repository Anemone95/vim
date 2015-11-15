#define LEN 100
    template <class T>
int printList2d ( T (*parr)[LEN],int xlen,int ylen )
{
    int i,j;
    for(i=0;i<ylen;i++)
    {
        for(j=0;j<xlen;j++)
        {
            cout<<parr[i][j]<<" ";
        }
        cout<<endl;
    }
    return 0;
}		/* -----  end of template function printList2d  ----- */
