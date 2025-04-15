library(circlize)

# Carregue os dados do arquivo CSV
genc1_data <- read.csv("C:/circlize/chrA1.csv", sep = ",", header = TRUE)
genc2_data <- read.csv("C:/circlize/chrA2.csv", sep = ",", header = TRUE)
genc3_data <- read.csv("C:/circlize/chrA3.csv", sep = ",", header = TRUE)
genc4_data <- read.csv("C:/circlize/chrA4.csv", sep = ",", header = TRUE)
genc5_data <- read.csv("C:/circlize/chrA5.csv", sep = ",", header = TRUE)
genc6_data <- read.csv("C:/circlize/chrA6.csv", sep = ",", header = TRUE)
genc7_data <- read.csv("C:/circlize/chrA7.csv", sep = ",", header = TRUE)

# Crie um data.frame com os dados dos cromossomos
chromosome_data <- data.frame(
  name  = c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7"),
  start = c(0, 0, 0, 0, 0, 0, 0),
  end   = c(525998853, 469027352, 409104003, 460274884, 476570516, 445971415, 490396680)
)

# Inicialize o gráfico com os dados dos cromossomos
circos.genomicInitialize(chromosome_data)

# Plote os dados dos cromossomos no gráfico
circos.genomicPoints(chromosome_data, x = "start", y = "end", value = rep(0, nrow(chromosome_data)), pch = 16, cex = 0.4, col = "#FF000080")

# Plote os dados do arquivo CSV no gráfico
ssr_list <- list(genc1_data)
circos.genomicDensity(genc1_data, col = c("#FF000080"), track.height = 0.1)
circos.genomicDensity(genc2_data, col = c("#4169E1"), track.height = 0.1)
circos.genomicDensity(genc3_data, col = c("#00FFFF"), track.height = 0.1)
circos.genomicDensity(genc4_data, col = c("#00FF7F"), track.height = 0.1)
circos.genomicDensity(genc5_data, col = c("#DAA520"), track.height = 0.1)
circos.genomicDensity(genc6_data, col = c("#FF0544"), track.height = 0.1)
circos.genomicDensity(genc7_data, col = c("#a43955"), track.height = 0.1)

circos.clear()
