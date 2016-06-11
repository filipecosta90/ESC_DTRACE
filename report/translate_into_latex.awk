BEGIN {FS=",";}

NR == 1 {
  print "\\begin{table}[H]";
  print "\\caption{ }";
  print "\\label{table:}";
  print "\\centering";
  printf "\\begin{tabular}{ | "
    for(i = 1; i <= NF; i++) { printf " l | " };
    print " } ";
    print "\\hline";
  }

  NR == 2 { print "\\\\ \\hline \\hline" }
  {for(i = 1; i < NF; i++) { printf $i" &" };print $(NF) "\\\\ \\hline";}

END{
    print "\\end{tabular}";
    print "\\end{table}";
  }
