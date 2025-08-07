# Secuencia de Fibonacci


El patrón de la secuencia de Fibonacci es útil cuando **la solución de un problema depende de las soluciones de instancias más pequeñas del mismo problema.**

Sabremosq ue habra que usar esta técnica si existe una relación recursiva, que se asemeje a la secuencia de Fibonacci:

$$ F(n) = F(n-1) + F(n-2)$$

Veamos un par de problemas cuya solución es similar a la de fibonacci.

- Fibonacci Number
- Climbing Stairs
- Min Cost Climbing Stairs

## Fibonacci Number

Los números de Fibonacci, comúnmente denotados por $f(n)$, forman una secuencia, llamada secuencia de Fibonacci, tal que cada número es la suma de los dos anteriores, comenzando por 0 y 1. Es decir,

$$ f(0) = 0$$

$$ f(1) = 1 $$

$$ f(n) = f(n - 1) + f(n - 2), para \,n > 1 $$

Dado un entero positivo $n$, calcula $f(n)$.



```python linenums="1" title="Solución Recursiva"
class Solution:
    def fib(n: int) -> int:
        if n==0:  # caso base
            return 0
        if n == 1:  # caso base
            return 1
        return fib(n-1) + fib(n-2)
```



## Maneras de subir una escalera

Estás subiendo una escalera, en la cual se necesitan $n$ escalones para llegar arriba. Cada vez puedes subir 1 o 2 escalones. ¿De cuántas maneras distintas puedes subir?

Con la restricción de que $1 \leq n \leq 45$.


Una secuencia de pasos $a_{1}, \ldots, a_{m}$ donde $a_{i}$ es uno o dos, esto es, se subieron uno o dos pasos, es decir, 

$$\sum_{i=1}^{m}a_{i} = n$$

Una solución sencilla es usar el poder de la recursión para generar todas las posibles secuencias.

1. El paso $k$ generara dos casos dependiendo de si la suma es menor que n o no, con esta construcción nos aseguramos de considerar todas las posibilidades y además evitamos duplicados.


$$a_{1},\ldots, a_{k} = b_{1},\ldots, b_{k} \Rightarrow a_{i} = b_{i}$$


Aqui es donde aplicamos la misma técnica de fibonacci para contar de cuantas maneras podemos realizar los $n$ pasos.

Desde el paso 0, tenemos dos opciones, avanzar al escalon 1 o al 2. Por lo tanto, el número de combinaciones desde 0 es igual a la suma del número de combinaciones desde 1 y desde 2.

$$f(0) = f(1) + f(2)$$

con lo cual nuestra regla recursiva es:

$$f(i) = f(i+1) + f(i+2)$$

Sin embargo, la complejidad de este algoritmo es $2^{n}$, por lo cual lo mas sensato es usar una tecnica de memorización de los pasos previamente calculados, a esto se le conocea en informatica como memoización, en otros lenguajes se le conoce como tabulación.



```python linenums="1" title="Solución Recursiva"
class Solution:
    def recursion(self, n: int, current_step: int) -> int:
        if current_step in self.memo:
            return self.memo[current_step]
        if current_step > n:
            self.memo[current_step] = 0
            return 0
        if current_step == n:
            self.memo[current_step] = 1
            return 1
        self.memo[current_step] = self.recursion(n, current_step+1) + self.recursion(n, current_step+2)
        return self.memo[current_step]

    def climbStairs(self, n: int) -> int:
        self.memo = {}
        res = self.recursion(n, 0)
        return res
```







