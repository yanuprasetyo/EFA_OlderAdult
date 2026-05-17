# =============================================================================
# EXPLORATORY FACTOR ANALYSIS (EFA)
# Multidimensional Vulnerability Among Indonesian Older Adults
# Data: PK21 BKKBN 2021 (N = 208,448)
# Author: [Your Name]
# Date: 2026
# =============================================================================

# -----------------------------------------------------------------------------
# 0. LOAD PACKAGES
# -----------------------------------------------------------------------------
# Install packages if not already installed
packages <- c("readxl", "mice", "psych", "ggplot2", "reshape2")
install.packages(setdiff(packages, rownames(installed.packages())))

library(readxl)
library(mice)
library(psych)
library(ggplot2)
library(reshape2)

# -----------------------------------------------------------------------------
# 1. IMPORT DATA
# -----------------------------------------------------------------------------
# Set working directory to folder containing the Excel file
# setwd("C:/Users/LENOVO/Documents")

df <- read_excel("EFA_Olderadult.xlsx", sheet = "olderadults")

# Check dimensions
dim(df)       # Should be: 208448 x 45
head(df)
names(df)

# -----------------------------------------------------------------------------
# 2. CHECK MISSING VALUES
# -----------------------------------------------------------------------------
colSums(is.na(df))
sum(is.na(df))  # Total missing = 0, no imputation needed

# -----------------------------------------------------------------------------
# 3. NORMALITY SCREENING
# Exclude variables with |skew| > 2 AND |kurtosis| > 7
# Based on Curran et al. (1996) as cited in Marr et al. (2021)
# -----------------------------------------------------------------------------
normalitas <- describe(df)
print(round(normalitas[, c("skew", "kurtosis")], 3))

# Identify variables violating BOTH criteria simultaneously
buang_normal <- rownames(normalitas)[abs(normalitas$skew) > 2 &
                                     abs(normalitas$kurtosis) > 7]
cat("Variables excluded due to non-normal distributions:\n")
print(buang_normal)
# Excluded (16): religion, worship, silent_conflict, runaway, kdrt,
#                food_diverse, posyandu, bkb_prog, uupks_prog, pnm_prog,
#                ngo_prog, roof, wall, sanitation, house_area, house_own

# Retain variables that pass normality screening
vars_lolos1 <- setdiff(names(df), buang_normal)
df1 <- df[, vars_lolos1]
cat("Variables remaining after normality screening:", ncol(df1), "\n")

# -----------------------------------------------------------------------------
# 4. INTER-ITEM CORRELATION SCREENING
# Exclude variables with max |r| < 0.2 with all other variables
# Threshold relaxed from 0.3 to 0.2 given large N (208,448)
# Based on Tabachnick & Fidell (2001)
# -----------------------------------------------------------------------------
mat_cor_b <- cor(df1)
max_cor_b <- apply(mat_cor_b, 1, function(x) max(abs(x[x != 1])))
print(round(max_cor_b, 3))

# Identify variables with max |r| < 0.2
buang_cor_b <- names(max_cor_b[max_cor_b < 0.2])
cat("\nVariables excluded due to weak correlations:\n")
print(buang_cor_b)
# Excluded (5): health_ins, illness, bkl_prog, pkh_prog, electricity

# Retain variables passing correlation screening
vars_lolos_b <- setdiff(names(df1), buang_cor_b)
df_b <- df1[, vars_lolos_b]
cat("Variables remaining after correlation screening:", ncol(df_b), "\n")

# -----------------------------------------------------------------------------
# 5. MULTICOLLINEARITY SCREENING
# Exclude one variable from pairs with |r| > 0.9
# -----------------------------------------------------------------------------
mat_cor2 <- cor(df_b)

# Identify highly correlated pairs
for(i in 1:ncol(mat_cor2)) {
  for(j in 1:ncol(mat_cor2)) {
    if(i < j && abs(mat_cor2[i,j]) > 0.9) {
      cat(colnames(mat_cor2)[i], "vs", colnames(mat_cor2)[j],
          ":", round(mat_cor2[i,j], 3), "\n")
    }
  }
}
# Pairs found:
# marital vs marr_cert: 0.903 → remove marr_cert
# marital vs bed_sep: 0.923  → remove bed_sep
# marr_cert vs bed_sep: 0.940 → remove bed_sep (already removed)
# dom_violence vs income: 1.000 → remove income (perfect duplicate)
# bkr_prog vs pirkm_prog: 0.951 → remove pirkm_prog

