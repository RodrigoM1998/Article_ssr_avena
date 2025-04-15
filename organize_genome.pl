#!/usr/bin/perl -w


open (IN1,"<avenaeg.fasta");
open (IN2,">aveiaouteg.fasta");

$/ = ">";
my ($id,$seq);


while (<IN1>)
{

   next unless (($id,$seq) = /(.*?)\n(.*)/s);

   $seq =~ s/[\d\s>]//g; #remove digitos, espacos, linhas de parada,...
  
   $id =~ s/^\s*//g;
   $id =~ s/\s*$//g;
   $id =~ s/\s/_/g; #substitui espaco por (underline) "_"
   $id =~ s/ /_/g; #substitui espaco por (underline) "_"
   
  
   print IN2   ">$id\n";
   print IN2   "$seq\n";
   print IN2   "\n";
	
};

close (IN1);
close (IN2);

print "fim";
