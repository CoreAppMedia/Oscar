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
}

void intercambiarFilas(double matriz[FILAS][COLUMNAS], int fila1, int fila2) {
    for (int i = 0; i < COLUMNAS; i++) {
        double temp = matriz[fila1][i];
        matriz[fila1][i] = matriz[fila2][i];
        matriz[fila2][i] = temp;
    }
}

void invertirMatriz(double matriz[FILAS][COLUMNAS]) {
    // Implementar el método de intercambio para invertir la matriz
    for (int i = 0; i < FILAS; i++) {
        for (int j = 0; j < COLUMNAS; j++) {
            if (i != j) {
                double factor = matriz[j][i] / matriz[i][i];
                for (int k = 0; k < COLUMNAS; k++) {
                    matriz[j][k] -= factor * matriz[i][k];
                }
            }
        }
    }
    for (int i = 0; i < FILAS; i++) {
        double factor = matriz[i][i];
        for (int j = 0; j < COLUMNAS; j++) {
            matriz[i][j] /= factor;
        }
    }
    for (int i = FILAS - 1; i >= 0; i--) {
        for (int j = i - 1; j >= 0; j--) {
            double factor = matriz[j][i] / matriz[i][i];
            for (int k = 0; k < COLUMNAS; k++) {
                matriz[j][k] -= factor * matriz[i][k];
            }
        }
    }
}

int main() {
    double matriz[FILAS][COLUMNAS] = {
        {-1, 1, 0, -3, 4},
        {1, 0, 3, 1, 0},
        {0, 1, -1, -1, 3},
        {3, 0, 1, 2, 1}
    };

    printf("Matriz original:\n");
    imprimirMatriz(matriz);

    invertirMatriz(matriz);

    printf("\nMatriz invertida:\n");
    imprimirMatriz(matriz);

    return 0;
}

/////////////////////////


