Below is the fully filled FCC truth table, using  

- **Prev = 00 (ET)** ⇒ compare (ai, bi) via HCC  
- **Prev = 01 (LT)** ⇒ propagate LT = 01  
- **Prev = 10 (GT)** ⇒ propagate GT = 10  
- **Prev = 11 (unused)** ⇒ remain 11  

| ai | bi | Oᵢ₋₁,₁  | Oᵢ₋₁,₂  | Oᵢ,₁  | Oᵢ,₂  |
|----|----|---------|---------|-------|-------|
|  0 |  0 |   0     |   0     |  0    |  0    |
|  0 |  0 |   0     |   1     |  0    |  1    |
|  0 |  0 |   1     |   0     |  1    |  0    |
|  0 |  0 |   1     |   1     |  1    |  1    |
|  0 |  1 |   0     |   0     |  0    |  1    |
|  0 |  1 |   0     |   1     |  0    |  1    |
|  0 |  1 |   1     |   0     |  1    |  0    |
|  0 |  1 |   1     |   1     |  1    |  1    |
|  1 |  0 |   0     |   0     |  1    |  0    |
|  1 |  0 |   0     |   1     |  0    |  1    |
|  1 |  0 |   1     |   0     |  1    |  0    |
|  1 |  0 |   1     |   1     |  1    |  1    |
|  1 |  1 |   0     |   0     |  0    |  0    |
|  1 |  1 |   0     |   1     |  0    |  1    |
|  1 |  1 |   1     |   0     |  1    |  0    |
|  1 |  1 |   1     |   1     |  1    |  1    | 

Below are 4-variable Karnaugh maps for Oᵢ,₁ and Oᵢ,₂, with inputs A = aᵢ, B = bᵢ, P₁ = Oᵢ₋₁,₁ and P₂ = Oᵢ₋₁,₂. We use Gray-coded axes:

```
        AB →
       00  01  11  10
P₁P₂ ↓
00     ●   ●   ●   ●
01     ●   ●   ●   ●
11     ●   ●   ●   ●
10     ●   ●   ●   ●
```


Fill in “1” or “0” per the FCC truth table (citation needed).

---

### K-map for Oᵢ,₁

| P₁P₂ \ AB | 00 | 01 | 11 | 10 |
|:---------:|:--:|:--:|:--:|:--:|
| **00**    | 0  | 0  | 0  | 1  |
| **01**    | 0  | 0  | 0  | 0  |
| **11**    | 1  | 1  | 1  | 1  |
| **10**    | 1  | 1  | 1  | 1  |

#### Groupings:
1. **8-cell block** covering rows 11 & 10 (all four columns) ⇒ P₁ = 1
2. **2-cell block** at column 10 (AB = 10), rows 00 & 10 ⇒ P₂ = 0, A = 1, B = 0 ⇒ ¬P₂ · A · ¬B

**SOP** →  
```math
O_{i,1} = P_{1} + \bar{P}_{2} \cdot A \cdot \bar{B}
```
---

### K-map for Oᵢ,₂

| P₁P₂ \ AB | 00 | 01 | 11 | 10 |
|:---------:|:--:|:--:|:--:|:--:|
| **00**    | 0  | 1  | 0  | 0  |
| **01**    | 1  | 1  | 1  | 1  |
| **11**    | 1  | 1  | 1  | 1  |
| **10**    | 0  | 0  | 0  | 0  |

#### Groupings:
1. **8-cell block** covering rows 01 & 11 (all columns) ⇒ P₂ = 1
2. **2-cell block** at column 01 (AB = 01), rows 00 & 01 ⇒ P₁ = 0, A = 0, B = 1 ⇒ ¬P₁ · ¬A · B

**SOP** →  
```math
O_{i,2} = P_{2} + \bar{P}_{1} \cdot \bar{A} \cdot B
```
---

## Final Simplified Sum-of-Products

The final simplified expressions for Oᵢ,₁ and Oᵢ,₂ are:

```math
\boxed{
\begin{aligned}
O_{i,1} &= P_{1} + \bar{P}_{2} \cdot A \cdot \bar{B}, \\
O_{i,2} &= P_{2} + \bar{P}_{1} \cdot \bar{A} \cdot B.
\end{aligned}
}
```
---