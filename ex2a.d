#!/usr/sbin/dtrace -s

/*
 ********************************************************************************
 *   Copyright(C) 2016 Filipe Oliveira
 *   HPC Group, Computer Science Dpt.
 *   University of Minho
 *   All Rights Reserved.
 ********************************************************************************
 *   Content : simple openat and openat64 system calls tracer and agregator by
 *             by pid and opening mode
 *     
 ********************************************************************************/

#pragma D option quiet
 
dtrace:::BEGIN {
 printf("*********************************************************************************\n");
 printf("openat and openat64 syscalls aggregator\n");
 printf("!=O_CREAT ::  opening files already in system\n");
 printf("  O_CREAT ::  opening files with flag to create\n");
 printf("    #SUCC ::  sucessfull openat and openat64 system calls\n");
 printf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n");
}

/* will catch openat and openat64 number of tries to create file */
syscall::openat*:entry 
/( arg2 & O_CREAT) == 0 /
{
  @open_request[ pid ] = count();
}

/* will catch openat and openat64 number of tries to create file */
syscall::openat*:entry 
/ ( arg2 & O_CREAT ) == O_CREAT /
{
  @create_request[ pid ] = count();
}

/* will catch openat and openat64 sucessfull file open
 * from linux man: " On success, openat() returns a new file descriptor. 
 * On error, -1 is returned and errno is set to indicate the error."  */
syscall::openat*:return
/arg1 >= 0/
{
  @successfull[ pid ] = count();
}

dtrace:::END {
 printf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n");
 printf( "%-6s\t%10s\t%10s\t%10s\n", "pid", "!=O_CREAT", "O_CREAT","#SUCC" );
 printf("*********************************************************************************\n");
 printa( "%6d\t%@10d\t%@10d\t%@10d\n", @open_request, @create_request, @successfull );
  clear(@open_request);
  clear(@create_request);
  clear(@successfull);
}

