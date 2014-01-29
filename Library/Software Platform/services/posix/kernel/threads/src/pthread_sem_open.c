/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_open
|*                  pthread_sem_close
|*                  phread_sem_unlink
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <stdarg.h>

typedef struct named_sem_t
{
        sem_t               sem;    /* Should be first member in struct */
        bool                unlink;
        int                 ref;
        struct named_sem_t *next;
        char                name[];
} named_sem_t;

static pthread_mutex_t named_sem_mutex = PTHREAD_MUTEX_INITIALIZER;
static named_sem_t *named_sem_list = NULL;

static named_sem_t *named_sem_insert (const char* name)
{
        named_sem_t *new_named_sem;

        new_named_sem = malloc(sizeof(*new_named_sem) + strlen(name) + 1);

        if (new_named_sem)
        {
            /* Initialize the new node */
            new_named_sem->unlink = false;
            new_named_sem->ref = 1;
            strcpy(new_named_sem->name, name);

            /* Add new node to named sem list */
            new_named_sem->next = named_sem_list;
            named_sem_list = new_named_sem;
        }

        return new_named_sem;
}

static named_sem_t *named_sem_lookup (const char *name)
{
        named_sem_t *named_sem;

        for (named_sem = named_sem_list; named_sem; named_sem = named_sem->next)
        {
                if (name && !strcmp(named_sem->name, name))
                {
                        return named_sem;
                }
        }
        return NULL;
}

static void named_sem_remove (named_sem_t *named_sem)
{
        named_sem_t **next_addr;

        for (next_addr = &named_sem_list; *next_addr; next_addr = &((*next_addr)->next))
        {
                if (*next_addr == named_sem)
                {
                        *next_addr = (*next_addr)->next;
                        free(named_sem);
                        break;
                }
        }
}