# Remove one from each highly correlated pair
buang_multi <- c("marr_cert", "bed_sep", "income", "pirkm_prog")
df_b <- df_b[, !names(df_b) %in% buang_multi]
cat("Variables remaining after multicollinearity screening:", ncol(df_b), "\n")

# -----------------------------------------------------------------------------
# 6. KMO AND BARTLETT'S TEST
# -----------------------------------------------------------------------------
kmo_b <- KMO(df_b)
print(kmo_b)
# Overall KMO = 0.80 (meritorious)

bartlett_b <- cortest.bartlett(cor(df_b), n = nrow(df_b))
print(bartlett_b)
# Bartlett's test: chi-sq = 1,310,602, p < .001

det_matrix <- det(cor(df_b))
cat("Determinant of correlation matrix:", det_matrix, "\n")
# Determinant = 0.00186 (> 0.00001, no multicollinearity problem)

# -----------------------------------------------------------------------------
# 7. DETERMINE NUMBER OF FACTORS
# Parallel Analysis (maximum estimate) + MAP Test (minimum estimate)
# Based on Marr et al. (2021)
# -----------------------------------------------------------------------------
fa.parallel(df_b, fm = "ml", fa = "fa",
            main = "Parallel Analysis Scree Plot")
# Parallel Analysis suggests: 8 factors (maximum)

vss(df_b, fm = "ml")
# MAP test achieves minimum with: 2 factors (minimum)
# Range to investigate: 2 to 8 factors

# -----------------------------------------------------------------------------
# 8. RUN EFA FOR ALL POSSIBLE FACTOR SOLUTIONS (2-8)
# Method: Maximum Likelihood (ML)
# Rotation: Oblimin (oblique) - allows factor correlations
# -----------------------------------------------------------------------------
efa_list <- list()
for(i in 2:8) {
  efa_list[[i]] <- fa(df_b, nfactors = i, fm = "ml", rotate = "oblimin")
}

# Compare fit indices across all solutions
hasil_fit3 <- data.frame(
  Faktor = 2:8,
  RMSEA  = sapply(2:8, function(i) efa_list[[i]]$RMSEA[1]),
  TLI    = sapply(2:8, function(i) efa_list[[i]]$TLI)
)
print(hasil_fit3)
# Result:
# 2 factors: RMSEA=0.122, TLI=0.549 (poor)
# 3 factors: RMSEA=0.105, TLI=0.665 (poor)
# 4 factors: RMSEA=0.083, TLI=0.790 (poor)
# 5 factors: RMSEA=0.054, TLI=0.913 (borderline)
# 6 factors: RMSEA=0.044, TLI=0.942 (borderline)
# 7 factors: RMSEA=0.037, TLI=0.958 (good)
# 8 factors: RMSEA=0.034, TLI=0.965 (good)

# -----------------------------------------------------------------------------
# 9. ITERATIVE MODEL REFINEMENT
# Remove variables not loading on any factor, then rerun EFA
# -----------------------------------------------------------------------------

# Remove variables not loading (savings, dom_violence)
df_c <- df_b[, !names(df_b) %in% c("savings", "dom_violence")]

# Remove variables not loading (age, social_part, water)
df_d <- df_c[, !names(df_c) %in% c("age", "social_part", "water")]
cat("Final variables for EFA:", ncol(df_d), "\n")
print(names(df_d))

# Final variables (15):
# hh_size, sex, marital, birth_cert, employment, education,
# internet, fam_interact, joint_parent, recreation, bkr_prog,
# floor, cooking_fuel, media_info, worker_infor

# Rerun EFA with final variable set (4-6 factors)
for(i in 4:6) {
  efa_c <- fa(df_d, nfactors = i, fm = "ml", rotate = "oblimin")
  cat("\n===", i, "FACTOR === RMSEA:", round(efa_c$RMSEA[1], 3),
      "| TLI:", round(efa_c$TLI, 3), "\n")
  print(efa_c$loadings, cutoff = 0.3, sort = TRUE)
}
# 4 factors: RMSEA=0.102, TLI=0.803 (poor)
# 5 factors: RMSEA=0.041, TLI=0.968 (GOOD - SELECTED)
# 6 factors: RMSEA=0.030, TLI=0.984 (good but 4 factors with only 2 items)

# -----------------------------------------------------------------------------
# 10. FINAL MODEL: 5-FACTOR SOLUTION
# -----------------------------------------------------------------------------
efa_final <- fa(df_d, nfactors = 5, fm = "ml", rotate = "oblimin")

