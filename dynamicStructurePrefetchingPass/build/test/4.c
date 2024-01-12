#include<stdio.h>
#include<stdlib.h>

typedef struct l
{
  int x;
  struct l * n;
} list;

int main()
{
  list * p = (list*)malloc(sizeof(list));
  while (p)
  {
    printf("%d\n",p->x);
    p = p->n->n;
  }
  return 0;
}