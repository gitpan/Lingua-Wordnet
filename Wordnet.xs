#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "license.h"
#include "wn.h"
#include "wnglobal.h"
#include "wnrtl.h"
#include "setutil.h"
#include "wnconsts.h"
#include "wnhelp.h"
#include "wntypes.h"

static int
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static int
constant(char *name, int arg)
{
    errno = 0;
    switch (*name) {
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


MODULE = Lingua::Wordnet		PACKAGE = Lingua::Wordnet		

double
constant(name,arg)
	char *		name
	int		arg

unsigned char *
do_findtheinfo(searchstr, pos, ptr_type, sense_num)
	char *		searchstr
	int		pos
	int 		ptr_type	
	int		sense_num

    INIT:
	char *morphword, *outbuf;
	wninit();

    CODE:
	outbuf = findtheinfo(searchstr, pos, ptr_type, sense_num);
	/*printf("HI: \n%s: %s\n", searchstr, outbuf);*/
	RETVAL = outbuf;

    OUTPUT:
	RETVAL


