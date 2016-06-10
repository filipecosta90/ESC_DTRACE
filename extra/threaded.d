#!/usr/sbin/dtrace -s
#pragma D option quiet
BEGIN
{
  baseline = timestamp;
  printf("%-20s , %-20s, %-8s , %-8s , %-8s, %-8s , %-8s, %-25s, %-15s\n",
      "TIMESTAMP","TIMESTAMP","TID","CURR CPU","CURR GRP","LAST CPU","LAST GRP","TYPE","DESCRIPTION" 
      );
}
sched:::on-cpu
/pid == $target && !self->stamp /
{
  self->lastcpu = curcpu->cpu_id;
  self->lastlgrp = curcpu->cpu_lgrp;
  self->stamp = timestamp - baseline;
  self->delta = 0;

  printf("%-20d , %-20d, %-8d , %-8d , %-8d, %-8d , %-8d, %-25s, %-15s\n",
      self->stamp, self->delta,
      tid, 
      curcpu->cpu_id,
      curcpu->cpu_lgrp,
      self->lastcpu, self->lastlgrp,
      "CREATE", ""
      );
}

sched:::on-cpu
/pid == $target && self->stamp && self->lastcpu\
      != curcpu->cpu_id/
{
  self->delta = timestamp - self->stamp;
  self->stamp = timestamp - baseline;

  printf("%-20d , %-20d, %-8d , %-8d , %-8d, %-8d , %-8d, %-25s, %-15s\n",
      self->stamp, self->delta,
      tid, 
      curcpu->cpu_id,
      curcpu->cpu_lgrp,
      self->lastcpu, self->lastlgrp,
      "CPU MIGRATION", ""
      );

  self->lastcpu =curcpu->cpu_id;
  self->lastlgrp = curcpu->cpu_lgrp;
}

sched:::on-cpu
/pid == $target && self->stamp && self->lastcpu\
      == curcpu->cpu_id/
{
  self->delta = timestamp - self->stamp;
  self->stamp = timestamp - baseline;

  printf("%-20d , %-20d, %-8d , %-8d , %-8d, %-8d , %-8d, %-25s, %-15s\n",
      self->stamp, self->delta,
      tid, 
      curcpu->cpu_id,
      curcpu->cpu_lgrp,
      self->lastcpu, self->lastlgrp,
      "RESTART ON SAME CPU", ""
      );

}

sched:::off-cpu
/pid == $target && self->stamp /
{
  self->delta = timestamp - self->stamp;
  self->stamp = timestamp - baseline;

  printf("%-20d , %-20d, %-8d , %-8d , %-8d, %-8d , %-8d, %-25s, %-15s\n",
      self->stamp, self->delta,
      tid, 
      curcpu->cpu_id,
      curcpu->cpu_lgrp,
      self->lastcpu, self->lastlgrp,
      "PREEMPTED", ""
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

  self->delta = timestamp - self->stamp;
  self->stamp = timestamp - baseline;

  printf("%-20d , %-20d, %-8d , %-8d , %-8d, %-8d , %-8d, %-25s, %-15s\n",
      self->stamp, self->delta,
      tid, 
      curcpu->cpu_id,
      curcpu->cpu_lgrp,
      self->lastcpu, self->lastlgrp,
      "SLEEPING ON", self->sobj
      );

}
