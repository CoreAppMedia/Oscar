#include <stdio.h>
#include <ctype.h>

#define palabra 10

char arreglo[palabra];

void leerArreglo() {
    printf("\n Ingresa %d caracteres para el arreglo: \n ", palabra);
    for (int i = 0; i < palabra; ++i) {
        scanf(" %c", &arreglo[i]);
    }
}

void mostrarPares(int index) {
    if (index >= palabra) {
        printf("\n");
        return;
    }
    if (index % 2 == 0) {
        printf("%c ", arreglo[index]);
    }
    mostrarPares(index + 1);
}
void mostrarImpares(int index) {
    if (index >= palabra) {
        printf("\n");
        return;
    }
    if (index % 2 != 0) {
        printf("%c ", arreglo[index]);
    }
    mostrarImpares(index + 1);
}


void contarVocales() {
    int vocales[5] = {0}; // a, e, i, o, u (en orden)
    for (int i = 0; i < palabra; ++i) {
        char c = tolower(arreglo[i]);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            switch (c) {
                case 'a':
                    vocales[0]++;
                    break;
                case 'e':
                    vocales[1]++;
                    break;
                case 'i':
                    vocales[2]++;
                    break;
                case 'o':
                    vocales[3]++;
                    break;
                case 'u':
                    vocales[4]++;
                    break;
            }
        }
    }

    printf("A: %d, E: %d, I: %d, O: %d, U: %d\n", vocales[0], vocales[1], vocales[2], vocales[3], vocales[4]);
}

void contarMayusculasMinusculas() {
    int mayusculas = 0, minusculas = 0;
    for (int i = 0; i < palabra; ++i) {
        if (isupper(arreglo[i])) {
            mayusculas++;
        } else if (islower(arreglo[i])) {
            minusculas++;
        }
    }

    printf("Mayúsculas: %d\n", mayusculas);
    printf("Minúsculas: %d\n", minusculas);
}


int contarApariciones(char letra) {
    int contador = 0;
    for (int i = 0; i < palabra; ++i) {
        if (tolower(arreglo[i]) == tolower(letra)) {
            contador++;
        }
    }
    return contador;
}

void buscarLetra() {
    char letra;
    printf("\n\nIngresa la letra a buscar: ");
    scanf(" %c", &letra);
    int apariciones = contarApariciones(letra);
    printf("La letra '%c' aparece %d veces en el arreglo.\n", letra, apariciones);
}

void mostrarMenu() {
    printf("\n \n ----------- Menu -----------\n");
    printf("a) Mostrar contenido de posiciones pares\n");
    printf("b) Contar apariciones de vocales, mayusculas y minusculas\n");
    printf("c) Buscar cantidad de veces que aparece una letra\n");
    printf("d) Salir del programa\n");
    printf("Ingrese una opción: ");
}

int main() {
    leerArreglo();
    char opcion;

    do {
        mostrarMenu();
        scanf(" %c", &opcion);

        switch (opcion) {
            case 'a':
                printf("\n \n Contenido de posiciones pares: ");
                mostrarImpares(0);
                break;
            case 'b':
                printf("\n\nvocales:");
                contarVocales();
                contarMayusculasMinusculas();
                break;
            case 'c':
                buscarLetra();
                break;
            case 'd':
                printf("\n \n Saliendo del programa. ¡Hasta luego!\n");
                break;
            default:
                printf("\n \n Opción inválida. Inténtalo de nuevo.\n");
        }
    } while (opcion != 'd');

    return 0;
}
