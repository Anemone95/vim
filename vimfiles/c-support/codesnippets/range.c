int range ( int * arr,int len,int step );
int range ( int * arr,int len,int step )
{
    int i=0;
    for(i=0;i<len;i++)
    {
        *(arr+i)=i*step;
    }
    return 0;
}		/* -----  end of function range----- */
