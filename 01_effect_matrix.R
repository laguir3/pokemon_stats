# setup environment ----
## load packages ----
library(tidyverse)
library(reshape)
library(lattice)

## load data ----
type_matrix <- read.csv(file = "data/pokemon_type.csv")

## format data ----
type_matrix <- type_matrix |> 
  mutate(across(everything(), ~replace_na(., 1)))

# get types
types_list <- type_matrix[1]

# convert to matrix
# remove first row
type_matrix <- type_matrix |> 
  column_to_rownames(var = "X") |> 
  as.matrix()

# longformat for ggplot heatmap
type_dataframe <- melt(type_matrix)
names(type_dataframe)[1:2] <- c("attacker", "defender")

# as factors
type_dataframe <- type_dataframe |> 
  mutate(value = as.factor(value))

# heatmatrix
# define color 
cols <- c("0" = "black", 
          "0.5" = "orangered1",
          "1" = "honeydew",
          "2" = "springgreen4")
ggplot(data = type_dataframe) +
  geom_tile(aes(x = defender, 
                y = attacker, 
                fill = value)) + 
  scale_fill_manual(values = cols) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
  

# per type handicaps

# network