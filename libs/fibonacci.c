#include <stdio.h>

#define MAX 100
#define NIL -1

long long memo[MAX];

void initialize() {
    int i;
    for (i = 0; i < MAX; i++) {
        memo[i] = NIL;
    }
}

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

    int n = 55;

    printf("The %th term of the Fibonacci sequence is: %lld\n", n, fibonacci(n));

    return 0;
}
