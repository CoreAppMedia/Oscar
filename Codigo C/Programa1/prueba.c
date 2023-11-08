#include <stdio.h>

void imprimirMatriz(float matriz[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            printf("%f ", matriz[i][j]);
        }
        printf("\n");
    }
}

int main() {
    float matriz1[2][2] = {{1.0, 2.0}, {3.0, 4.0}};
    float matriz2[2][2] = {{5.0, 6.0}, {7.0, 8.0}};
    float matriz3[2][2] = {{9.0, 10.0}, {11.0, 12.0}};
    float matriz4[2][2] = {{13.0, 14.0}, {15.0, 16.0}};
    float matriz5[2][2] = {{17.0, 18.0}, {19.0, 20.0}};
    float matriz6[2][2] = {{21.0, 22.0}, {23.0, 24.0}};
    float matriz7[2][2] = {{25.0, 26.0}, {27.0, 28.0}};
    float matriz8[2][2] = {{29.0, 30.0}, {31.0, 32.0}};
    float matriz9[2][2] = {{33.0, 34.0}, {35.0, 36.0}};

    // Imprimir las 9 matrices de forma horizontal
    imprimirMatriz(matriz1);
    imprimirMatriz(matriz2);
    imprimirMatriz(matriz3);
    printf("\n");
    imprimirMatriz(matriz4);
    imprimirMatriz(matriz5);
    imprimirMatriz(matriz6);
    printf("\n");
    imprimirMatriz(matriz7);
    imprimirMatriz(matriz8);
    imprimirMatriz(matriz9);

    return 0;
}
