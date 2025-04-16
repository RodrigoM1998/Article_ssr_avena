use strict;
use warnings;

# Caminhos dos arquivos de entrada e saída
my $ssrs_file = 'avena_ssrs.csv';
my $genes_file = 'avena_genes.csv';
my $output_file = 'genica_ssrs.csv';

# Hash para armazenar as regiões gênicas
my %genes;

# Ler o arquivo de genes e armazenar as regiões gênicas
open my $genes_fh, '<', $genes_file or die "Não foi possível abrir $genes_file: $!";
<$genes_fh>; # Ignorar cabeçalho
while (<$genes_fh>) {
    chomp;
    my ($chr, $gene, $start, $end, $id) = split /;/;
    push @{ $genes{$chr} }, { start => $start, end => $end };
}
close $genes_fh;

# Abrir arquivo de saída
open my $out_fh, '>', $output_file or die "Não foi possível criar $output_file: $!";

# Processar o arquivo de SSRs e filtrar os dados
open my $ssrs_fh, '<', $ssrs_file or die "Não foi possível abrir $ssrs_file: $!";
my $header = <$ssrs_fh>;
print $out_fh $header; # Escrever cabeçalho no arquivo de saída

while (<$ssrs_fh>) {
    chomp;
    my ($id, $chr, $type, $start, $end) = split /;/;
    
    # Verifica se está dentro de uma região gênica
    if (exists $genes{$chr}) {
        foreach my $gene (@{ $genes{$chr} }) {
            if ($start >= $gene->{start} && $end <= $gene->{end}) {
                print $out_fh "$_\n";
                last;
            }
        }
    }
}

close $ssrs_fh;
close $out_fh;

print "Arquivo filtrado salvo como $output_file\n";