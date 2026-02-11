# Lazy Segment Tree

## Concepto Básico

El **Lazy Segment Tree** (Árbol de Segmentos Perezoso) es una estructura de datos que permite realizar consultas y actualizaciones en intervalos de un arreglo de manera eficiente (O(log n)).

La idea principal es **posponer las actualizaciones** hasta que sean realmente necesarias, evitando operaciones innecesarias.

## Comparación con Segment Tree Normal

| **Segment Tree Normal** | **Lazy Segment Tree** |
|------------------------|----------------------|
| Actualiza un elemento: O(log n) | Actualiza un intervalo: O(log n) |
| Actualiza intervalo: O(n log n) | Actualiza intervalo: O(log n) |
| Consulta intervalo: O(log n) | Consulta intervalo: O(log n) |
| Sin propagación diferida | Con propagación diferida |

## Estructura

- **Nodo**: Almacena información del intervalo (suma, mínimo, máximo, etc.)
- **Lazy Propagation**: Almacena actualizaciones pendientes para propagar a hijos
- **Propagación**: Cuando visitamos un nodo, aplicamos actualizaciones pendientes

## Operaciones Principales

1. **Build**: Construir el árbol a partir del arreglo original
2. **Update**: Actualizar un intervalo con un valor
3. **Query**: Consultar información de un intervalo
4. **Propagate**: Propagación perezosa de actualizaciones

## Implementación en Python

