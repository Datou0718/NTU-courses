#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list)
    {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
        {
            thread_with_smallest_id = th;
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL)
    {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    struct thread *to_be_run = NULL;
    struct thread *to_be_ret = NULL;
    struct thread *i = NULL;
    list_for_each_entry(i, args.run_queue, thread_list)
    {
        if (i->current_deadline <= args.current_time)
        {
            if (to_be_ret == NULL || i->ID < to_be_ret->ID)
                to_be_ret = i;
        }
        if (to_be_run == NULL || i->current_deadline < to_be_run->current_deadline || (i->current_deadline == to_be_run->current_deadline && i->ID < to_be_run->ID))
        {
            to_be_run = i;
        }
    }
    struct threads_sched_result ret;
    if (to_be_ret != NULL)
    {
        ret.scheduled_thread_list_member = &to_be_ret->thread_list;
        ret.allocated_time = 0;
    }
    else if (to_be_run == NULL)
    {
        int min = 10001;
        struct release_queue_entry *j = NULL;
        list_for_each_entry(j, args.release_queue, thread_list)
        {
            if (j->release_time < min)
                min = j->release_time;
        }
        ret.scheduled_thread_list_member = args.run_queue;
        ret.allocated_time = min - args.current_time;
    }
    else
    {
        ret.scheduled_thread_list_member = &to_be_run->thread_list;
        int nearest_rel = 10001;
        struct release_queue_entry *j = NULL;
        struct thread *nearest_rel_thrd = NULL;
        list_for_each_entry(j, args.release_queue, thread_list)
        {
            if (((j->release_time + j->thrd->period < to_be_run->current_deadline) || (j->release_time + j->thrd->period == to_be_run->current_deadline && j->thrd->ID < to_be_run->ID)) && (j->release_time < ((args.current_time + to_be_run->remaining_time < to_be_run->current_deadline) ? args.current_time + to_be_run->remaining_time : to_be_run->current_deadline)))
            {
                if (nearest_rel_thrd == NULL || nearest_rel > j->release_time)
                {
                    nearest_rel_thrd = j->thrd;
                    nearest_rel = j->release_time;
                }
            }
        }
        if (nearest_rel_thrd != NULL) // higher priority will interrupt
        {
            ret.allocated_time = nearest_rel - args.current_time;
        }
        else
        {
            if (to_be_run->current_deadline - args.current_time < to_be_run->remaining_time)
            {
                ret.allocated_time = to_be_run->current_deadline - args.current_time;
            }
            else
            {
                ret.allocated_time = to_be_run->remaining_time;
            }
        }
    }
    return ret;
}

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    struct thread *to_be_run = NULL;
    struct thread *to_be_ret = NULL;
    struct thread *i = NULL;
    list_for_each_entry(i, args.run_queue, thread_list)
    {
        if (i->current_deadline <= args.current_time)
        {
            if (to_be_ret == NULL || i->ID < to_be_ret->ID)
                to_be_ret = i;
        }
        if (to_be_run == NULL || i->period < to_be_run->period || (i->period == to_be_run->period && i->ID < to_be_run->ID))
        {
            to_be_run = i;
        }
    }
    struct threads_sched_result ret;
    if (to_be_ret != NULL)
    {
        ret.scheduled_thread_list_member = &to_be_ret->thread_list;
        ret.allocated_time = 0;
    }
    else if (to_be_run == NULL)
    {
        int min = 10001;
        struct release_queue_entry *j = NULL;
        list_for_each_entry(j, args.release_queue, thread_list)
        {
            if (j->release_time < min)
                min = j->release_time;
        }
        ret.scheduled_thread_list_member = args.run_queue;
        ret.allocated_time = min - args.current_time;
    }
    else
    {
        ret.scheduled_thread_list_member = &to_be_run->thread_list;
        int nearest_rel = 10001;
        struct release_queue_entry *j = NULL;
        struct thread *nearest_rel_thrd = NULL;
        list_for_each_entry(j, args.release_queue, thread_list)
        {
            if ((j->thrd->period < to_be_run->period || (j->thrd->period == to_be_run->period && j->thrd->ID < to_be_run->ID)) && (j->release_time < ((args.current_time + to_be_run->remaining_time < to_be_run->current_deadline) ? args.current_time + to_be_run->remaining_time : to_be_run->current_deadline)))
            {
                if (nearest_rel_thrd == NULL || nearest_rel > j->release_time)
                {
                    nearest_rel_thrd = j->thrd;
                    nearest_rel = j->release_time;
                }
            }
        }
        if (nearest_rel_thrd != NULL) // higher priority will interrupt
        {
            ret.allocated_time = nearest_rel - args.current_time;
        }
        else
        {
            if (to_be_run->current_deadline - args.current_time < to_be_run->remaining_time)
            {
                ret.allocated_time = to_be_run->current_deadline - args.current_time;
            }
            else
            {
                ret.allocated_time = to_be_run->remaining_time;
            }
        }
    }
    return ret;
}