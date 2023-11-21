#include <stdio.h>

#define FILAS 4
#define COLUMNAS 5

void imprimirMatriz(double matriz[FILAS][COLUMNAS]) {
    for (int i = 0; i < FILAS; i++) {
        for (int j = 0; j < COLUMNAS; j++) {
            printf("%.2f\t", matriz[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

void intercambiarFilas(double matriz[FILAS][COLUMNAS], int fila1, int fila2) {
    printf("Intercambio: Fila %d <-> Fila %d\n", fila1 + 1, fila2 + 1);
    double temp[COLUMNAS];
    for (int i = 0; i < COLUMNAS; i++) {
        temp[i] = matriz[fila1][i];
        matriz[fila1][i] = matriz[fila2][i];
        matriz[fila2][i] = temp[i];
    }
    imprimirMatriz(matriz); // Imprimir la matriz después del intercambio
}

void invertirMatriz(double matriz[FILAS][COLUMNAS]) {
    printf("Matriz original:\n");
    imprimirMatriz(matriz);

    // Implementar el método de intercambio para invertir la matriz
    for (int i = 0; i < FILAS; i++) {
        if (matriz[i][i] == 0) {
            printf("La matriz no es invertible. No se puede dividir por cero.\n");
            return;
        }
        for (int j = 0; j < FILAS; j++) {
            if (i != j) {
                double factor = matriz[j][i] / matriz[i][i];
                for (int k = 0; k < COLUMNAS; k++) {
                    matriz[j][k] -= factor * matriz[i][k];
                }
            }
        }
    }

    // Normalización de la matriz
    for (int i = 0; i < FILAS; i++) {
        double factor = matriz[i][i];
        for (int j = 0; j < COLUMNAS; j++) {
            matriz[i][j] /= factor;
        }
    }

    printf("\nProcedimiento de intercambio de filas:\n");
    for (int i = 0; i < FILAS; i++) {
        for (int j = i + 1; j < FILAS; j++) {
            intercambiarFilas(matriz, i, j);
        }
    }
    printf("\nMatriz invertida:\n");
    imprimirMatriz(matriz);
}

int main() {
    double matriz[FILAS][COLUMNAS] = {
        {-1, 1, 0, -3, 4},
        {1, 0, 3, 1, 0},
        {0, 1, -1, -1, 3},
        {3, 0, 1, 2, 1}
    };

    invertirMatriz(matriz);

    return 0;
}
