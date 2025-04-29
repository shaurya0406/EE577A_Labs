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
|  0 |  1 |   1     |   0     |  0    |  1    |
|  0 |  1 |   1     |   1     |  1    |  1    |
|  1 |  0 |   0     |   0     |  1    |  0    |
|  1 |  0 |   0     |   1     |  1    |  0    |
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

| AB \ P₁P₂ | 00 | 01 | 11 | 10 |
|:---------:|:--:|:--:|:--:|:--:|
| **00**    | 0  | 0  | 1  | 1  |
| **01**    | 0  | 0  | 1  | 0  |
| **11**    | 0  | 0  | 1  | 1  |
| **10**    | 1  | 0  | 1  | 1  |

**SOP** →  
```math
O_{i,1} \;=\; B'\,P_1 \;+\; P_1\,P_2 \;+\; A\,B' \;+\; A\,P_1
```
---

### K-map for Oᵢ,₂

| AB \ P₁P₂ | 00 | 01 | 11 | 10 |
|:---------:|:--:|:--:|:--:|:--:|
| **00**    | 0  | 1  | 1  | 0  |
| **01**    | 1  | 1  | 1  | 1  |
| **11**    | 0  | 1  | 1  | 0  |
| **10**    | 0  | 0  | 1  | 0  |

**SOP** →  
```math
O_{i,2} = A'\,P_2 \;+\; P_1\,P_2 \;+\; A'\,B \;+\; B\,P_2
```
---

## Final Simplified Sum-of-Products

The final simplified expressions for Oᵢ,₁ and Oᵢ,₂ are:

```math
\boxed{
\begin{aligned}
O_{i,1} \;=\; B'\,P_1 \;+\; P_1\,P_2 \;+\; A\,B' \;+\; A\,P_1,\\
O_{i,2} = A'\,P_2 \;+\; P_1\,P_2 \;+\; A'\,B \;+\; B\,P_2.
\end{aligned}
}
```
---

## CMOS Standard Gate Implementation
---

### 1. Oi,1
```math
\boxed{
\begin{aligned}
O_{i,1} \;=\; B'\,P_1 \;+\; P_1\,P_2 \;+\; A\,B' \;+\; A\,P_1
\end{aligned}
}
```

Below is a pure‐NAND/INV implementation of  
\[
O_{i,1} \;=\; B'\,P_{1}\;+\;P_{1}\,P_{2}\;+\;A\,B'\;+\;A\,P_{1}
\]  
using De Morgan’s law to turn the OR-of-products into a single NAND-of-NANDs.

---

### 1.  apply De Morgan

\[
\begin{aligned}
O 
&= T_{1}+T_{2}+T_{3}+T_{4}
\qquad\text{where }
\begin{cases}
T_{1}=B'\,P_{1},\\
T_{2}=P_{1}\,P_{2},\\
T_{3}=A\,B',\\
T_{4}=A\,P_{1}.
\end{cases}\\
%
&=\;\bigl(T_{1}+T_{2}+T_{3}+T_{4}\bigr)\\
&=\;\bigl(T_{1}'\,T_{2}'\,T_{3}'\,T_{4}'\bigr)' 
\quad\bigl[\,(X+Y+Z+W)'=X'\,Y'\,Z'\,W'\bigr]\\
&=\;\text{NAND}\!\bigl(T_{1}',T_{2}',T_{3}',T_{4}'\bigr).
\end{aligned}
\]

And each \(T_i'\) is just a 2-input NAND:

\[
\begin{aligned}
T_{1}' &= (B'\,P_{1})' = \mathrm{NAND}(B',\,P_{1})\\
T_{2}' &= (P_{1}\,P_{2})' = \mathrm{NAND}(P_{1},\,P_{2})\\
T_{3}' &= (A\,B')' = \mathrm{NAND}(A,\,B')\\
T_{4}' &= (A\,P_{1})' = \mathrm{NAND}(A,\,P_{1}).
\end{aligned}
\]

---

### 2.  gate-level network


- **Step 1:** Invert \(B\) to get \(B'\) (1 × INV).  
- **Step 2:** Build the four NANDs  
  \[
    T_1'=\mathrm{NAND}(B',P_1),\;
    T_2'=\mathrm{NAND}(P_1,P_2),\;
    T_3'=\mathrm{NAND}(A,B'),\;
    T_4'=\mathrm{NAND}(A,P_1).
  \]
- **Step 3:** Feed \(T_1'\), \(T_2'\), \(T_3'\), \(T_4'\) into a 4-input NAND  
  <!-- \(\;O = \mathrm{NAND}(T_1',T_2',T_3',T_4')\),  
  which by De Morgan is exactly the OR of the four original products.

Using only 2-input NANDs, we can tree them:

1. \(U = \mathrm{NAND}(T_1',T_2') = T_1 + T_2\).  
2. \(V = \mathrm{NAND}(T_3',T_4') = T_3 + T_4\).  
3. \(O = \mathrm{NAND}(U,V) = U + V = T_1+T_2+T_3+T_4.\)

Either way, you end up with a pure NAND+INV realization of your SOP.


### 2. Oi,2

```math
\boxed{
\begin{aligned}
O_{i,2} = A'\,P_2 \;+\; P_1\,P_2 \;+\; A'\,B \;+\; B\,P_2
\end{aligned}
}
```

