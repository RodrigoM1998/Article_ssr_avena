#!C:\perl2\perl\bin\perl -w
use warnings;
open (IN1,"<gene_avena.GFF3");
open (OUT1,">avena_genes.csv");

while (<IN1>) 
{
	
	if ($_ =~ "#")
	{
	}
	else
	{	
		my @colunas    = split("\t", $_);
		
		if ($colunas[2] eq "gene")
		{
			my @colunas_gene    = split("=", $colunas[8]);
			my @colunas_gene    = split(";", $colunas_gene[1]);
			print OUT1 "$colunas[0];$colunas[1];$colunas[2];$colunas[3];$colunas[4];$colunas_gene[0]\n";		
		}	
	}
}
close (IN1);
close (OUT1);

print('\n Fim............. \n')