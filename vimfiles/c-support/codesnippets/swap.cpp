template <class T>int swap ( T &a,T &b );
    template <class T>
int swap ( T &a,T &b )
{
    T temp;
    temp=a;
    a=b;
    b=temp;
    return 0;
}		/* -----  end of template function swap  ----- */
