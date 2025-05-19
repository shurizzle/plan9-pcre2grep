#ifndef _ENDIAN_H
#define _ENDIAN_H 1

#define	__LITTLE_ENDIAN	1234
#define	__BIG_ENDIAN	  4321
#define	__PDP_ENDIAN	  3412


#if defined(__68000__) || defined(__68020__) || defined(__mips__) || \
		defined(__power__) || defined(__power64__) || \
		defined(__sparc__) || defined(__sparc64__)
# define __BYTE_ORDER __BIG_ENDIAN
#else
# define __BYTE_ORDER __LITTLE_ENDIAN
#endif

#define	LITTLE_ENDIAN __LITTLE_ENDIAN
#define	BIG_ENDIAN    __BIG_ENDIAN
#define	PDP_ENDIAN    __PDP_ENDIAN
#define BYTE_ORDER    __BYTE_ORDER

#endif
