library(dplyr)
library(tidyr)
library(janitor)

# 1. Ler e preparar os dados ----------------------------------------------
dados <- read.csv(
  "C:/Users/rpmac/OneDrive/Área de Trabalho/Artigo_SSR/Avena_insularis/analisetotal/Associar_regioes_contagem/genomeD/prontos/ssrs_genica_ainsularisD_PRONTA.csv", 
  sep = ";",
  col.names = c("id", "sequence", "standard", "motif", "type", "repeats", "start", "end", "length")
) %>% 
  mutate(
    repeats = as.numeric(repeats),
    type = factor(type),
    motif_length = nchar(as.character(motif)),  # Define o tipo de SSR com base no tamanho do motivo
    type_label = paste0(motif_length, "-mer"),  # Nomeia as categorias de SSRs (ex: 2-mer, 3-mer)
    repeat_group = case_when(
      repeats >= 45 ~ "≥45",
      repeats >= 3 & repeats <= 44 ~ as.character(repeats),
      TRUE ~ "Outros"
    )
  ) %>% 
  filter(repeat_group != "Outros")  # Remove repetições fora do intervalo desejado

# 2. Criar tabela de contagem ---------------------------------------------
tabela <- dados %>%
  count(type_label, repeat_group) %>%
  complete(type_label, repeat_group, fill = list(n = 0)) %>%
  mutate(repeat_group = factor(repeat_group, levels = c(sort(as.numeric(unique(repeat_group[repeat_group != "≥45"]))), "≥45"))) %>%
  arrange(repeat_group, type_label)

# 3. Criar tabela pivotada para visualização melhorada -------------------
tabela_final <- tabela %>%
  pivot_wider(
    names_from = type_label, 
    values_from = n, 
    values_fill = 0
  ) %>%
  adorn_totals("row") # Adiciona totais

# 4. Salvar e visualizar -------------------------------------------------
write.csv(
  tabela_final,
  "C:/Users/rpmac/OneDrive/Área de Trabalho/SSR_Distribution_Repeat_ainsularisD_genica.csv",
  row.names = FALSE
)

# Exibir tabela formatada
knitr::kable(tabela_final, align = "c", caption = "SSR Distribution by Repeat Count and Motif Type") %>%
  kableExtra::kable_styling(
    bootstrap_options = c("striped", "hover"),
    full_width = FALSE,
    font_size = 14
  )
