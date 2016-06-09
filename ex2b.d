#!/usr/sbin/dtrace -s

/*
 ********************************************************************************
 *   Copyright(C) 2016 Filipe Oliveira
 *   HPC Group, Computer Science Dpt.
 *   University of Minho
 *   All Rights Reserved.
 ********************************************************************************
 *   Content : simple openat and openat64 system calls tracer and agregator by
 *             by pid and opening mode at a constant time rate passed by argumment
 *     
 ********************************************************************************/

#pragma D option quiet

dtrace:::BEGIN {
  printf("*********************************************************************************\n");
  printf("openat and openat64 syscalls aggregator by constant time rate passed by argumment\n");
  printf("\n TIME RATE %d seconds \n", $1);
  printf("START TIME %Y \n\n", walltimestamp);
  printf("!=O_CREAT ::  opening files already in system\n");
  printf("  O_CREAT ::  opening files with flag to create\n");
  printf("    #SUCC ::  sucessfull openat and openat64 system calls\n");
  printf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n");
  printf( "%-6s\t%-20s\t%10s\t%10s\t%10s\n", "pid", "execname", "!=O_CREAT", "O_CREAT","#SUCC" );
  printf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n");

}

/* will catch openat and openat64 number of tries to create file */
syscall::openat*:entry 
/( arg2 & O_CREAT) == 0 /
{
  @open_request[  pid, execname ] = count();
  @all_open_request[  pid, execname ] = count();
}

/* will catch openat and openat64 number of tries to create file */
syscall::openat*:entry 
/ ( arg2 & O_CREAT ) == O_CREAT /
{
  @create_request[  pid, execname ] = count();
  @all_create_request[  pid, execname ] = count();
}

/* will catch openat and openat64 sucessfull file open
 * from linux man: " On success, openat() returns a new file descriptor. 
 * On error, -1 is returned and errno is set to indicate the error."  */
syscall::openat*:return
/arg1 >= 0/
{
  @successfull[ pid, execname ] = count();
  @all_successfull[ pid, execname ] = count();
}

tick-$1s {
  printf("\n[ %20Y * * * * * * * * * * \n", walltimestamp);
  printa( "%6d\t%-20s\t%@10d\t%@10d\t%@10d\n", @open_request, @create_request, @successfull );
  trunc(@open_request);
  trunc(@create_request);
  trunc(@successfull);
  printf("                                         * * * * * * * * * * * * * * * * * * * *]\n");
}

dtrace:::END {
  printf("\n**************************** AGGREGATED RESULTS *********************************\n");
  printf("                               %20Y \n\n", walltimestamp);
  printa( "%6d\t%-20s\t%@10d\t%@10d\t%@10d\n", @all_open_request, @all_create_request, @all_successfull );
  printf("\n*********************************************************************************\n");
  clear(@all_open_request);
  clear(@all_create_request);
  clear(@all_successfull);
  clear(@open_request);
  clear(@create_request);
  clear(@successfull);
}