```python
class LazySegmentTree:
    def __init__(self, data):
        """
        Inicializa el Lazy Segment Tree.
        data: arreglo de números
        """
        self.n = len(data)
        # Tamaño del árbol: 4*n es suficiente
        self.size = 4 * self.n
        self.tree = [0] * self.size  # Árbol para almacenar sumas
        self.lazy = [0] * self.size  # Árbol para almacenar actualizaciones pendientes
        self.build(data, 1, 0, self.n - 1)
    
    def build(self, data, node, left, right):
        """Construye el árbol recursivamente"""
        if left == right:
            # Nodo hoja
            self.tree[node] = data[left]
            return
        
        mid = (left + right) // 2
        # Construir hijos izquierdo y derecho
        self.build(data, node * 2, left, mid)
        self.build(data, node * 2 + 1, mid + 1, right)
        
        # Actualizar nodo actual con la suma de hijos
        self.tree[node] = self.tree[node * 2] + self.tree[node * 2 + 1]
    
    def propagate(self, node, left, right):
        """Propaga actualizaciones pendientes a los hijos"""
        if self.lazy[node] != 0:
            # Aplicar actualización pendiente al nodo actual
            self.tree[node] += self.lazy[node] * (right - left + 1)
            
            # Si no es hoja, marcar hijos con actualizaciones pendientes
            if left != right:
                self.lazy[node * 2] += self.lazy[node]
                self.lazy[node * 2 + 1] += self.lazy[node]
            
            # Limpiar actualización pendiente del nodo actual
            self.lazy[node] = 0
    
    def update_range(self, qleft, qright, value):
        """Actualiza un intervalo [qleft, qright] sumando 'value' a cada elemento"""
        self._update_range(1, 0, self.n - 1, qleft, qright, value)
    
    def _update_range(self, node, left, right, qleft, qright, value):
        """Método interno recursivo para actualizar intervalo"""
        # Propagar actualizaciones pendientes
        self.propagate(node, left, right)
        
        # Caso 1: Intervalo completamente fuera
        if qleft > right or qright < left:
            return
        
        # Caso 2: Intervalo completamente dentro
        if qleft <= left and right <= qright:
            # Marcar con actualización pendiente
            self.lazy[node] += value
            self.propagate(node, left, right)
            return
        
        # Caso 3: Intervalo parcialmente cubierto
        mid = (left + right) // 2
        self._update_range(node * 2, left, mid, qleft, qright, value)
        self._update_range(node * 2 + 1, mid + 1, right, qleft, qright, value)
        
        # Actualizar nodo actual con la suma de hijos
        self.tree[node] = self.tree[node * 2] + self.tree[node * 2 + 1]
    
    def query_range(self, qleft, qright):
        """Consulta la suma del intervalo [qleft, qright]"""
        return self._query_range(1, 0, self.n - 1, qleft, qright)
    
    def _query_range(self, node, left, right, qleft, qright):
        """Método interno recursivo para consultar intervalo"""
        # Propagar actualizaciones pendientes
        self.propagate(node, left, right)
        
        # Caso 1: Intervalo completamente fuera
        if qleft > right or qright < left:
            return 0
        
        # Caso 2: Intervalo completamente dentro
        if qleft <= left and right <= qright:
            return self.tree[node]
        
        # Caso 3: Intervalo parcialmente cubierto
        mid = (left + right) // 2
        left_sum = self._query_range(node * 2, left, mid, qleft, qright)
        right_sum = self._query_range(node * 2 + 1, mid + 1, right, qleft, qright)
        
        return left_sum + right_sum
    
    def get_array(self):
        """Devuelve el arreglo actual reconstruido"""
        result = [0] * self.n
        self._get_array(1, 0, self.n - 1, result)
        return result
    
    def _get_array(self, node, left, right, result):
        """Método interno para reconstruir el arreglo"""
        self.propagate(node, left, right)
        
        if left == right:
            result[left] = self.tree[node]
            return
        
        mid = (left + right) // 2
        self._get_array(node * 2, left, mid, result)
        self._get_array(node * 2 + 1, mid + 1, right, result)


# Ejemplo de uso
def ejemplo_completo():
    print("=== EJEMPLO DE LAZY SEGMENT TREE ===\n")
    
    # Arreglo inicial
    arr = [1, 2, 3, 4, 5, 6, 7, 8]
    print(f"Arreglo original: {arr}")
    
    # Construir árbol
    seg_tree = LazySegmentTree(arr)
    print("Árbol construido")
    
    # Consulta 1: Suma del intervalo [2, 5]
    suma1 = seg_tree.query_range(2, 5)
    print(f"\nSuma del intervalo [2, 5]: {suma1}")
    print(f"  (3 + 4 + 5 + 6 = {suma1})")
    
    # Actualización 1: Sumar 10 al intervalo [1, 4]
    print(f"\nActualización: sumar 10 al intervalo [1, 4]")
    seg_tree.update_range(1, 4, 10)
    
    # Consulta 2: Suma del intervalo [0, 3] después de actualización
    suma2 = seg_tree.query_range(0, 3)
    print(f"Suma del intervalo [0, 3] después de actualización: {suma2}")
    print(f"  (1 + (2+10) + (3+10) + (4+10) = {suma2})")
    
    # Consulta 3: Suma del intervalo [4, 7] (parcialmente afectado)
    suma3 = seg_tree.query_range(4, 7)
    print(f"Suma del intervalo [4, 7]: {suma3}")
    print(f"  ((5+10) + 6 + 7 + 8 = {suma3})")
    
    # Reconstruir arreglo actual
    arr_actual = seg_tree.get_array()
    print(f"\nArreglo actual: {arr_actual}")
    
    # Actualización 2: Sumar 5 al intervalo [3, 6]
    print(f"\nActualización: sumar 5 al intervalo [3, 6]")
    seg_tree.update_range(3, 6, 5)
    
    # Consulta 4: Suma del intervalo [2, 5] después de segunda actualización
    suma4 = seg_tree.query_range(2, 5)
    print(f"Suma del intervalo [2, 5]: {suma4}")
    print(f"  ((3+10) + (4+10+5) + (5+10+5) + (6+5) = {suma4})")
    
    # Arreglo final
    arr_final = seg_tree.get_array()
    print(f"\nArreglo final: {arr_final}")
    
    print("\n=== FIN DEL EJEMPLO ===")


# Ejemplo con operaciones de mínimo
class LazySegmentTreeMin:
    """Lazy Segment Tree para operaciones de mínimo"""
    
    def __init__(self, data):
        self.n = len(data)
        self.size = 4 * self.n
        self.tree = [float('inf')] * self.size  # Para mínimos
        self.lazy = [0] * self.size
        self.build(data, 1, 0, self.n - 1)
    
    def build(self, data, node, left, right):
        if left == right:
            self.tree[node] = data[left]
            return
        
        mid = (left + right) // 2
        self.build(data, node * 2, left, mid)
        self.build(data, node * 2 + 1, mid + 1, right)
        self.tree[node] = min(self.tree[node * 2], self.tree[node * 2 + 1])
    
    def propagate(self, node, left, right):
        if self.lazy[node] != 0:
            # Para mínimo, sumamos el valor lazy al nodo
            self.tree[node] += self.lazy[node]
            
            if left != right:
                self.lazy[node * 2] += self.lazy[node]
                self.lazy[node * 2 + 1] += self.lazy[node]
            
            self.lazy[node] = 0
    
    def update_range(self, qleft, qright, value):
        self._update_range(1, 0, self.n - 1, qleft, qright, value)
    
    def _update_range(self, node, left, right, qleft, qright, value):
        self.propagate(node, left, right)
        
        if qleft > right or qright < left:
            return
        
        if qleft <= left and right <= qright:
            self.lazy[node] += value
            self.propagate(node, left, right)
            return
        
        mid = (left + right) // 2
        self._update_range(node * 2, left, mid, qleft, qright, value)
        self._update_range(node * 2 + 1, mid + 1, right, qleft, qright, value)
        self.tree[node] = min(self.tree[node * 2], self.tree[node * 2 + 1])
    
    def query_range(self, qleft, qright):
        return self._query_range(1, 0, self.n - 1, qleft, qright)
    
    def _query_range(self, node, left, right, qleft, qright):
        self.propagate(node, left, right)
        
        if qleft > right or qright < left:
            return float('inf')
        
        if qleft <= left and right <= qright:
            return self.tree[node]
        
        mid = (left + right) // 2
        left_min = self._query_range(node * 2, left, mid, qleft, qright)
        right_min = self._query_range(node * 2 + 1, mid + 1, right, qleft, qright)
        return min(left_min, right_min)


def ejemplo_minimo():
    print("\n\n=== EJEMPLO CON OPERACIONES DE MÍNIMO ===")
    
    arr = [5, 3, 7, 2, 8, 1, 4, 6]
    print(f"Arreglo original: {arr}")
    
    seg_min = LazySegmentTreeMin(arr)
    
    # Consultar mínimo en [2, 5]
    min1 = seg_min.query_range(2, 5)
    print(f"\nMínimo en intervalo [2, 5]: {min1}")
    print(f"  (mínimo de [7, 2, 8, 1] = {min1})")
    
    # Sumar 4 al intervalo [1, 4]
    print(f"\nActualización: sumar 4 al intervalo [1, 4]")
    seg_min.update_range(1, 4, 4)
    
    # Consultar mínimo en [0, 3]
    min2 = seg_min.query_range(0, 3)
    print(f"Mínimo en intervalo [0, 3] después de actualización: {min2}")
    print(f"  (mínimo de [5, 3+4, 7+4, 2+4] = {min2})")


if __name__ == "__main__":
    ejemplo_completo()
    ejemplo_minimo()
```

