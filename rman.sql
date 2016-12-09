run { allocate channel t1 type 'sbt_tape' parms 'ENV=(TDPO_OPTFILE=/etc/tivoli/tdpo.opt)'; restore database; recover database; alter database open; }


RUN {
     ALLOCATE CHANNEL FOR MAINTENANCE DEVICE TYPE sbt;
     CROSSCHECK BACKUP;  
}
RUN { ALLOCATE CHANNEL FOR MAINTENANCE DEVICE TYPE sbt; CROSSCHECK BACKUP; }

run { allocate channel t1 type 'sbt_tape' parms 'ENV=(TDPO_OPTFILE=/etc/tivoli/tdpo.opt)'; crosscheck backup; }

run { allocate channel t1 type 'sbt_tape' parms 'ENV=(TDPO_OPTFILE=/etc/tivoli/tdpo.opt)'; list backup; }