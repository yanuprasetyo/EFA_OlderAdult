# Variable Codebook

## Source
2021 Family Data Collection (PK21) Survey, BKKBN Indonesia

## Final Variables Used in EFA (15 variables)

| Variable | Label | Scale | Coding |
|----------|-------|-------|--------|
| hh_size | Household Size | Continuous | Number of household members |
| sex | Gender | Nominal | 1=Male, 2=Female |
| marital | Marital Status | Nominal | 1=Single, 2=Married, 3=Divorced, 4=Widowed |
| birth_cert | Birth Certificate | Binary | 1=Yes, 2=No |
| employment | Employment Status | Ordinal | 1-10 (categories) |
| education | Education Level | Ordinal | 1-10 (categories) |
| internet | Internet Access | Binary | 1=Yes, 2=No |
| fam_interact | Family Interaction | Ordinal | 1=Often, 2=Sometimes, 3=Never |
| joint_parent | Joint Parenting | Ordinal | 1=Yes, 2=Sometimes, 3=No |
| recreation | Recreation Activity | Ordinal | 1=Often, 2=Sometimes, 3=Never |
| bkr_prog | BKR Program Participation | Ordinal | 1=Active, 2=Inactive, 3=Not member |
| floor | Floor Material | Ordinal | 1-6 (material categories) |
| cooking_fuel | Cooking Fuel Type | Ordinal | 1-4 (fuel categories) |
| media_info | Media Information Access | Binary | 1=Yes, 2=No |
| worker_infor | Worker Information Access | Binary | 1=Yes, 2=No |

## Variables Excluded from EFA

### Excluded — Non-normal Distribution (|skew|>2 AND |kurtosis|>7)
| Variable | Skew | Kurtosis | Reason |
|----------|------|----------|--------|
| religion | 5.02 | 26.78 | Both criteria violated |
| worship | 4.73 | 20.35 | Both criteria violated |
| silent_conflict | -9.21 | 82.89 | Both criteria violated |
| runaway | -15.21 | 229.21 | Both criteria violated |
| kdrt | -24.24 | 585.50 | Both criteria violated |
| food_diverse | 5.34 | 26.47 | Both criteria violated |
| posyandu | -13.24 | 175.54 | Both criteria violated |
| bkb_prog | -12.52 | 164.15 | Both criteria violated |
| uupks_prog | -4.33 | 16.75 | Both criteria violated |
| pnm_prog | -5.06 | 23.65 | Both criteria violated |
| ngo_prog | -3.90 | 13.22 | Both criteria violated |
| roof | 2.58 | 15.79 | Both criteria violated |
| wall | 3.25 | 11.20 | Both criteria violated |
| sanitation | 2.76 | 7.04 | Both criteria violated |
| house_area | 4.07 | 23.01 | Both criteria violated |
| house_own | 3.94 | 15.01 | Both criteria violated |

### Excluded — Weak Inter-item Correlation (max|r|<.2)
| Variable | Max |r| |
|----------|---------|
| health_ins | 0.197 |
| illness | 0.068 |
| bkl_prog | 0.115 |
| pkh_prog | 0.197 |
| electricity | 0.162 |

### Excluded — Multicollinearity (|r|>.9)
| Variable | Correlated With | r |
|----------|----------------|---|
| marr_cert | marital | 0.903 |
| bed_sep | marital | 0.923 |
| income | dom_violence | 1.000 |
| pirkm_prog | bkr_prog | 0.951 |

### Excluded — No Factor Loading (loading<.3 on all factors)
| Variable |
|----------|
| age |
| social_part |
| water |
| dom_violence |
| savings |
