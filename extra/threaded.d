#!/usr/sbin/dtrace -s
#pragma D option quiet
BEGIN
{
  baseline = timestamp;
  scale = 1000000;
  printf("%-10s , %-10s, %-8s , %-8s , %-8s, %-8s , %-8s, %-15s, %-15s\n","DELTA","TIMESTAMP","TID","CURR CPU","CURR GROUP","LAST CPU","LAST GROUP","TYPE","DESCRIPTION" );
}
sched:::on-cpu
/pid == $target && !self->stamp /
{
  self->stamp = timestamp; 
  self->lastcpu = curcpu->cpu_id;
  self->lastlgrp = curcpu->cpu_lgrp;
  self->stamp = (timestamp - baseline) / scale;
  printf("%-10d , %-10d, %-8d , %-8d , %-8d, %-8d , %-8d, %-15s, %-15s\n",
      self->stamp,      0,   tid, curcpu->cpu_id, curcpu->cpu_lgrp, -1, -1, "CREATE", ""
      );
}

sched:::on-cpu
/pid == $target && self->stamp && self->lastcpu\
      != curcpu->cpu_id/
{
  self->delta = (timestamp - self->stamp) / scale;
  self->stamp = timestamp;
  self->stamp = (timestamp - baseline) / scale;

  printf("%-10d , %-10d, %-8d , %-8d , %-8d, %-8d , %-8d, %-15s, %-15s\n",
      self->stamp, self->delta,   tid, curcpu->cpu_id, curcpu->cpu_lgrp, self->lastcpu, self->lastgrp, "CPU MIGRATION", ""
      );

  self->lastcpu =curcpu->cpu_id;
  self->latgrp = curcpu->cpu_lgrp;
}

sched:::on-cpu
/pid == $target && self->stamp && self->lastcpu\
      == curcpu->cpu_id/
{
  self->delta = (timestamp - self->stamp) / scale;
  self->stamp = timestamp; 
  self->stamp = (timestamp - baseline) / scale;

  printf("%-10d , %-10d, %-8d , %-8d , %-8d, %-8d , %-8d, %-15s, %-15s\n",
      self->stamp, self->delta,   tid, curcpu->cpu_id, curcpu->cpu_lgrp, -1, -1, "RSTRT SAME CPU", ""
      );

}

sched:::off-cpu
/pid == $target && self->stamp /
{
  self->delta = (timestamp - self->stamp) / scale;
  self->stamp = timestamp; 
  self->stamp = (timestamp - baseline) / scale;

  printf("%-10d , %-10d, %-8d , %-8d , %-8d, %-8d , %-8d, %-15s, %-15s\n",
      self->stamp, self->delta,   tid, curcpu->cpu_id, curcpu->cpu_lgrp, -1, -1, "PREEMPTED", ""
      );
}

sched:::sleep
/pid == $target /
{
  self->sobj = (curlwpsinfo->pr_stype == SOBJ_MUTEX ?
      "kernel mutex" : curlwpsinfo->pr_stype == SOBJ_RWLOCK ?
      "kernel RW lock" : curlwpsinfo->pr_stype == SOBJ_CV ?
      "cond var" : curlwpsinfo->pr_stype == SOBJ_SEMA ?
      "kernel semaphore" : curlwpsinfo->pr_stype == SOBJ_USER ?
      "user-level lock" : curlwpsinfo->pr_stype == SOBJ_USER_PI ?
      "user-level PI lock" : curlwpsinfo->pr_stype == SOBJ_SHUTTLE ?
      "shuttle" : "unknown");
  self->delta = (timestamp - self->stamp) /scale;
  self->stamp = timestamp; 
  self->stamp = (timestamp - baseline) / scale;


  printf("%-10d , %-10d, %-8d , %-8d , %-8d, %-8d , %-8d, %-15s, %-15s\n",
      self->stamp, self->delta,   tid, curcpu->cpu_id, curcpu->cpu_lgrp, self->lastcpu, self->lastgrp, "SLEEPING ON", self->sobj
      );

}
