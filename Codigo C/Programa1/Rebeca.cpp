#include <iostream>
#include <cctype>

const int ARRAY_SIZE = 10;
char arreglo[ARRAY_SIZE]; 
void leerArreglo() {
    int i;
    std::cout << "\n\nIngresa " << ARRAY_SIZE << " caracteres para el arreglo: ";
    for (i = 0; i < ARRAY_SIZE; ++i) {
        std::cin >> arreglo[i];
    }
}

void mostrarPares(int index = 0) {
    if (index >= ARRAY_SIZE) {
        std::cout << std::endl;
        return;
    }
    if (index % 2 == 0) {
        std::cout << arreglo[index] << " ";
    }
    mostrarPares(index + 1);
}

void contarMayusculasMinusculas() {
    int mayusculas = 0, minusculas = 0;
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        if (std::isupper(arreglo[i])) {
            mayusculas++;
        } else if (std::islower(arreglo[i])) {
            minusculas++;
        }
    }

    std::cout << "Mayúsculas: " << mayusculas << std::endl;
    std::cout << "Minúsculas: " << minusculas << std::endl;
}



void contarVocales() {
    int vocales[5] = {0}; // a, e, i, o, u (en orden)
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        char c = std::tolower(arreglo[i]);
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

    std::cout << "A: " << vocales[0] << ", ";
    std::cout << "E: " << vocales[1] << ", ";
    std::cout << "I: " << vocales[2] << ", ";
    std::cout << "O: " << vocales[3] << ", ";
    std::cout << "U: " << vocales[4] << std::endl;
}

int contarApariciones(char letra, int index = 0, int contador = 0) {
    if (index >= ARRAY_SIZE) {
        return contador;
    }
    if (std::tolower(arreglo[index]) == std::tolower(letra)) {
        contador++;
    }
    return contarApariciones(letra, index + 1, contador);
}

void buscarLetra() {
    char letra;
    std::cout << "Ingresa la letra a buscar: ";
    std::cin >> letra;
    int apariciones = contarApariciones(letra);
    std::cout << "La letra '" << letra << "' aparece " << apariciones << " veces en el arreglo." << std::endl;
}

void mostrarMenu() {
    std::cout << "----------- Menu -----------" << std::endl;
    std::cout << "a) Mostrar contenido de posiciones pares" << std::endl;
    std::cout << "b) Contar apariciones de vocales y Mayusculas/minusculas" << std::endl;
    std::cout << "c) Buscar cantidad de veces que aparece una letra" << std::endl;
    std::cout << "d) Salir del programa" << std::endl;
    std::cout << "Ingrese una opción: ";
}

int main() {
    leerArreglo();
    char opcion;

    do {
        mostrarMenu();
        std::cin >> opcion;

        switch (opcion) {
            case 'a':
                std::cout << "Contenido de posiciones pares: ";
                mostrarPares();
                break;
            case 'b':
                std::cout << "Cantidad de veces que aparece cada vocal y si hay mayusculas o minusculas: \n";
                contarVocales();
                contarMayusculasMinusculas();
                break;
            case 'c':
                buscarLetra();
                break;
            case 'd':
                std::cout << "Saliendo del programa. ¡Hasta luego!" << std::endl;
                break;
            default:
                std::cout << "Opción inválida. Inténtalo de nuevo." << std::endl;
        }
    } while (opcion != 'd');

    return 0;
}
