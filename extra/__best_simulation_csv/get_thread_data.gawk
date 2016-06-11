BEGIN {
    FS=",";
    }

/$3 == $'$threadid'/ { print $3 ; }
