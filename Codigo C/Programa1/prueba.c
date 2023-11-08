#include <stdio.h>

void ingresarMatriz(float matriz[2][2], const char* nombre) {
    printf("Ingresa los valores de la matriz %s:\n", nombre);

    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            printf("Ingrese el valor para la posición [%d][%d]: ", i + 1, j + 1);
            scanf("%f", &matriz[i][j]);
        }
    }
}

void multiplicarYRestarMatrices(float matrizA[2][2], float matrizB[2][2], float matrizC[2][2], float resultado[2][2]) {
    // Multiplicar matrizA por matrizB y guardar el resultado en resultado
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            resultado[i][j] = 0.0;
            for (int k = 0; k < 2; k++) {
                resultado[i][j] += matrizA[i][k] * matrizB[k][j];
            }
        }
    }

    // Restar matrizC de resultado
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            resultado[i][j] -= matrizC[i][j];
        }
    }
        // Multiplicar el resultado por -1
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            resultado[i][j] *= -1;
        }
    }
}

void imprimirMatriz(float matriz[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            printf("%f ", matriz[i][j]);
        }
        printf("\n");
    }
}

int main() {
    float matrizA[2][2];  // Declarar la matriz A 2x2 (float)
    float matrizB[2][2];  // Declarar la matriz B 2x2 (float)
    float matrizC[2][2];  // Declarar la matriz C 2x2 (float)
    float resultado[2][2];  // Matriz para almacenar el resultado (float)

    ingresarMatriz(matrizA, "A");  // Llamar a la función para ingresar valores en la matriz A
    ingresarMatriz(matrizB, "B");  // Llamar a la función para ingresar valores en la matriz B
    ingresarMatriz(matrizC, "C");  // Llamar a la función para ingresar valores en la matriz C

    multiplicarYRestarMatrices(matrizA, matrizB, matrizC, resultado);  // Multiplicar y restar

    printf("Resultado de la multiplicación y resta:\n");
    imprimirMatriz(resultado);  // Imprimir el resultado

    return 0;
}
