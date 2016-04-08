syscall::openat*:entry {
printf("%s %s", execname, copyinstr(arg1) ,  );
      }

