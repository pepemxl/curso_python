# usando el clousure

def funcion_decorador(funcion):

    def funcion_wrapper():
        print("Dentro de la función wrapper")
        funcion()
    return funcion_wrapper


def funcion_prueba():
    print("Está es una función de prueba")


# Añadir el decorado como instancia
f1 = funcion_decorador(funcion_prueba)


if __name__ == '__main__':
    funcion_prueba()
    f1()
    print("Hola mundo".find("Hola"))