# Pattern matrix (cutoff = 0.3)
print(efa_final$loadings, cutoff = 0.3, sort = TRUE)

# Full pattern matrix with all loadings
print(round(efa_final$loadings[], 3))

# Communalities
print(round(efa_final$communality, 3))

# Factor intercorrelations
print(round(efa_final$Phi, 3))

# Variance explained
print(round(efa_final$Vaccounted, 3))

# Model fit summary
cat("========================================\n")
cat("        FINAL EFA RESULTS\n")
cat("========================================\n")
cat("Number of variables:", ncol(df_d), "\n")
cat("Number of factors: 5\n")
cat("Estimation method: Maximum Likelihood\n")
cat("Rotation: Oblimin\n")
cat("RMSEA:", round(efa_final$RMSEA[1], 3), "\n")
cat("TLI:", round(efa_final$TLI, 3), "\n")
cat("Total variance explained:",
    round(sum(efa_final$Vaccounted[2,])*100, 1), "%\n")
cat("\nFactor structure:\n")
cat("ML4 - Family Engagement & Program Participation:",
    "joint_parent, bkr_prog, internet, hh_size\n")
cat("ML1 - Social Interaction & Recreation:",
    "fam_interact, recreation\n")
cat("ML3 - Demographic Status:",
    "marital, sex\n")
cat("ML5 - Basic Living Conditions:",
    "birth_cert, floor, cooking_fuel, education, employment\n")
cat("ML2 - Information Access:",
    "media_info, worker_infor\n")

# -----------------------------------------------------------------------------
# 11. OMEGA RELIABILITY COEFFICIENTS
# -----------------------------------------------------------------------------
items_ML4 <- df_d[, c("joint_parent", "bkr_prog", "internet", "hh_size")]
items_ML1 <- df_d[, c("fam_interact", "recreation")]
items_ML3 <- df_d[, c("marital", "sex")]
items_ML5 <- df_d[, c("birth_cert", "floor", "cooking_fuel",
                       "education", "employment")]
items_ML2 <- df_d[, c("media_info", "worker_infor")]

omega_ML4 <- omega(items_ML4, nfactors = 1)
omega_ML1 <- omega(items_ML1, nfactors = 1)
omega_ML3 <- omega(items_ML3, nfactors = 1)
omega_ML5 <- omega(items_ML5, nfactors = 1)
omega_ML2 <- omega(items_ML2, nfactors = 1)

cat("=== OMEGA RELIABILITY PER FACTOR ===\n")
cat("ML4 - Family Engagement & Program Participation:",
    round(omega_ML4$omega.tot, 3), "\n")  # 0.796
cat("ML1 - Social Interaction & Recreation:",
    round(omega_ML1$omega.tot, 3), "\n")  # 0.865
cat("ML3 - Demographic Status:",
    round(omega_ML3$omega.tot, 3), "\n")  # 0.879
cat("ML5 - Basic Living Conditions:",
    round(omega_ML5$omega.tot, 3), "\n")  # 0.630
cat("ML2 - Information Access:",
    round(omega_ML2$omega.tot, 3), "\n")  # 0.773

# -----------------------------------------------------------------------------
# 12. VISUALIZATIONS
# -----------------------------------------------------------------------------

# 12a. Parallel Analysis Scree Plot
fa.parallel(df_d, fm = "ml", fa = "fa",
            main = "Parallel Analysis Scree Plot")

# 12b. Factor Analysis Diagram
fa.diagram(efa_final,
           main = "Factor Analysis Diagram",
           cut = 0.3,
           digits = 2,
           rsize = 0.8,
           cex = 0.8)

# 12c. Inter-Item Correlation Heatmap
cor_matrix <- round(cor(df_d), 2)
cor_melted <- melt(cor_matrix)

ggplot(cor_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = value), size = 2.5, color = "black") +
  scale_fill_gradient2(
    low = "steelblue", mid = "white", high = "firebrick",
    midpoint = 0, limit = c(-1, 1), name = "Correlation"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
    axis.text.y = element_text(size = 9),
    plot.title = element_text(hjust = 0.5, face = "bold", size = 12),
    legend.position = "right"
  ) +
  labs(
    title = "Inter-Item Correlation Matrix",
    x = "", y = ""
  )

# =============================================================================
# END OF ANALYSIS
# =============================================================================
