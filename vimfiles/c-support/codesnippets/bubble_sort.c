int bubbleSort ( int * arr,int len );
/* ---- please include swap first !! ---- */
int bubbleSort ( int * arr,int len )
{
    int i,j;
    for(i=0;i<len-1;i++)
    {
        for(j=0;j<len-1-i;j++)
        {
            if(*(arr+j)>*(arr+j+1))
            {
                swap((arr+j),(arr+j+1));
            }
        }
    }
    return 0;
}		/* -----  end of function bubbleSort  ----- */