/**
 * @brief
 *      initialize and open a named semaphore
 *
 *      The sem_open() function shall establish a connection between a named
 *      semaphore and a process. Following a call to sem_open() with semaphore
 *      name name, the process may reference the semaphore associated with name
 *      using the address returned from the call. This semaphore may be used in
 *      subsequent calls to sem_wait(), sem_timedwait(), sem_trywait(),
 *      sem_post(), and sem_close(). The semaphore remains usable by this
 *      process until the semaphore is closed by a successful call to
 *      sem_close(), _exit(), or one of the exec functions.
 *
 *      The oflag argument controls whether the semaphore is created or merely
 *      accessed by the call to sem_open(). The following flag bits may be set
 *      in oflag:
 *
 *      O_CREAT
 *           This flag is used to create a semaphore if it does not already
 *           exist. If O_CREAT is set and the semaphore already exists, then
 *           O_CREAT has no effect, except as noted under O_EXCL. Otherwise,
 *           sem_open() creates a named semaphore. The O_CREAT flag requires a
 *           third and a fourth argument: mode, which is of type mode_t, and
 *           value, which is of type unsigned. The semaphore is created with an
 *           initial value of value. Valid initial values for semaphores are
 *           less than or equal to {SEM_VALUE_MAX}.
 *
 *           The user ID of the semaphore is set to the effective user ID of
 *           the process; the group ID of the semaphore is set to a system
 *           default group ID or to the effective group ID of the process. The
 *           permission bits of the semaphore are set to the value of the mode
 *           argument except those set in the file mode creation mask of the
 *           process. When bits in mode other than the file permission bits are
 *           specified, the effect is unspecified.
 *
 *           After the semaphore named name has been created by sem_open() with
 *           the O_CREAT flag, other processes can connect to the semaphore by
 *           calling sem_open() with the same value of name.
 *
 *      O_EXCL
 *           If O_EXCL and O_CREAT are set, sem_open() fails if the semaphore
 *           name exists. The check for the existence of the semaphore and the
 *           creation of the semaphore if it does not exist are atomic with
 *           respect to other processes executing sem_open() with O_EXCL and
 *           O_CREAT set. If O_EXCL is set and O_CREAT is not set, the effect
 *           is undefined.
 *
 *      If flags other than O_CREAT and O_EXCL are specified in the oflag
 *      parameter, the effect is unspecified.
 *
 *      The name argument points to a string naming a semaphore object. It is
 *      unspecified whether the name appears in the file system and is visible
 *      to functions that take pathnames as arguments. The name argument
 *      conforms to the construction rules for a pathname. If name begins with
 *      the slash character, then processes calling sem_open() with the same
 *      value of name shall refer to the same semaphore object, as long as that
 *      name has not been removed. If name does not begin with the slash
 *      character, the effect is implementation-defined. The interpretation of
 *      slash characters other than the leading slash character in name is
 *      implementation-defined.
 *
 *      If a process makes multiple successful calls to sem_open() with the
 *      same value for name, the same semaphore address shall be returned for
 *      each such successful call, provided that there have been no calls to
 *      sem_unlink() for this semaphore, and at least one previous successful
 *      sem_open() call for this semaphore has not been matched with a
 *      sem_close() call.
 *
 *      References to copies of the semaphore produce undefined results.
 *
 * @param name
 *      semaphore name
 * @param oflag
 *      open flag ( see description )
 *
 * @return
 *      Upon successful completion, the sem_open() function shall return the
 *      address of the semaphore. Otherwise, it shall return a value of
 *      SEM_FAILED and set errno to indicate the error. The symbol SEM_FAILED
 *      is defined in the <semaphore.h> header. No successful return from
 *      sem_open() shall return the value SEM_FAILED.
 *
 *      If any of the following conditions occur, the sem_open() function shall
 *      return SEM_FAILED and set errno to the corresponding value:
 *
 *      [EACCES]
 *           The named semaphore exists and the permissions specified by oflag
 *           are denied, or the named semaphore does not exist and permission
 *           to create the named semaphore is denied.
 *      [EEXIST]
 *           O_CREAT and O_EXCL are set and the named semaphore already exists.
 *      [EINTR]
 *           The sem_open() operation was interrupted by a signal.
 *      [EINVAL]
 *           The sem_open() operation is not supported for the given name, or
 *           O_CREAT was specified in oflag and value was greater than
 *           {SEM_VALUE_MAX}.
 *      [EMFILE]
 *           Too many semaphore descriptors or file descriptors are currently
 *           in use by this process.
 *      [ENAMETOOLONG]
 *           The length of the name argument exceeds {PATH_MAX} or a pathname
 *           component is longer than {NAME_MAX}.
 *      [ENFILE]
 *           Too many semaphores are currently open in the system.
 *      [ENOENT]
 *           O_CREAT is not set and the named semaphore does not exist.
 *      [ENOSPC]
 *           There is insufficient space for the creation of the new named
 *           semaphore.
 */
sem_t *sem_open(const char *name, int oflag, ...)
{
        int result = 0;
        named_sem_t *named_sem = 0;

        if (!name || !*name)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&named_sem_mutex))
        {
                named_sem = named_sem_lookup (name);

                if (named_sem && ( (oflag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT)))
                {
                        /* O_CREAT and O_EXCL are set and the named
                         * shared memory object already exists */
                        result = EEXIST;
                }
                else if (!named_sem && (O_CREAT != (oflag & O_CREAT)) )
                {
                        /* O_CREAT is not set and the named message queue
                         * does not exist */
                        result  = ENOENT;
                }
                else if (!named_sem)
                {
                        named_sem = named_sem_insert(name);

                        if (!named_sem)
                        {
                                result = ENFILE;
                        }
                        else
                        {
                                mode_t mode;
                                unsigned int value;
                                va_list ap;

                                va_start (ap, oflag);
                                mode = va_arg (ap, mode_t);
                                value = va_arg (ap, unsigned int);
                                va_end (ap);

                                if (value > SEM_VALUE_MAX)
                                {
                                        result = EINVAL;
                                }
                                else
                                {
                                        pthread_mutex_init(&(named_sem->sem.mutex), NULL);
                                        pthread_cond_init(&(named_sem->sem.cond), NULL);
                                        named_sem->sem.value = value;
                                }
                        }
                }
                else
                {
                        if ( named_sem->unlink == true )
                        {
                                /* but cannot open anymore */
                                result = EACCES;
                        }
                        else
                        {
                                named_sem->ref++;
                        }
                }

                pthread_mutex_unlock(&named_sem_mutex);
        }
        else
        {
                result = EINVAL;
        }

        if (result)
        {
                errno = result;
                return SEM_FAILED;
        }
        return &named_sem->sem;
}


