#include <stdio.h>
#include <math.h>

#define MAX_ITER 1000
#define EPSILON 1e-5

// Definición de la función f(x)
double f(double x) {
   // return 3 * x * x - exp(x); // Cambia esta función por la que desees encontrar la raíz
    return x * log(x) - 10;
}

// Método de la secante
double secantMethod(double (*func)(double), double x0, double x1, double epsilon, int max_iter) {
    int iter = 1;
    double xn, xn_1 = x0, xn_2 = x1, fxn, fxn_1, tolerance;

    printf("| Iteración | xn-1      | xn        | f(xn-1)   | f(xn)     | xn+1      | Error relativo |\n");
    printf("|-----------|-----------|-----------|-----------|-----------|-----------|----------------|\n");

    do {
        fxn = func(xn_1);
        fxn_1 = func(xn_2);
        xn = xn_1 - (fxn * (xn_1 - xn_2)) / (fxn - fxn_1);
        tolerance = fabs(xn - xn_1);

        printf("| %-9d | %-9.6f | %-9.6f | %-9.6f | %-9.6f | %-9.6f | %-14.6e |\n", iter, xn_1, xn_2, fxn, fxn_1, xn, tolerance);

        xn_2 = xn_1;
        xn_1 = xn;
        iter++;

    } while (tolerance > epsilon && iter < max_iter);

    return xn_2;
}

int main() {
    double x0 = 15.0; // Primer punto inicial
    double x1 = 16.0; // Segundo punto inicial

    printf("Método de la secante para encontrar la raíz de f(x)\n");
    double root = secantMethod(f, x0, x1, EPSILON, MAX_ITER);

    printf("\nLa raíz aproximada es: %.8f\n", root);

    return 0;
}
