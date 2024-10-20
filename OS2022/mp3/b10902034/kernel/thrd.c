#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

// for mp3
uint64
sys_thrdstop(void)
{
  int delay;
  uint64 context_id_ptr;
  uint64 handler, handler_arg;
  if (argint(0, &delay) < 0)
    return -1;
  if (argaddr(1, &context_id_ptr) < 0)
    return -1;
  if (argaddr(2, &handler) < 0)
    return -1;
  if (argaddr(3, &handler_arg) < 0)
    return -1;

  struct proc *proc = myproc();

  // TODO: mp3
  proc->timer = 0;
  proc->delay = delay;
  proc->handler = handler;
  proc->handler_arg = handler_arg;
  copyin(proc->pagetable, (char *)&proc->context_id, context_id_ptr, sizeof(int));
  if (proc->context_id == -1)
  {
    for (int i = 0; i < MAX_THRD_NUM; i++)
    {
      if (proc->assigned[i] == 0)
      {
        proc->assigned[i] = 1;
        proc->context_id = i;
        copyout(proc->pagetable, context_id_ptr, (char *)&proc->context_id, sizeof(int));
        break;
      }
    }
    if (proc->context_id == -1)
      return -1;
  }
  else if (proc->context_id < 0 || proc->context_id >= MAX_THRD_NUM)
    return -1;
  else if (proc->assigned[proc->context_id] == 0)
    return -1;
  return 0;
}

// for mp3
uint64
sys_cancelthrdstop(void)
{
  int context_id, is_exit;
  if (argint(0, &context_id) < 0)
    return -1;
  if (argint(1, &is_exit) < 0)
    return -1;

  if (context_id < 0 || context_id >= MAX_THRD_NUM)
  {
    return -1;
  }

  struct proc *proc = myproc();

  // TODO: mp3
  if (is_exit == 0)
  {
    proc->assigned[context_id] = 1;
    memmove(&proc->context_storage[context_id], proc->trapframe, sizeof(struct trapframe));
  }
  else
  {
    proc->assigned[context_id] = 0;
    memset(&proc->context_storage[context_id], 0, sizeof(struct trapframe));
  }
  proc->delay = -1;
  return proc->timer;
}

// for mp3
uint64
sys_thrdresume(void)
{
  int context_id;
  if (argint(0, &context_id) < 0)
    return -1;

  struct proc *proc = myproc();

  // TODO: mp3
  if (context_id < 0 || context_id >= MAX_THRD_NUM || proc->assigned[context_id] == 0)
    return -1;
  memmove(proc->trapframe, &proc->context_storage[context_id], sizeof(struct trapframe));
  proc->context_id = context_id;
  return 0;
}
