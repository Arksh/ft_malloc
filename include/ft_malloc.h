#ifndef MALLOC_H
# define MALLOC_H

# include <fcntl.h>
# include <unistd.h>
# include <sys/stat.h>
# include <sys/types.h>
# include <stdlib.h>
# include <stdbool.h>
# include <stddef.h>
# include <limits.h>

/*
** malloc and free lib
*/

# include <sys/mman.h>

/*
** basic libc functions
*/

# include "libft.h"

/*
** multithreading lib
*/

# include <pthread.h>

/*
** Main functions
*/

void					*malloc(size_t size);
void					free(void *ptr);
void					*realloc(void *ptr, size_t size);
void					*calloc(size_t count, size_t size);
void					*reallocf(void *ptr, size_t size);

#endif