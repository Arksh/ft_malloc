#include <cstddef>
#include <cstdlib>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define BLK_FREE (1 << 0)

typedef struct s_block
{
	struct s_block *prev;
	struct s_block *next;
	size_t size;
	size_t flags;

} t_block;

typedef struct s_zone
{
	struct s_zone *prev;
	struct s_zone *next;
	struct s_block *alloc;

} t_zone;

static void merge_free (t_block *b)
{
	if (!b->next) 
		return ;

	t_block *gone = b->next;
	if (gone->flags & BLK_FREE)
	{
		b->size += sizeof(*gone) + gone->size;
		b->next = gone->next;
		if (b->next)
			b->next->prev = b;
	}
}

void free(void *ptr)
{
	if (!ptr)
		return;

	t_block *b = (t_block *)ptr - 1;
	b->flags |= BLK_FREE;
	merge_free(b);
	if (b->prev && b->prev->flags & BLK_FREE)
		merge_free(b->prev);
	return ;
}

int main ()
{
	int n;

	n = 14;

	printf("Resultado de n: %d", (n + 15) & ~15);
	return 0;
}