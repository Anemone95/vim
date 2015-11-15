bool isprime (int x1,int x2)
{
    int i=x1+x2;
    int f;
    for(f=2;f<=i/2;f++)
        if(i%f==0) return false;
    return true;
}		/* ----------  end of function isprime  ---------- *
