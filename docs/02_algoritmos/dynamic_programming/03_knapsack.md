# 0/1 Knapsack

El **problema de la mochila (Knapsack Problem)**: dado un conjunto de elementos, cada uno con un **peso** y un **valor**, debemos seleccionar una combinación de ellos para maximizar el valor total sin exceder una **capacidad máxima de peso** (la capacidad de la mochila).

Aqui hay varias versiones, el 0/1 es cuando cada elemento se puede tomar o no, pero no se permiten fracciones, ni repetidos.

## Definición

### Datos de entrada

- Un arreglo de pesos `w[1..n]`.
- Un arreglo de valores `v[1..n]`.
- Una capacidad máxima `W`.

### Objetivo

- Maximizar \( \sum_{i} v_i \cdot x_i \), donde \( x_i \in \{0,1\} \) (tomar o no el elemento).
- Con la restricción de que \( \sum_{i} w_i \cdot x_i \leq W \).

## Solución con Programación Dinámica (DP)

Usamos un arreglo bidimensional(una tabla) `dp[n+1][W+1]` donde `dp[i][j]` = valor máximo que se puede obtener con los primeros `i` elementos y capacidad `j`.

### Relación de recurrencia

  \[
  dp[i][j] = 
  \begin{cases} 
  dp[i-1][j] & \text{si } w[i] > j \text{ (no cabe)} \\
  \max(dp[i-1][j], v[i] + dp[i-1][j-w[i]]) & \text{si } w[i] \leq j \text{ (cabe)}
  \end{cases}
  \]

### Inicialización

- `dp[0][j] = 0` (sin elementos, valor = 0).
- `dp[i][0] = 0` (capacidad 0, valor = 0).

```python linenums="1" title="Pseudocódigo"
def knapsack_01(W, wt, val, n):
    dp = [[0] * (W + 1) for _ in range(n + 1)]
    for i in range(1, n + 1):
        for j in range(1, W + 1):
            if wt[i-1] <= j:
                dp[i][j] = max(val[i-1] + dp[i-1][j - wt[i-1]], dp[i-1][j])
            else:
                dp[i][j] = dp[i-1][j]
    return dp[n][W]
```

## Ejemplo

- **Elementos**:
  - `val = [60, 100, 120]` (valores).
  - `wt = [10, 20, 30]` (pesos).
  - `W = 50` (capacidad máxima).
- **Solución óptima**:
  - Tomar los elementos con `val = 100` y `val = 120` (peso total = 50, valor total = 220).

## Complejidad

- **Tiempo**: \(O(n \cdot W)\)
- **Espacio**: \(O(n \cdot W)\) (optimizable a \(O(W)\)).

