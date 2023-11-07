#include <stdio.h>

void ingresarMatriz(float matriz[5][6]) {
    printf("Ingresa los valores de la matriz 6x6:\n");

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 6; j++) {
            printf("Ingrese el valor para la posición [%d][%d]: ", i + 1, j + 1);
            scanf("%f", &matriz[i][j]);
        }
    }
}

void inicializarMatriz(float matriz[5][6]) {
    int datos[] = {
        1, 2, 7, -9, 5, 58,
        6, 9, 3, 6, 6, 36,
        -5, 3, 5, 1, 8, 88,
        -1, -3, 7, 6, 6, 14,
        -8, 2, -8, 5, -5, 14
    };

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 6; j++) {
            matriz[i][j] = datos[i * 6 + j];
        }
    }
}
void mostrarMatriz(float matriz[5][6]) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 6; j++) {
            printf("%.2f ", matriz[i][j]);
        }
        printf("\n");
    }
}

    
//crear matriz de 2x2, inversa  y su determinante
void copiarValoresMatriz11(float matriz[6][6], float Matriz2x2[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            Matriz2x2[i][j] = matriz[i][j];
        }
    }
}
void copiarValoresMatriz12(float matriz[6][6], float Matriz2x2[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            Matriz2x2[i][j] = matriz[i][j+2];
        }
    }
}
void copiarValoresMatriz13(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[0][4];
    nuevaMatriz[1][0] = matriz[1][4];
}
void copiarValoresMatriz21(float matriz[5][6], float Matriz2x2[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            Matriz2x2[i][j] = matriz[i+2][j];
        }
    }
}
void copiarValoresMatriz22(float matriz[5][6], float Matriz2x2[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            Matriz2x2[i][j] = matriz[i+2][j+2];
        }
    }
}
void copiarValoresMatriz23(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[2][4];
    nuevaMatriz[1][0] = matriz[3][4];
}
void copiarValoresMatriz31(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[4][0];
    nuevaMatriz[0][1] = matriz[4][1];
}
void copiarValoresMatriz32(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[4][2];
    nuevaMatriz[0][1] = matriz[4][3];
}
void copiarValoresMatriz33(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[4][4];
}
void copiarValoresMatrizb1(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[0][5];
    nuevaMatriz[1][0] = matriz[1][5];
}
void copiarValoresMatrizb2(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[2][5];
    nuevaMatriz[1][0] = matriz[3][5];
}
void copiarValoresMatrizb3(int matriz[5][6], int nuevaMatriz[2][2]) {
    nuevaMatriz[0][0] = matriz[4][5];
}
void inicializarCeros(int nuevaMatriz[2][2]) {
    nuevaMatriz[0][1] = nuevaMatriz[1][1] = 0;
}
void inicializarCeros1(int nuevaMatriz[2][2]) {
    nuevaMatriz[1][0] = nuevaMatriz[1][1] = 0;
}
void inicializarCeros2(int nuevaMatriz[2][2]) {
    nuevaMatriz[1][0] = nuevaMatriz[1][1] = nuevaMatriz[0][1] = 0;
}

//sta funcion la usamos para imprimir las Matrices
void imprimirMatriz2x2(float matriz2x2[2][2]) {
    printf("\n");
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            printf("%0.2f ", matriz2x2[i][j]);
        }
        printf("\n");
    }
}

int calcularDeterminante2x2(float matriz[2][2]) {
    return (matriz[0][0] * matriz[1][1]) - (matriz[0][1] * matriz[1][0]);
}

void calcularMatrizInversa(float matriz[2][2], float inversa[2][2]) {
    int determinante2x2 = calcularDeterminante2x2(matriz);

    if (determinante2x2 != 0) {
        inversa[0][0] = matriz[1][1] / determinante2x2;
        inversa[0][1] = -matriz[0][1] / determinante2x2;
        inversa[1][0] = -matriz[1][0] / determinante2x2;
        inversa[1][1] = matriz[0][0] / determinante2x2;
    } else {
        printf("El determinante es igual a 0, por lo que la matriz no tiene inversa.\n");
    }
}
// Termina crear matriz de 2x2, inversa y su determinante

//operaciones para el metodo de Gauz-Jordan
void multiplicarMatrices(float matrizA[2][2], float matrizB[2][2], float resultado[2][2]) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            resultado[i][j] = 0.0;
            for (int k = 0; k < 2; k++) {
                resultado[i][j] += matrizA[i][k] * matrizB[k][j];
            }
        }
    }
}



int main() {
    float matriz[5][6];  // Declarar una matriz 5x6
    inicializarMatriz(matriz); 
    mostrarMatriz(matriz); 

  /*ingresarMatriz(matriz);  // Llamar a la función para ingresar valores en la matriz */

    float inversa[2][2];   // Declarar la matriz inversa
    float Matriz2x2[2][2];  // Declarar una nueva matriz para almacenar los valores deseados
    float Matriz11[2][2];
    float Matriz12[2][2];
    float resultadoI_1[2][2];  // Matriz para almacenar el resultado de la multiplicación (float)

    copiarValoresMatriz11(matriz, Matriz11);  // Llamar a la función para copiar valores
    printf("Matriz11");
    imprimirMatriz2x2(Matriz11);  // Llamar a la función para imprimir la nueva matriz
     float determinante11 = calcularDeterminante2x2(Matriz11);  // Calcular el determinante
    printf("Determinante de la nueva matriz 11: %.2f\n", determinante11);

    calcularMatrizInversa(Matriz11, inversa);
    if (calcularDeterminante2x2(Matriz11) != 0) {
        printf("Inversa de la matriz 11:\n");
        imprimirMatriz2x2(inversa);
    }
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz12(matriz, Matriz2x2);  // Llamar a la función para copiar valores
    printf("\nMatriz12");
    imprimirMatriz2x2(Matriz2x2);  // Llamar a la función para imprimir la nueva matriz
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz13(matriz, Matriz2x2);  
    inicializarCeros(Matriz2x2);
    printf("\nMatriz13");
    imprimirMatriz2x2(Matriz2x2);  
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz21(matriz,Matriz2x2);
    printf("\nMatriz21");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz22(matriz,Matriz2x2);
    printf("\nMatriz22");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz23(matriz,Matriz2x2);
    inicializarCeros(Matriz2x2);
    printf("\nMatriz23");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz31(matriz,Matriz2x2);
    inicializarCeros1(Matriz2x2);
    printf("\nMatriz31");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz32(matriz,Matriz2x2);
    inicializarCeros1(Matriz2x2);
    printf("\nMatriz32");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz33(matriz,Matriz2x2);
    inicializarCeros2(Matriz2x2);
    printf("\nMatriz33");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatrizb1(matriz,Matriz2x2);
    inicializarCeros(Matriz2x2);
    printf("\nMatriz b1");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatrizb2(matriz,Matriz2x2);
    inicializarCeros(Matriz2x2);
    printf("\nMatriz b2");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatrizb3(matriz,Matriz2x2);
    inicializarCeros2(Matriz2x2);
    printf("\nMatriz b3");
    imprimirMatriz2x2(Matriz2x2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    multiplicarMatrices(Matriz11,inversa,resultadoI_1);
    printf("\nMUltiplicacion de A11 y su Iversa ");
    imprimirMatriz2x2(resultadoI_1);




    return 0;
}


