# **Control de Flujo**

El control de flujo permite decidir qué partes del código se ejecutan y bajo qué condiciones. Incluye **condicionales** (para tomar decisiones) y **bucles** (para repetir acciones).

## **Condicionales: `if`, `elif`, `else`**
Se utilizan para ejecutar bloques de código **solo si se cumple una condición**.

  ```python linenums="1" title="Estructura básica"
  if condición1:
      # Código si condición1 es True
  elif condición2:
      # Código si condición2 es True (opcional, múltiples elif)
  else:
      # Código si ninguna condición anterior fue True (opcional)
  ```

  ```python linenums="1" title="Ejemplo"
  edad = 18

  if edad < 13:
      print("Eres un niño.")
  elif 13 <= edad < 18:
      print("Eres un adolescente.")
  else:
      print("Eres un adulto.")
  ```
  
  ```bash title="Salida"
  Eres un adulto.
  ```

- **Condiciones compuestas**:

  ```python linenums="1"
  if edad >= 18 and tiene_licencia:
      print("Puedes conducir.")
  ```


## **2.2 Bucles**

### **a) Bucle `while`**
Repite un bloque **mientras una condición sea verdadera**.

  ```python linenums="1" title="Sintaxis"
  while condición:
      # Código a repetir
  ```

  ```python linenums="1" title="Ejemplo: Contar del 1 al 5"
  contador = 1
  while contador <= 5:
      print(f"Valor del contador: {contador}")
      contador += 1  # Incremento para evitar loop infinito.
  ```
  
  ```bash title="Salida"
  Valor del contador: 1
  Valor del contador: 2
  Valor del contador: 3
  Valor del contador: 4
  Valor del contador: 5
  ```

### **b) Bucle `for`**
Itera sobre elementos de una secuencia (listas, strings, rangos, etc.).

- **Sintaxis**:
  ```python linenums="1"
  for elemento in secuencia:
      # Código a repetir por cada elemento
  ```

- **Ejemplos**:
  - **Listas**:
    ```python linenums="1"
    frutas = ["manzana", "banana", "naranja"]
    for fruta in frutas:
        print(fruta.upper())
    ```
    **Salida**:
    ```
    MANZANA
    BANANA
    NARANJA
    ```

  - **Rangos (`range`)**:
    ```python linenums="1"
    for i in range(3):  # 0, 1, 2
        print(f"Número: {i}")
    ```

  - **Strings**:
    ```python linenums="1"
    for letra in "Python":
        print(letra)
    ```

---

## **2.3 Control de Bucles**

### **`break`**
Detiene el bucle **inmediatamente**, incluso si la condición aún es `True`.

- **Ejemplo**: Salir del bucle al encontrar el número 3:
  ```python linenums="1"
  for num in [1, 2, 3, 4, 5]:
      if num == 3:
          break
      print(num)
  ```
  **Salida**:
  ```
  1
  2
  ```

### **`continue`**
Omite el resto del código en la iteración actual y **continúa con la siguiente**.

- **Ejemplo**: Imprimir solo números pares:
  ```python linenums="1"
  for num in range(1, 6):
      if num % 2 != 0:
          continue
      print(num)
  ```
  **Salida**:
  ```
  2
  4
  ```

### **`else` en Bucles**
Se ejecuta **solo si el bucle terminó normalmente** (sin un `break`).

- **Ejemplo**:
  ```python linenums="1"
  for num in range(3):
      print(num)
  else:
      print("Bucle completado.")
  ```
  **Salida**:
  ```bash
  0
  1
  2
  Bucle completado.
  ```

