#include <stdio.h>
#include <time.h>

#define MAX 100
#define NIL -1

long long memo[MAX];

// Initializes the memo array with NIL
void initialize() {
    int i;
    for (i = 0; i < MAX; i++) {
        memo[i] = NIL;
    }
}

// Efficiently calculates the Fibonacci number using memoization
long long fibonacci(int n) {
    if (memo[n] == NIL) {
        if (n <= 1) {
            memo[n] = n;
        } else {
            memo[n] = fibonacci(n - 1) + fibonacci(n - 2);
        }
    }
    return memo[n];
}

int main() {
    initialize();

    int n = 55; // Calculate the 55th term of the Fibonacci sequence

    clock_t start, end;
    double cpu_time_used;

    start = clock();
    long long result = fibonacci(n);
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

    printf("The %dth term of the Fibonacci sequence is: %lld\n", n, result);
    printf("Execution time: %f seconds\n", cpu_time_used);

    return 0;
}
