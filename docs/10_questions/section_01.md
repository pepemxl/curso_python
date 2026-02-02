# Preguntas en Python no tan sencillas

## Argumentos por defecto que son mutables

```python title="Que está mal en la siguiente función" linenums="1"
def add_item(item, bucket=[]):
    bucket.append(item)
    return bucket
```

```python title="La salida no es predecible"
print(add_item(1))  # [1]
print(add_item(2))  # [1, 2]
```

Los argumentos por defecto son evaluados una única vez, no en cada llamada!!!

```python title="Fix"
def add_item(item, bucket=None):
    bucket = bucket or []
    bucket.append(item)
    return bucket
```

## Alcance en Comprensión de Listas (Python 3 vs Python 2)

```python
x = 10
result = [x for x in range(5)]
print(x)  # ¿Qué valor tiene?
```

En Python 3, las comprensiones de listas tienen su propio alcance; en Python 2 lo filtraban.

## Modificar Iterables Mientras se Iteran

```python
lst = [1, 2, 3, 4]
for i in lst:
    lst.remove(i)
print(lst)  # ¿Qué queda?
```

Modificar una lista mientras se itera sobre ella causa que se salten elementos.

## "Inmutabilidad" de las Tuplas

```python
t = ([1, 2], 3)
t[0].append(3)
print(t)  # ¿Esto está permitido?
```

Las tuplas son inmutables pero su contenido puede ser mutable.

## `is` vs `==`

```python
print([] is [])   # ¿Verdadero o Falso?
print([] == [])   # ¿Verdadero o Falso?

print("" is "")   # ¿Verdadero o Falso?
```

`is` verifica identidad (mismo objeto), `==` verifica igualdad (mismo valor).

## Comparaciones Encadenadas

```python
print(1 < 2 < 3)     # ¿Verdadero o Falso?
print(1 < 2 is True) # ¿Verdadero o Falso?
```

Las comparaciones encadenadas se evalúan como `1 < 2 and 2 < 3`, no como `(1 < 2) < 3`.

## Igualdad de Claves de Diccionario

```python
d = {}
d[1] = "entero"
d[1.0] = "flotante"
d[True] = "booleano"

print(d)  # ¿Cuál es la salida?
```

`1 == 1.0 == True` en Python, así que las claves del diccionario colisionan.

## Atributos de Funciones

```python
def func():
    pass

func.attr = "valor"
print(func.attr)  # ¿Esto funciona?
```

Las funciones son objetos y pueden tener atributos añadidos dinámicamente.

## `__init__` No es un Constructor

```python
class A:
    def __new__(cls):
        print("new")
        return object.__new__(cls)
    
    def __init__(self):
        print("init")

a = A()  # ¿Qué se imprime primero?
```

`__new__` crea el objeto, `__init__` lo inicializa.

##  Alcance de Variables en Bloques Except

```python
try:
    x = 1 / 0
except Exception as e:
    pass

print(e)  # ¿Podemos acceder a e aquí?
```

En Python 3, las variables de excepción están limitadas al alcance del bloque except.

## MRO en Herencia Múltiple (Orden de Resolución de Métodos)

```python
class A:
    def method(self):
        print("A")

class B(A):
    def method(self):
        print("B")

class C(A):
    def method(self):
        print("C")

class D(B, C):
    pass

d = D()
d.method()  # ¿Qué se imprime?
```

Python usa linearización C3 para MRO (D -> B -> C -> A).

## `+=` con Tipos Mutables vs Inmutables

```python
# Caso 1
lst = [1, 2]
lst += [3, 4]
print(lst)  # [1, 2, 3, 4]

# Caso 2
t = (1, 2)
t += (3, 4)
print(t)    # ¿Qué sucede?
```

`+=` modifica listas in situ pero crea nuevas tuplas.

## Evaluación Booleana de No Booleanos

```python
print(bool([]))      # Falso
print(bool([[]]))    # ¿Verdadero o Falso?
print(bool([[]][0])) # ¿Verdadero o Falso?
```

Las colecciones vacías son False, las no vacías son True, incluso si contienen valores falsy.

## Cortocircuito en `any()` y `all()`

```python
def check(x):
    print(f"checking {x}")
    return x > 0

result = any(check(x) for x in [0, 0, 3, 0])
# ¿Cuántas veces se llama a check()?
```

`any()` se detiene en el primer True; `all()` se detiene en el primer False.

## Orden de Desempaquetado de Diccionarios (Python 3.6+)

```python
d1 = {'x': 1, 'y': 2}
d2 = {'y': 3, 'z': 4}

merged = {**d1, **d2}
print(merged)  # ¿Cuál es el valor de 'y'?
```

Los diccionarios posteriores sobrescriben a los anteriores en el desempaquetado.

## `isinstance()` y Clases Base Abstractas

```python
from collections.abc import Iterable

print(isinstance([], Iterable))        # True
print(isinstance(range(5), Iterable))  # True
print(isinstance(5, Iterable))         # False
```

Las ABCs permiten verificar protocolos sin herencia.

## Agotamiento de Generadores

```python
gen = (x for x in range(3))
print(list(gen))  # [0, 1, 2]
print(list(gen))  # ¿Cuál es la salida?
```

Los generadores solo pueden iterarse una vez.

## El Operador `or` Devuelve Valores, No Booleanos

```python
print(0 or "hello")   # "hello"
print([] or [1, 2])   # [1, 2]
print("hi" or "bye")  # "hi"
```

`or` devuelve el primer operando truthy o el último operando falsy.

