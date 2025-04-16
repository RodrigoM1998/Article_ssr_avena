# Carregar pacotes necessários
library(dplyr)

# Caminho do arquivo (substitua pelo caminho correto)
file_path <- "C:/Users/rpmac/OneDrive/Área de Trabalho/Artigo_SSR/Avena_sativa/analisetotal/genomeD/prontos/ssrs_intergenica_avena_PRONTA.csv"

# Carregar os dados
data <- read.csv(file_path, stringsAsFactors = FALSE, sep = ";")

# Garantir que o nome da coluna está correto
colnames(data) <- tolower(colnames(data))  # Converter nomes para minúsculas

# Converter a coluna motif para maiúsculas para padronizar e evitar duplicação
data$motif <- toupper(data$motif)

# Criar função para classificar SSRs com base no comprimento do motivo
classify_ssr <- function(motif) {
  n <- nchar(motif)  # Contar número de caracteres no motivo
  return(paste0(n, "-mer"))  # Criar categoria (1-mer, 2-mer, ..., 6-mer)
}

# Contar quantos SSRs existem para cada motivo, agora considerando letras maiúsculas/minúsculas como iguais
ssr_counts <- data %>%
  group_by(motif) %>%
  summarise(count = n(), .groups = "drop") %>%
  mutate(type = classify_ssr(motif))  # Classificar por tipo de SSR

# Calcular o total de SSRs por tipo (mono, di, tri...)
total_by_type <- ssr_counts %>%
  group_by(type) %>%
  summarise(total = sum(count), .groups = "drop")

# Juntar os totais e calcular percentuais
ssr_counts <- ssr_counts %>%
  left_join(total_by_type, by = "type") %>%
  mutate(percent = (count / total) * 100)  # Percentual dentro do tipo

# Calcular percentual geral em relação ao total de SSRs
total_ssr <- sum(ssr_counts$count)
ssr_counts <- ssr_counts %>%
  mutate(overall_percent = (count / total_ssr) * 100)

# Ordenar primeiro pelo tipo de SSR (1-mer antes de 2-mer, etc.)
ssr_counts$type <- factor(ssr_counts$type, levels = c("1-mer", "2-mer", "3-mer", "4-mer", "5-mer", "6-mer"))
ssr_counts <- ssr_counts %>%
  arrange(type, motif)

# Salvar o resultado em um arquivo CSV
output_path <- "C:/Users/rpmac/OneDrive/Área de Trabalho/asativaD_count_ssr_intergenica.csv"
write.csv(ssr_counts, output_path, row.names = FALSE)

# Exibir os primeiros resultados
print(head(ssr_counts, 20))
