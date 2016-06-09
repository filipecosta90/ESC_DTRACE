#!/usr/sbin/dtrace -s

/*
 ********************************************************************************
 *   Copyright(C) 2016 Filipe Oliveira
 *   HPC Group, Computer Science Dpt.
 *   University of Minho
 *   All Rights Reserved.
 ********************************************************************************
 *   Content : simple openat and openat64 system calls tracer 
 *             with /etc/ on its pathname
 *     
 ********************************************************************************/

#pragma D option quiet

dtrace:::BEGIN {
  printf("%-10s%-8s%-8s%-8s%-30s%-27s%-5s\n",  "EXEC" , "PID", "UID" , "GID", "ABS PATH" , "FLAGS", "RETURNED VALUE");
}

/* will catch openat and openat64 */
syscall::openat*:entry
{
  self->pathname =copyinstr(arg1);
  self->flags = arg2;
}

/* will catch openat and openat64 */
syscall::openat*:return

/strstr(self->pathname,"/etc") != NULL/
{
  printf("%-10s%-8d%-8d%-8d%-30s", execname, pid, uid, gid, self->pathname);
  /*if its not O_WRONLY or O_RDWR then its implicitly O_RDONLY */
  printf( "%-9s" , self->flags & O_WRONLY ? " O_WRONLY " : self->flags & O_RDWR ? " O_RDWR " : " O_RDONLY " ); 
  printf( "%-9s" , self->flags & O_APPEND ? "| O_APPEND " : "" );
  printf( "%-9s" , self->flags & O_CREAT ? "| O_CREAT " : "" );
  printf("%5i\n", arg1);
}

