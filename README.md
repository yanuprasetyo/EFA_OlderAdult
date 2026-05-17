# Exploratory Factor Analysis of Multidimensional Vulnerability Among Indonesian Older Adults

## Overview

This repository contains the R code and documentation for the study:

> **"Exploring Multidimensional Vulnerability Among Indonesian Older Adults: An Exploratory Factor Analysis"**

Using data from the 2021 nationally representative Family Data Collection (PK21) survey conducted by the National Population and Family Planning Board (BKKBN) of Indonesia, this study employs Exploratory Factor Analysis (EFA) to identify the latent vulnerability dimensions among 208,448 older Indonesians aged 60–89 years.

---

## Key Findings

Five distinct vulnerability dimensions were identified:

| Factor | Label | Variables | ω |
|--------|-------|-----------|---|
| ML4 | Family Engagement & Program Participation | joint_parent, bkr_prog, internet, hh_size | 0.796 |
| ML1 | Social Interaction & Recreation | fam_interact, recreation | 0.865 |
| ML3 | Demographic Status | marital, sex | 0.879 |
| ML5 | Basic Living Conditions | birth_cert, floor, cooking_fuel, education, employment | 0.630 |
| ML2 | Information Access | media_info, worker_infor | 0.773 |

**Model Fit:** RMSEA = .041 | TLI = .968 | Total Variance Explained = 54.7%

---

## Repository Structure

```
EFA_OlderAdult/
├── R/
│   └── 01_EFA_Analysis.R       # Main analysis script
├── data/
│   └── README_data.md          # Data description (data not included)
├── output/
│   └── README_output.md        # Description of outputs
├── docs/
│   └── variable_codebook.md    # Variable descriptions
└── README.md                   # This file
```

---

## Requirements

### Software
- R (version 4.6 or higher)
- RStudio (recommended)

### R Packages
```r
install.packages(c("readxl", "mice", "psych", "ggplot2", "reshape2"))
```

| Package | Version | Purpose |
|---------|---------|---------|
| readxl | 1.4.5 | Import Excel data |
| mice | 3.19.0 | Missing data handling |
| psych | 2.6.3 | EFA, KMO, omega reliability |
| ggplot2 | latest | Correlation heatmap |
| reshape2 | latest | Data reshaping for visualization |

---

## Data

The analysis uses the **2021 Family Data Collection (PK21)** survey by BKKBN Indonesia.

- **N =** 208,448 older adults aged 60–89 years
- **Original variables =** 45
- **Final variables for EFA =** 15 (after screening)
- **Data access:** Contact BKKBN Indonesia at https://www.bkkbn.go.id

> **Note:** The raw data cannot be shared publicly due to data governance agreements with BKKBN. Researchers interested in accessing the data should contact BKKBN directly.

---

## Variable Screening Procedure

Variables were retained for EFA following four sequential criteria:

1. **Normality:** Excluded if |skew| > 2 AND |kurtosis| > 7 → **16 excluded**
2. **Inter-item correlation:** Excluded if max |r| < .2 → **5 excluded**
3. **Multicollinearity:** Excluded one from pairs with |r| > .9 → **4 excluded**
4. **Factor loading:** Excluded if no loading ≥ .3 on any factor → **5 excluded**

**Final: 15 variables retained**

---

## Analysis Pipeline

```
Raw Data (45 variables, N=208,448)
         ↓
Step 1: Missing Value Check
         ↓ (No missing values found)
Step 2: Normality Screening (|skew|>2 AND |kurtosis|>7)
         ↓ (16 variables excluded)
Step 3: Inter-item Correlation (max|r|≥.2)
         ↓ (5 variables excluded)
Step 4: Multicollinearity Check (|r|>.9)
         ↓ (4 variables excluded)
Step 5: KMO & Bartlett's Test
         ↓ (KMO=.80, Bartlett p<.001)
Step 6: Parallel Analysis + MAP Test
         ↓ (Range: 2-8 factors investigated)
Step 7: EFA (ML + Oblimin rotation)
         ↓ (Iterative refinement)
Step 8: Final 5-Factor Model
         ↓ (RMSEA=.041, TLI=.968)
Step 9: Omega Reliability Estimates
```

---

## How to Run

1. Clone this repository:
```bash
git clone https://github.com/[username]/EFA_OlderAdult.git
```

2. Place your data file `EFA_Olderadult.xlsx` in the project folder.

3. Open `R/01_EFA_Analysis.R` in RStudio.

4. Set your working directory:
```r
setwd("path/to/EFA_OlderAdult")
```

5. Run the script from top to bottom (Ctrl+A → Ctrl+Enter).

---

## Citation

If you use this code, please cite:

> [Authors]. (2026). Exploring multidimensional vulnerability among Indonesian older adults: An exploratory factor analysis. *[Journal Name]*. https://doi.org/[DOI]

---

## Methodological References

- Curran, P. J., West, S. G., & Finch, J. F. (1996). The robustness of test statistics to nonnormality and specification error in confirmatory factor analysis. *Psychological Methods, 1*(1), 16–29.
- Costello, A. B., & Osborne, J. (2005). Best practices in exploratory factor analysis. *Practical Assessment, Research, and Evaluation, 10*(7). https://doi.org/10.7275/jyj1-4868
- Guadagnoli, E., & Velicer, W. F. (1988). Relation of sample size to the stability of component patterns. *Psychological Bulletin, 103*(2), 265–275. https://doi.org/10.1037/0033-2909.103.2.265
- Marr, C., Vaportzis, E., Niechcial, M. A., Dewar, M., & Gow, A. J. (2021). Measuring activity engagement in old age: An exploratory factor analysis. *PLOS ONE, 16*(12), e0260996. https://doi.org/10.1371/journal.pone.0260996
- Tabachnick, B. G., & Fidell, L. S. (2001). *Using Multivariate Statistics* (4th ed.). Allyn and Bacon.

---

## License

This code is released under the [MIT License](LICENSE).

---

## Contact

For questions about this analysis, please contact:
- **Institution:** Directorate of Human Development, Population, and Culture, Deputy for Development Policy
- **Email:** [your email]
