/* For copyright information, see olden_v1.0/COPYRIGHT */

/* =============== NODE STRUCTURE =================== */

#include <stdlib.h>

struct node { 
  int value;
  struct node *left;
  struct node *right;
};

typedef struct node HANDLE;

typedef struct future_cell_int{
  HANDLE *value;
} future_cell_int;

extern void *malloc(size_t);

#define NIL ((HANDLE *) 0)
