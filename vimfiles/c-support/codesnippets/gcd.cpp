    template <class T>
T gcd ( T a,T b )
{
    return a%b==0?b:gcd(b,a%b);
}		/* -----  end of function gcd  ----- */