## Explicación del Ejemplo

El código muestra:

1. **Estructura básica**: Implementación de Lazy Segment Tree para sumas
2. **Operaciones**:
   - `update_range`: Actualiza un intervalo sumando un valor
   - `query_range`: Consulta la suma de un intervalo
   - `propagate`: Propaga actualizaciones pendientes
3. **Ejemplo concreto**: Demostración paso a paso con un arreglo
4. **Extensión para mínimo**: Implementación para operaciones de mínimo

## Complejidad Temporal

| Operación | Complejidad |
|-----------|-------------|
| Construcción | O(n) |
| Actualización de intervalo | O(log n) |
| Consulta de intervalo | O(log n) |
| Actualización de punto | O(log n) |
| Consulta de punto | O(log n) |

## Casos de Uso Típicos

1. **Problemas con actualizaciones por intervalo**: Sumar/restar a todos los elementos de un intervalo
2. **Sistemas de rangos**: Asignar valores a intervalos
3. **Problemas de consulta**: Encontrar suma/mínimo/máximo en intervalos
4. **Competencias de programación**: Muchos problemas requieren esta estructura

La clave del Lazy Segment Tree es la **propagación perezosa**: en lugar de actualizar todos los nodos inmediatamente, marcamos los nodos con actualizaciones pendientes y solo las aplicamos cuando es necesario (al consultar o al actualizar subárboles).