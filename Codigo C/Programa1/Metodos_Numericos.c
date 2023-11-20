#include <stdio.h>
#include <stdlib.h>

// Función para compilar y llamar al programa 1
void llamarPrograma1() {
    system("gcc -o programa1 programa1.c"); // Compilar programa 1
    system("./programa1"); // Ejecutar programa 1
}

// Función para compilar y llamar al programa 2
void llamarPrograma2() {
    system("gcc -o programa2 programa2.c"); // Compilar programa 2
    system("./programa2"); // Ejecutar programa 2
}

int main() {
    int opcion;

    do {
        printf("Seleccione una opción:\n");
        printf("1. Ejecutar Programa 1\n");
        printf("2. Ejecutar Programa 2\n");
        printf("0. Salir\n");
        printf("Opción: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1:
                llamarPrograma1();
                break;
            case 2:
                llamarPrograma2();
                break;
            case 0:
                printf("Saliendo...\n");
                break;
            default:
                printf("Opción inválida. Por favor, elige una opción válida.\n");
        }

    } while (opcion != 0);

    return 0;
}