/**
 * @brief
 *      close a named semaphore
 *
 *      The sem_close() function shall indicate that the calling process is
 *      finished using the named semaphore indicated by sem. The effects of
 *      calling sem_close() for an unnamed semaphore (one created by sem_init())
 *      are undefined. The sem_close() function shall deallocate (that is, make
 *      available for reuse by a subsequent sem_open() by this process) any
 *      system resources allocated by the system for use by this process for
 *      this semaphore. The effect of subsequent use of the semaphore indicated
 *      by sem by this process is undefined. If the semaphore has not been
 *      removed with a successful call to sem_unlink(), then sem_close() has no
 *      effect on the state of the semaphore. If the sem_unlink() function has
 *      been successfully invoked for name after the most recent call to
 *      sem_open() with O_CREAT for this semaphore, then when all processes
 *      that have opened the semaphore close it, the semaphore is no longer
 *      accessible.
 *
 * @param sem
 *      pointer to the named semaphore
 *
 * @return
 *      Upon successful completion, a value of zero shall be returned.
 *      Otherwise, a value of -1 shall be returned and errno set to indicate
 *      the error.
 *
 *      [EINVAL]
 *           The sem argument is not a valid semaphore descriptor.
 */
int sem_close(sem_t *sem)
{
        named_sem_t *named_sem = (named_sem_t *) sem;

        int result = 0;

        if (!sem)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&named_sem_mutex))
        {
                if (named_sem->ref > 0)
                {
                        named_sem->ref--;
                }

                if (!named_sem->ref && named_sem->unlink)
                {
                        named_sem_remove(named_sem);
                }

                pthread_mutex_unlock(&named_sem_mutex);
        }
        else
        {
                result = EINVAL;
        }

        if (result)
        {
                errno = result;
                return -1;
        }
        return 0;
}


/**
 * @brief
 *      remove a named semaphore
 *
 *      The sem_unlink() function shall remove the semaphore named by the
 *      string name. If the semaphore named by name is currently referenced by
 *      other processes, then sem_unlink() shall have no effect on the state
 *      of the semaphore. If one or more processes have the semaphore open
 *      when sem_unlink() is called, destruction of the semaphore is postponed
 *      until all references to the semaphore have been destroyed by calls to
 *      sem_close(), _exit(), or exec. Calls to sem_open() to recreate or
 *      reconnect to the semaphore refer to a new semaphore after sem_unlink()
 *      is called. The sem_unlink() call shall not block until all references
 *      have been destroyed; it shall return immediately.
 *
 * @param name
 *      semaphore name
 *
 * @return
 *      Upon successful completion, the sem_unlink() function shall return a
 *      value of 0. Otherwise, the semaphore shall not be changed and the
 *      function shall return a value of -1 and set errno to indicate the
 *      error.
 *
 *      [EACCES]
 *           Permission is denied to unlink the named semaphore.
 *      [ENAMETOOLONG]
 *           The length of the name argument exceeds {PATH_MAX} or a pathname
 *           component is longer than {NAME_MAX}.
 *      [ENOENT]
 *           The named semaphore does not exist.
 */
int sem_unlink(const char *name)
{
        int result = 0;
        named_sem_t *named_sem = 0;

        if (!name || !*name)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&named_sem_mutex))
        {
                named_sem = named_sem_lookup (name);

                if (!named_sem)
                {
                        result = ENOENT;
                }
                else
                {
                        if ( !named_sem->ref)
                        {
                                named_sem_remove(named_sem);
                        }
                        else
                        {
                                named_sem->unlink = true;
                        }
                }

                pthread_mutex_unlock(&named_sem_mutex);
        }
        else
        {
                result = EINVAL;
        }

        if (result)
        {
                errno = result;
                return -1;
        }
        return 0;
}

