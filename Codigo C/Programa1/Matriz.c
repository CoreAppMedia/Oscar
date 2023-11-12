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



int main() {
    float matriz[5][6];  // Declarar una matriz 5x6
    inicializarMatriz(matriz); 
    mostrarMatriz(matriz); 

  /*ingresarMatriz(matriz);  // Llamar a la función para ingresar valores en la matriz */

    float inversaA11[2][2];   // Declarar la matriz inversa
    float Matriz2x2[2][2];  // Declarar una nueva matriz para almacenar los valores deseados
    float MatrizA11[2][2];
    float MatrizA12[2][2];
    float MatrizA13[2][2];
    float Matrizb1[2][2];
    float MatrizA21[2][2];
    float MatrizA22[2][2];
    float MatrizA23[2][2];
    float Matrizb2[2][2];
    float MatrizA31[2][2];
    float MatrizA32[2][2];
    float MatrizA33[2][2];
    float Matrizb3[2][2];
    float inversaA22[2][2];

    float resultadoI_1[2][2]; 
    float resultadoA12[2][2]; // Matriz para almacenar el resultado de la multiplicación (float)
    float resultadoA13[2][2];
    float resultadoA13_2[2][2];
    float resultadob1[2][2];
    float resultadob1_2[2][2];
    float resultadoO[2][2];
    float resultadoO_2[2][2];
    float resultadoA22[2][2];
    float resultadoA23[2][2];
    float resultadoA23_2[2][2];
    float resultadob2[2][2];
    float resultadob2_2[2][2];
    float resultadoA31[2][2];
    float resultadoA32[2][2];
    float resultadoA33[2][2];
    float resultadob3[2][2];

    copiarValoresMatriz11(matriz, MatrizA11);  // Llamar a la función para copiar valores
    printf("Matriz11");
    imprimirMatriz2x2(MatrizA11);  // Llamar a la función para imprimir la nueva matriz
     float determinante11 = calcularDeterminante2x2(MatrizA11);  // Calcular el determinante
    printf("Determinante de la nueva matriz 11: %.2f\n", determinante11);

    calcularMatrizInversa(MatrizA11, inversaA11);
    if (calcularDeterminante2x2(MatrizA11) != 0) {
        printf("Inversa de la matriz 11:\n");
        imprimirMatriz2x2(inversaA11);
    }
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz12(matriz, MatrizA12);  // Llamar a la función para copiar valores
    printf("\nMatriz12");
    imprimirMatriz2x2(MatrizA12);  // Llamar a la función para imprimir la nueva matriz
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz13(matriz, MatrizA13);  
    inicializarCeros(MatrizA13);
    printf("\nMatriz13");
    imprimirMatriz2x2(MatrizA13);  
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz21(matriz,MatrizA21);
    printf("\nMatriz21");
    imprimirMatriz2x2(MatrizA21);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz22(matriz,MatrizA22);
    printf("\nMatriz22");
    imprimirMatriz2x2(MatrizA22);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz23(matriz,MatrizA23);
    inicializarCeros(MatrizA23);
    printf("\nMatriz23");
    imprimirMatriz2x2(MatrizA23);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz31(matriz,MatrizA31);
    inicializarCeros1(MatrizA31);
    printf("\nMatriz31");
    imprimirMatriz2x2(MatrizA31);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz32(matriz,MatrizA32);
    inicializarCeros1(MatrizA32);
    printf("\nMatriz32");
    imprimirMatriz2x2(MatrizA32);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatriz33(matriz,MatrizA33);
    inicializarCeros2(MatrizA33);
    printf("\nMatriz33");
    imprimirMatriz2x2(MatrizA33);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatrizb1(matriz,Matrizb1);
    inicializarCeros(Matrizb1);
    printf("\nMatriz b1");
    imprimirMatriz2x2(Matrizb1);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatrizb2(matriz,Matrizb2);
    inicializarCeros(Matrizb2);
    printf("\nMatriz b2");
    imprimirMatriz2x2(Matrizb2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    copiarValoresMatrizb3(matriz,Matrizb3);
    inicializarCeros2(Matrizb3);
    printf("\nMatriz b3");
    imprimirMatriz2x2(Matrizb3);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

//Empezamos las multiplicaciones de matrices

    multiplicarMatrices(MatrizA11,inversaA11,resultadoI_1);
    printf("\nMUltiplicacion de A11 y su Iversa = I ");
    imprimirMatriz2x2(resultadoI_1);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarMatrices(inversaA11,MatrizA12,resultadoA12);
    printf("\nMUltiplicacion de A12 y la Iversa de A11 = A12 ");
    imprimirMatriz2x2(resultadoA12);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarMatrices(inversaA11,MatrizA13,resultadoA13);
    printf("\nMUltiplicacion de A13 y la Iversa de A11 = A13");
    imprimirMatriz2x2(resultadoA13);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarMatrices(inversaA11,Matrizb1,resultadob1);
    printf("\nMUltiplicacion de b1 y la Iversa de A11 = b1");
    imprimirMatriz2x2(resultadob1);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA21,resultadoI_1,MatrizA21,resultadoO);
    printf("\nMUltiplicacion de A21 - A21*I = 0");
    imprimirMatriz2x2(resultadoO);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA21,resultadoA12,MatrizA22,resultadoA22);
    printf("\nMUltiplicacion de A22 - A21*A12 = A22");
    imprimirMatriz2x2(resultadoA22);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA21,resultadoA13,MatrizA23,resultadoA23);
    printf("\nMUltiplicacion de A23 - A21*A13 = A23");
    imprimirMatriz2x2(resultadoA23);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA21,resultadob1,Matrizb2,resultadob2);
    printf("\nMUltiplicacion de b2 - A21*b1 = b2");
    imprimirMatriz2x2(resultadob2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA31,resultadoI_1,MatrizA31,resultadoO);
    printf("\nMUltiplicacion de A31 - A31*I = 0");
    imprimirMatriz2x2(resultadoO);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA31,resultadoA12,MatrizA32,resultadoA32);
    printf("\nMUltiplicacion de A32 - A31*A12 = A32");
    imprimirMatriz2x2(resultadoA32);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA31,resultadoA13,MatrizA33,resultadoA33);
    printf("\nMUltiplicacion de A33 - A31*A13 = A33");
    imprimirMatriz2x2(resultadoA33);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(MatrizA31,resultadob1,Matrizb3,resultadob3);
    printf("\nMUltiplicacion de b3 - A31*b1 = b3");
    imprimirMatriz2x2(resultadob3);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");
    
    printf("\nCALCULAMOS EL DETERMINANTE DE LA MATRIZ A22 PARA PODER CONTINUAR\n");
    printf("CON LA CONDICION DE QUE SEA NO SINGULAR\n");
