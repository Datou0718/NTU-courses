#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread *current_thread = NULL;
static int id = 1;
static jmp_buf env_st; // used in start_threading
// static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg)
{
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x100);
    new_stack_p = new_stack + 0x100 * 8 - 0x2 * 8;
    t->fp = f;
    t->arg = arg;
    t->ID = id;
    t->buf_set = 0;
    t->stack = (void *)new_stack;
    t->stack_p = (void *)new_stack_p;
    id++;

    // part 2
    t->sig_handler[0] = NULL_FUNC;
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;
    t->handler_buf_set = 0;
    unsigned long handler_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x100);
    unsigned long handler_stack_p = handler_stack + 0x100 * 8 - 0x2 * 8;
    t->handler_stack = (void *)handler_stack;
    t->handler_stack_p = (void *)handler_stack_p;
    return t;
}
void thread_add_runqueue(struct thread *t)
{
    if (current_thread == NULL)
    {
        // TODO
        t->previous = t;
        t->next = t;
        current_thread = t;
    }
    else
    {
        // TODO
        t->sig_handler[0] = current_thread->sig_handler[0];
        t->sig_handler[1] = current_thread->sig_handler[1];
        t->previous = current_thread->previous;
        t->next = current_thread;
        current_thread->previous->next = t;
        current_thread->previous = t;
    }
    return;
}
void thread_yield(void)
{
    // TODO
    if (current_thread->signo == -1)
    {
        if (setjmp(current_thread->env) != 0)
        {
            return;
        }
    }
    else
    {
        if (setjmp(current_thread->handler_env) != 0)
        {
            return;
        }
    }
    schedule();
    dispatch();
    return;
}
void dispatch(void)
{
    // TODO
    if (current_thread->signo != -1)
    {
        if (current_thread->sig_handler[current_thread->signo] == NULL_FUNC)
            thread_exit();
        if (current_thread->handler_buf_set == 0)
        {
            if (setjmp(current_thread->handler_env) == 0)
            {
                current_thread->handler_buf_set = 1;
                current_thread->handler_env->sp = (long unsigned int)current_thread->handler_stack_p;
                longjmp(current_thread->handler_env, 1);
            }
            current_thread->sig_handler[current_thread->signo](current_thread->signo);
            current_thread->signo = -1;
            current_thread->handler_buf_set = 0;
        }
        else
        {
            longjmp(current_thread->handler_env, 1);
        }
    }
    if (current_thread->buf_set == 0)
    {
        if (setjmp(current_thread->env) == 0)
        {
            // initialize sp
            current_thread->buf_set = 1;
            current_thread->env->sp = (long unsigned int)current_thread->stack_p;
            longjmp(current_thread->env, 1);
        }
        current_thread->fp(current_thread->arg);
    }
    else
    {
        longjmp(current_thread->env, 1);
    }
}
void schedule(void)
{
    // TODO
    current_thread = current_thread->next;
}
void thread_exit(void)
{
    if (current_thread->next != current_thread)
    {
        // TODO
        struct thread *to_exit = current_thread;
        current_thread->next->previous = current_thread->previous;
        current_thread->previous->next = current_thread->next;
        current_thread = current_thread->next;
        free(to_exit->stack);
        free(to_exit->handler_stack);
        free(to_exit);
        dispatch();
    }
    else
    {
        // TODO
        // Hint: No more thread to execute
        free(current_thread->stack);
        free(current_thread->handler_stack);
        free(current_thread);
        current_thread = NULL;
        longjmp(env_st, 1);
    }
}
void thread_start_threading(void)
{
    // TODO
    if (setjmp(env_st) == 0)
        dispatch();
}

// part 2

void thread_register_handler(int signo, void (*handler)(int))
{
    // TODO
    current_thread->sig_handler[signo] = handler;
}
void thread_kill(struct thread *t, int signo)
{
    // TODO
    t->signo = signo;
}