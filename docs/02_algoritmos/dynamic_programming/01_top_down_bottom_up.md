# Top-Down Bottom-Up


Tenemos dos técnicas para implementar un DP.

1. Bottom-up, llamada usualmente tabulación.
2. Top-Down, llamada usualmente memoización.

## Bottom-up (Tabulación)

Bottom-up es implementada usando iteraciones sobre un caso base. 

El método ascendente se implementa con iteración y comienza en los casos base. Usemos nuevamente la secuencia de Fibonacci como ejemplo. Los casos base para la secuencia de Fibonacci son $F(0) = 0$ y $F(1)=1$. Con el método ascendente, usaríamos estos casos base para calcular
$F(2)$, y luego usaríamos ese resultado para calcular
$F(3)$, y así sucesivamente hasta $F(n)$.


```bash
F = array of length (n + 1)
F[0] = 0
F[1] = 1
for i from 2 to n:
    F[i] = F[i - 1] + F[i - 2]
```

## Top-down (Memoization)

El método de arriba hacia abajo (top-down) se implementa con recursión y se vuelve eficiente con memoización que es el termine usado en lenguajes de programación para referirse a un tipo de memorización. Si quisiéramos encontrar el $n-$esimo número de Fibonacci $F(n)$, intentamos calcularlo encontrando $F(n−1)$ y $F(n−2)$. Esto define un patrón recursivo que continuará hasta que alcancemos los casos base

$$ F(0) = F (1) = 1$$

El problema con implementarlo recursivamente es que hay una gran cantidad de cálculos repetidos innecesarios. Eche un vistazo al árbol de recursión si tuviéramos que encontrar $F(5)$:
