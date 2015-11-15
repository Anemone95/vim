#include <cstdarg>

type sum ( int num,... )
{
    va_list pArg;

    va_start(pArg,num);
    for ( ; num>0;num-- )
    {
        va_arg(pArg,type);
    }

    return answer;
}		/* -----  end of function sum  ----- */