//CALCULAMOS EL DETERMINANTE DE LA MATRIZ A22
    imprimirMatriz2x2(resultadoA22);  // Llamar a la función para imprimir la nueva matriz
     float determinante22 = calcularDeterminante2x2(resultadoA22);  // Calcular el determinante
    printf("Determinante de la nueva matriz 22: %.2f\n", determinante22);
    calcularMatrizInversa(resultadoA22, inversaA22);
    if (calcularDeterminante2x2(resultadoA22) != 0) {
        printf("Inversa de la matriz 22:\n");
        imprimirMatriz2x2(inversaA22);
    }
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarMatrices(resultadoA22,inversaA22,resultadoI_1);
    printf("\nMUltiplicacion de A22 y su Iversa = I ");
    imprimirMatriz2x2(resultadoI_1);
     printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarMatrices(inversaA22,resultadoA23,resultadoA23_2);
    printf("\nMUltiplicacion de A23 y la Iversa de A22 = A23 ");
    imprimirMatriz2x2(resultadoA23_2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarMatrices(inversaA22,resultadob2,resultadob2_2);
    printf("\nMUltiplicacion de b2 y la Iversa de A22 = b2 ");
    imprimirMatriz2x2(resultadob2_2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(resultadoA12,resultadoI_1,resultadoA12,resultadoO_2);
    printf("\nMUltiplicacion de A12 - A12*I = 0");
    imprimirMatriz2x2(resultadoO_2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(resultadoA12,resultadoA23_2,resultadoA13,resultadoA13_2);
    printf("\nMUltiplicacion de A13 - A12*A23 = A13");
    imprimirMatriz2x2(resultadoA13_2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    multiplicarYRestarMatrices(resultadoA12,resultadob2_2,resultadob1,resultadob1_2);
    printf("\nMUltiplicacion de b1 - A12*b2 = b1");
    imprimirMatriz2x2(resultadob1_2);
    printf("-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.");

    printf("\nCALCULAMOS EL DETERMINANTE DE LA MATRIZ A33 PARA PODER CONTINUAR\n");
    printf("CON LA CONDICION DE QUE SEA NO SINGULAR\n");
//CALCULAMOS EL DETERMINANTE DE LA MATRIZ A22
    imprimirMatriz2x2(resultadoA22);  // Llamar a la función para imprimir la nueva matriz
     float determinante22 = calcularDeterminante2x2(resultadoA22);  // Calcular el determinante
    printf("Determinante de la nueva matriz 22: %.2f\n", determinante22);
    calcularMatrizInversa(resultadoA22, inversaA22);
    if (calcularDeterminante2x2(resultadoA22) != 0) {
        printf("Inversa de la matriz 22:\n");
        imprimirMatriz2x2(inversaA22);
    }

printf("\n\nFin del Programa\n");
    return 0;
}


