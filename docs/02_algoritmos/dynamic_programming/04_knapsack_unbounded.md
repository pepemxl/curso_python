# Unbounded Knapsack

 La diferencia principal respecto al knapsack 1/0 es que se pueden tomar múltiples copias del mismo elemento.

 Se busca maximizar el valor total de objetos que se pueden colocar en una mochila con una capacidad limitada de peso \(W\), pero con la diferencia clave de que **se puede usar un número ilimitado de instancias de cada objeto**. Es decir, no hay restricción en la cantidad de veces que puedes tomar el mismo ítem, siempre y cuando no excedas el peso total.

Este problema es útil en escenarios como optimización de recursos, donde los ítems son reutilizables o infinitos en cantidad, como en el corte de varillas para maximizar ganancias o en el cambio de monedas para minimizar la cantidad (aunque en este último se minimiza, no maximiza).


## Cómo se resuelve???

Se utiliza una tabla de programación dinámica (DP) para construir la solución de manera bottom-up. 

### **Definiciones**

- Tenemos n ítems, cada uno con un peso \( w_i \) y un valor \( v_i \).
- La mochila tiene capacidad máxima W.
- Objetivo: Maximizar la suma de valores sin exceder W.

### **Inicialización**

- Crea un arreglo DP de tamaño W+1, donde `dp[j]` representa el valor máximo que se puede obtener con una capacidad exacta de j.
- Inicializa `dp[0] = 0` (con capacidad 0, valor 0).
- El resto de `dp[j]` se inicializa en 0 (o en -infinito si se quiere estrictamente, pero 0 funciona para valores no negativos).

### **Llenado de la tabla DP**

- Para cada ítem i (de 1 a n):
    - Para cada capacidad j desde \( w_i \) hasta W:
    - Actualiza `dp[j] = max(dp[j], dp[j - w_i] + v_i)`
- Esto considera tomar 0 o más instancias del ítem i para cada capacidad j.
- El orden es importante: iteramos por ítems primero y luego por capacidades, permitiendo reutilizar el ítem en la misma fila.

### **Resultado**
- El valor máximo está en `dp[W]`.

La complejidad temporal es O(n * W), lo que lo hace eficiente para valores moderados de W.

```python title="Pseudocodigo"
dp = [0] * (W + 1)

for i in range(n):
    for j in range(w[i], W+1):
        dp[j] = max(dp[j], dp[j - w[i]] + v[i])
```

Esto difiere del 0/1 Knapsack, donde no se permite reutilizar ítems y se itera en orden inverso para evitar reutilización.

## Ejemplo el cambio

Se le proporciona una matriz de enteros "monedas" que representa monedas de diferentes denominaciones y una cantidad entera que representa la cantidad total de dinero.

Devuelva la menor cantidad de monedas que necesite para completar esa cantidad. Si ninguna combinación de monedas puede completar esa cantidad, devuelva -1.

Puede asumir que tiene una cantidad infinita de cada tipo de moneda.

```python title="Solución no eficiente" linenums="1"
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        n = len(coins)

        def dfs(idx, amount):
            if amount == 0:
                return 0
            if idx < n and amount > 0:
                min_cost = float('inf')
                for x in range(0, amount // coins[idx] + 1):
                    res = dfs(idx + 1, amount-x*coins[idx])
                    if res != -1:
                        min_cost = min(min_cost, res + x)
                return -1 if min_cost == float('inf') else min_cost
            return -1

        return dfs(0, amount)
```

```python title="Solucion Top-Down" linenums="1"
from functools import lru_cache


class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:

        @lru_cache(None)
        def dfs(rem):
            if rem < 0:
                return -1
            if rem == 0:
                return 0
            min_cost = float('inf')
            for coin in coins:
                res = dfs(rem - coin)
                if res != -1:
                    min_cost = min(min_cost, res + 1)
            return min_cost if min_cost != float('inf') else -1

        return dfs(amount)

```


```python title="Solucion Bottom-Up" linenums="1"
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        dp = [float('inf')] * (amount + 1)
        dp[0] = 0
        for coin in coins:
            for x in range(coin, amount + 1):
                dp[x] = min(dp[x], dp[x - coin] + 1)
        return dp[amount] if dp[amount] != float('inf') else -1 

```