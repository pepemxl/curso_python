# Algoritmo de  Kadane

El **algoritmo de Kadane** es un método eficiente para encontrar el subarreglo contiguo con una propieda que maxima a ese subarreglo (suma).

## Como funciona?

El algoritmo recorre el arreglo una sola vez!, manteniendo una variable guarda el **máximo local(actual)** y el **máximo global** en cada paso. Para simplificar la explicación usaremos la suma.

De cierta manera construye un arbol de decisión donde cada decisión crea un máximo local ( máximo en esa decisión).

Dado un arreglo $[a_{1}, \ldots , a_{n}]$.

### 1. En el primer paso 

inizialicemos el maximo local y global a $a_{1}$.

### 2. En el segundo paso 

el maximo local seria tomar $a_{2}$ o no tomarlo bajo la siguiente regla

$$ maximo\_local_{2} := max{ (a_{2}, a_{2} + maximo\_local_{1} )}$$

aqui si $maximo\_local_{1}$ era negativo, quiere decir que no contribuye, por lo tanto, solo considerar $a_{2}$ maximiza en este punto.

### 3. En el tercer paso 

el maximo local seria tomar $a_{3}$ o no tomarlo bajo la siguiente regla

$$ maximo\_local_{3} := max{ (a_{3}, a_{3} + maximo\_local_{2} )}$$

aqui si $maximo\_local_{2}$ era negativo, quiere decir que no contribuye, por lo tanto, solo considerar $a_{3}$ maximiza en este punto, asi sucesivamente,

### k. En el paso k

el maximo local seria tomar $a_{k}$ o no tomarlo bajo la siguiente regla

$$ maximo\_local_{k} := max{ (a_{k}, a_{k} + maximo\_local_{k-1} )}$$

aqui si $maximo\_local_{k-1}$ era negativo, quiere decir que no contribuye, por lo tanto, solo considerar $a_{k}$ maximiza en este punto, y como tenemos un número finito termina en $n$.

Como no necesitamos recordar el maximo de cada paso anterior al previo podemos reusar nuestra variable.

## Ejemplo de maximizar una Suma

### Inicializar

- `suma_maxima_actual = arreglo[0]` (empieza con el primer elemento).
- `suma_maxima_global = arreglo[0]` (la máxima encontrada hasta ahora).

### Recorrer el arreglo (desde el segundo elemento hasta el final):

- Para cada elemento `arreglo[i]`, localizar `suma_maxima_local`:
    - `suma_maxima_local = max(arreglo[i], suma_maxima_local + arreglo[i])`.
    - Esto decide si es mejor empezar una nueva submatriz en `arreglo[i]` o continuar con la anterior.
- Actualizar `suma_maxima_global`:
    - `suma_maxima_global = max(suma_maxima_global, suma_maxima_local)`.

### Resultado

- Al final del recorrido, `suma_maxima_global` contendrá la suma máxima de cualquier subarreglo contiguo.

### Ejemplo

```python title="Ejemplo"
Arreglo: [-2, 1, -3, 4, -1, 2, 1, -5, 4]
```

```bash title="Paso a paso" linenums="1"
Inicio: suma_maxima_local = -2, suma_maxima_global = -2.
i=1: suma_maxima_local = max(1, -2 + 1) = 1, suma_maxima_global = max(-2, 1) = 1.
i=2: suma_maxima_local = max(-3, 1 - 3) = -2, suma_maxima_global = max(1, -2) = 1.
i=3: suma_maxima_local = max(4, -2 + 4) = 4, suma_maxima_global = max(1, 4) = 4.
i=4: suma_maxima_local = max(-1, 4 - 1) = 3, suma_maxima_global = max(4, 3) = 4.
i=5: suma_maxima_local = max(2, 3 + 2) = 5, suma_maxima_global = max(4, 5) = 5.
i=6: suma_maxima_local = max(1, 5 + 1) = 6, suma_maxima_global = max(5, 6) = 6.
i=7: suma_maxima_local = max(-5, 6 - 5) = 1, suma_maxima_global = max(6, 1) = 6.
i=8: suma_maxima_local = max(4, 1 + 4) = 5, suma_maxima_global = max(6, 5) = 6.

Resultado final: 6 (corresponde al subarreglo [4, -1, 2, 1]).
```


```python linenums="1" title="Ejemplo max suma"
def maxSubArray(self, nums)
    local_max = nums[0]
    global_max = nums[0]
    for i in range(1,  len(nums)):
        local_max = max(nums[i], nums[i]+local_max)
        global_max = max(global_max, local_max)
    return global_max
```


### Complejidad

- **Tiempo:** \(O(n)\) (solo un recorrido lineal).
- **Espacio:** \(O(1)\) (usa variables constantes).



## Suma Maxima en un subarreglo circular

Dado un arreglo $[a_{1}, \ldots , a_{n}]$. Queremos encontrar el sub arreglo de elementos contiguos que maximiza la suma, considerando tambien
subarreglos circulares, es decir, podemos considerar contiguos a $a_{n}$ con $a_{1}$ .

Por ejemplo, consideramos el arreglo $[3, -1, 2, -2, -1, 5]$, aquí el subarreglo ciruclar que maximiza la suma es: $[5, 3, -1, 2]$ .

Además de fuerza bruta, aqui se nos ocurren dos posibles aproximaciones

1. Usar indices para calcular cuando se debe actualizar o no el maximo local con kadane.
2. Calcular el subarray con suma maxima negativa.


### Indices

