# HPC en Python

High Performance Computing en Python implica utilizar diverasas técnicas y bibliotecas para aprovechar al máximo los recursos de hardware disponibles.

## Multithreading y Multiprocesiong

### Multithreading

Usa el módulo `threading` para ejecutar tareas cocurrentemente. Este enfoque es útil para tareas I/O bound.

### Multiprocessing

El módulo `multiprocessing` permite ejecutar tareas en paralelo usando múltiples procesos, ideal para tareas CPU-bound.


```python 
import multiprocessing

def worker_function(data):
    # Realiza alguna tarea
    return data * 2

if __name__ == "__main__":
    with multiprocessing.Pool(processes=4) as pool:
        results = pool.map(worker_function, range(10))
    print(results)
```

## Numpy y Scipy

### Numpy

Ofrece **operaciones vectorizadas**  que son más rapidas que los lazos de Python habituales.


### Scipy

Proporciona funciones adicionales para cálculos científicos, incluyendo **optimización**, integración y resolución de ecuaciones.


## Dask

Dask es una biblioteca para cáculo paralelo que permite ampliar Numpy y Pandas a conjutos de datos que no caben en memoria. (Es decir computo distribuido)


```python
import dask.array as da

x = da.ones((10000, 10000), chunks=(1000, 1000))
y = x + x.T
result = y.compute()  # Convierte de Dask a NumPy
```


## Joblib

Sirve para paralelizar tareas y optimizar la ejecución de funciones que requieren mucho tiempo de cálculo.

```python
from joblib import Parallel, delayed

def task(n):
    return n * n

results = Parallel(n_jobs=4)(delayed(task)(i) for i in range(10))
print(results)
```


## Cupy

Cupy es una biblioteca que implente arrays en GPU, similar a Numpy pero con CUDA!!!

## MPI para python con mpi4py

Interfaz para usar el estándar MPI (Message Passing Interface) en Python.

```python
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
print(f"Hello from process {rank}")
```


## Tensorflow y PyTorch

Librerías para AI.


