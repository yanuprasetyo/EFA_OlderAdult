# Output Files

This folder contains outputs generated from the EFA analysis.

## Expected Outputs

| File | Description |
|------|-------------|
| `scree_plot.png` | Parallel analysis scree plot (Figure 2) |
| `factor_diagram.png` | Five-factor structure diagram (Figure 3) |
| `correlation_heatmap.png` | Inter-item correlation heatmap (Figure 1) |

## Key Results Summary

### Model Fit
| Index | Value | Threshold | Status |
|-------|-------|-----------|--------|
| RMSEA | 0.041 | < 0.05 | ✅ Good |
| TLI | 0.968 | > 0.95 | ✅ Good |
| Total Variance Explained | 54.7% | - | ✅ |
| KMO | 0.80 | > 0.50 | ✅ Good |

### Factor Structure
| Factor | Label | Items | ω |
|--------|-------|-------|---|
| ML4 | Family Engagement & Program Participation | 4 | 0.796 |
| ML1 | Social Interaction & Recreation | 2 | 0.865 |
| ML3 | Demographic Status | 2 | 0.879 |
| ML5 | Basic Living Conditions | 5 | 0.630 |
| ML2 | Information Access | 2 | 0.773 |

### Factor Intercorrelations
| | ML4 | ML1 | ML3 | ML5 | ML2 |
|--|-----|-----|-----|-----|-----|
| ML4 | 1.000 | 0.395 | 0.433 | 0.277 | 0.207 |
| ML1 | 0.395 | 1.000 | 0.523 | 0.239 | 0.229 |
| ML3 | 0.433 | 0.523 | 1.000 | 0.213 | 0.105 |
| ML5 | 0.277 | 0.239 | 0.213 | 1.000 | 0.303 |
| ML2 | 0.207 | 0.229 | 0.105 | 0.303 | 1.000 |