```python  
def maxSubarraySumCircular(self, nums: List[int]) -> int:
        n = len(nums)
        local_max = nums[0] # kadane maximizar subarreglo
        global_max = nums[0] # kadane maximizar subarreglo
        last_update_idx = 0 # last index used in local_max
        for i in range(1, 2*n):
            if i%n > last_update_idx:
                if nums[i%n] > nums[i%n]+local_max:
                    local_max = nums[i%n]
                    last_update_idx = i
                else:
                    local_max = nums[i%n]+local_max
                global_max = max(global_max, local_max)
        return global_max
```

### Mayor sub-arreglo con suma que maximiza la parte negativa

#### Explicación

Dado un arreglo $[a_{1}, \ldots , a_{n}]$. Tenemos 3 casos:

1. No existe negativos: Entonces el arreglo total maximiza la suma.
2. Todos son negativos: Para este caso no aplica la estrategia ya que el arreglo total maximizaría la suma negativa, sin embargo, una condición es que al menos hay un elemento en el subarreglo máximo. Por lo tanto para este caso la respuesta sería el elemento más grande, es decir, el número negativo con menor valor absoluto.
3. Tenemos positivos y negativos:
    - Encontramos que $[a_{i}, \ldots, a_{j}]$ maximiza la suma negativa donde $i <= j$. Por lo tanto el arreglo $[a_{j+1}, \ldots,a_{n}, a_{1}, \ldots,a_{i-1}]$ maximiza la suma positiva, el cual podemos encontrar como el complemento del primer arreglo.
    - Encontramos que $[a_{j}, \ldots,a_{n}, a_{1}, \ldots,a_{i}]$ maximiza la suma negativa. Por lo tanto el maximo es un subarreglo $[a_{i+1}, \ldots, a_{j-1}]$, el cual es el resultado de encontrar el maximo subarreglo contiguo sin usar la propiedad circular.


Son casi complementarios excepto por el caso 2, donde almenos debe haber un elemento.

$[1,-2,3,-2]$


#### Implementación

```python linenums="1" title="Solución"
class Solution:
    def maxSubarraySumCircular(self, nums: List[int]) -> int:
        menor = min(nums)
        if menor > 0: # Caso 1
            return sum(nums)
        mayor = max(nums)
        if mayor < 0: # Caso 2
            return mayor
        n = len(nums) # Caso 3
        local_max = nums[0] # kadane maximizar subarreglo
        global_max = nums[0] # kadane maximizar subarreglo
        local_min = nums[0] # kadane maximizar subarreglo
        global_min = nums[0] # kadane maximizar subarreglo
        for i in range(1, n):
            local_max = max(nums[i], local_max+nums[i])
            global_max = max(global_max, local_max)
            local_min = min(nums[i], local_min+nums[i])
            global_min = min(global_min, local_min)
        suma = sum(nums)
        res = max(global_max, suma-global_min)
        return res
```




## Subarreglo con producto máximo

Dado un array de enteros $[a_{1}, \ldots , a_{n}]$, encuentre un subarreglo que tenga el mayor producto y devuelva el producto.

Tenemos 3 casos:

1. No existe negativos: Entonces el arreglo total maximiza el producto.
2. Todos son negativos: Tenemos dos casos:
    - la cantidad es par: El producto de todos maximiza.
    - la cantidad es impar: El producto de todos entre el "mayor" maximiza el producto.
3. Todos son ceros: Entonces el resultado es 0.
4. Tenemos positivos, negativos y tal vez ceros: Los ceros vuelven el producto cero, por lo tanto el problema se vuelve recursivo

    $$maxProduct(a_{1}, a_{2}, \ldots, a_{k-1}, a_{k}=0,a_{k+1}, \ldots, a_{n} ) = $$

    $$max(max(maxProduct(a_{1}, a_{2}, \ldots, a_{k-1}), maxProduct(a_{k+1}, \ldots, a_{n})), 0)$$

En este caso a cada paso el signo del producto puede cambiar cambiando totalmente los resultados intermedios.




#### Implementación

```python linenums="1" title="Solución"
class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        if len(nums) == 0:
            return 0
        if len(nums) == 1:
            return nums[0]
        menor = min(nums)
        res = 1
        n = len(nums)
        if menor > 0: # caso 1
            for i in range(n):
                res *= nums[i]
            return res
        mayor = max(nums)
        if mayor < 0: # caso 2
            for i in range(n):
                res *= nums[i]
            if n%2:
                return max(res//nums[0], res//nums[n-1])
            else:
                return res
        if menor == 0 and mayor == 0: # caso 3
            return 0
        for i in range(n):
            if nums[i] == 0:
                if i > 0 and i < n-1:
                    return max(max(self.maxProduct(nums[:i]), self.maxProduct(nums[i+1:])), 0)
                if i == 0:
                    return max(self.maxProduct(nums[i+1:]), 0)
                if i == n-1:
                    return max(self.maxProduct(nums[:i]), 0)
        n_negativos = 0
        primero = 0
        ultimo = 0
        for i in range(n):
            if nums[i] < 0:
                n_negativos += 1
                if n_negativos == 1:
                    primero = i
                ultimo = i
        if n_negativos%2 == 0:
            for i in range(n):
                res *= nums[i]
            return res
        prod1 = 1
        prod2 = 1
        for i in range(0, ultimo):
            prod1 *= nums[i]
        for i in range(primero+1, n):
            prod2 *= nums[i]
        return max(prod1, prod2)
```

