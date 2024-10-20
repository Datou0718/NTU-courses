#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

/* NTU OS 2022 */
/* Page fault handler */
int handle_pgfault()
{
  /* Find the address that caused the fault */
  /* uint64 va = r_stval();*/
  /* TODO */
  uint64 va = r_stval();
  va = PGROUNDDOWN(va);
  char *mem = kalloc();
  memset(mem, 0, PGSIZE);
  pte_t *page = walk(myproc()->pagetable, va, 0);
  if (*page & PTE_S)
  {
    *page |= PTE_V;
    *page &= ~PTE_S;
    begin_op();
    uint64 blk_no = PTE2BLOCKNO(*page);
    read_page_from_disk(ROOTDEV, mem, blk_no);
    *page = PA2PTE(mem) | PTE_FLAGS(*page);
    bfree_page(ROOTDEV, blk_no);
    end_op();
  }
  else
  {
    int flag = PTE_U | PTE_R | PTE_W | PTE_X;
    mappages(myproc()->pagetable, va, PGSIZE, (uint64)mem, flag);
  }
  return 0;
}
