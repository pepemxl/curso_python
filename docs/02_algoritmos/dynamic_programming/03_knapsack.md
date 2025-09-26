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

## Soluciones

### Relación de recurrencia

\[
dp[i][j] = 
\begin{cases} 
dp[i-1][j] & \text{si } w[i] > j \text{ (no cabe)} \\
\max(dp[i-1][j], v[i] + dp[i-1][j-w[i]]) & \text{si } w[i] \leq j \text{ (cabe)}
\end{cases}
\]


```python title="Solución Recursiva" linenums="1"
def knapsack_brute_force(capacity, n):
    if n == 0 or capacity == 0:
        return 0
    elif weights[n-1] > capacity:
        return knapsack_brute_force(capacity, n-1)
    else:
        include_item = values[n-1] + knapsack_brute_force(capacity-weights[n-1], n-1)
        exclude_item = knapsack_brute_force(capacity, n-1)
        return max(include_item, exclude_item)  
```
usualmente escribimos solo `max(values[n-1] + knapsack_brute_force(capacity-weights[n-1], n-1), knapsack_brute_force(capacity, n-1))` usamos `include_item` y `exclude_item` para que sea más claro.

```python title="Solución Recursiva con Memoización  (top-down)" linenums="1"
def knapsack_memoization(capacity, n):
    if memo[n][capacity] is not None:
        return memo[n][capacity]
    if n == 0 or capacity == 0:
        result = 0
    elif weights[n-1] > capacity:
        result = knapsack_memoization(capacity, n-1)
    else:
        include_item = values[n-1] + knapsack_memoization(capacity-weights[n-1], n-1)
        exclude_item = knapsack_memoization(capacity, n-1)
        result = max(include_item, exclude_item)
    memo[n][capacity] = result
    return result
```

```python title="Tabulación  (bottom-up)" linenums="1"
def knapsack_tabulation():
    n = len(values)
    tab = [[0]*(capacity + 1) for y in range(n + 1)]
    for i in range(1, n+1):
        for w in range(1, capacity+1):
            if weights[i-1] <= w:
                include_item = values[i-1] + tab[i-1][w-weights[i-1]]
                exclude_item = tab[i-1][w]
                tab[i][w] = max(include_item, exclude_item)
            else:
                tab[i][w] = tab[i-1][w]
    return tab[n][capacity]
```

### Solución con Programación Dinámica (Bottom-Up) Optimizada

Usamos un arreglo bidimensional(una tabla) `dp[n+1][W+1]` donde `dp[i][j]` = valor máximo que se puede obtener con los primeros `i` elementos y capacidad `j`.


### Inicialización

Hay que tener cuidado con la inicialización

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

### Complejidad

- **Tiempo**: \(O(n \cdot W)\)
- **Espacio**: \(O(n \cdot W)\) (optimizable a \(O(W)\)).


## Problema Partition Equal Subset Sum

Dada una matriz de enteros nums, devuelve verdadero si puedes particionar la matriz en dos subconjuntos de modo que la suma de los elementos en ambos subconjuntos sea igual o falso en caso contrario.

### Solución ineficiente

```python title="Solucion" linenums="1"
class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        # bfs => x^200 which is not feasible then we will use memoization in a dfs
        suma = sum(nums)
        if suma%2: 
            return False
        n = len(nums)
        target = suma // 2
        self.memo = {}
        def dfs_target(nums: Tuple[int], n: int, target: int) -> bool:
            if (n, target) in self.memo:
                return self.memo[(n, target)]
            result = False
            if target == 0:
                self.memo[(n, target)] = True
                return True
            if n == 0 or target < 0:
                self.memo[(n, target)] = False
                return False
            result = dfs_target(nums, n-1, target-nums[n-1]) or dfs_target(nums, n-1, target)
            self.memo[(n, target)] = result
            return result
        return dfs_target(tuple(nums), n-1, target)
```

### Solución Bottom-Up


```python
class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        suma = sum(nums)
        if suma%2: 
            return False
        n = len(nums)
        target = suma // 2
        dp = [[0]*(target+1) for i in range(n+1)]
        dp[0][0] = 1
        for i in range(1, n+1):
            current = nums[i-1]
            for j in range(target+1):
                if j < current:
                    dp[i][j] = dp[i-1][j]
                else:
                    if dp[i-1][j] > 0 or dp[i-1][j-current] > 0:
                        dp[i][j] = 1
                    else:
                        dp[i][j] = 0
            if dp[n][target]:
                return True
            else:
                return False
```
