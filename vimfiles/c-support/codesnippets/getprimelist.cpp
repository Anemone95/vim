    template <class T>
T *getPrimeList ( T len )
{
    T *pArr=new T[len+1];
    T i,j;
    for( i=1;i<=len;i++ )
    {
        pArr[i]=i;
    }
    for ( i=2;i<=len/2 ;i++ )
    {
        for ( j=i+1;j<=len ;j++ )
        {
            if ( pArr[i]!=0 )
            {
                if ( pArr[j]%pArr[i]==0 )
                {
                    pArr[j]=0;
                }
            }
        }
    }
    return pArr;
}		/* -----  end of template function getPrimeList  ----- */
