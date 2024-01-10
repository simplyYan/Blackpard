#include <stdio.h>
#include <time.h>

clock_t start_time;

// Inicializa o temporizador
void start_timer() {
    start_time = clock();
}

// Retorna o tempo decorrido desde o início do temporizador em segundos
double elapsed_time() {
    clock_t end_time = clock();
    return ((double)(end_time - start_time)) / CLOCKS_PER_SEC;
}

