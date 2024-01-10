#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_CACHE_SIZE 100

typedef struct {
    char* key;
    int value;
} MemoizeEntry;

MemoizeEntry cache[MAX_CACHE_SIZE];
int cacheSize = 0;

int findInCache(const char* key) {
    for (int i = 0; i < cacheSize; ++i) {
        if (strcmp(cache[i].key, key) == 0) {
            return cache[i].value;
        }
    }
    return -1; // Indicador de não encontrado
}

void addToCache(const char* key, int value) {
    if (cacheSize < MAX_CACHE_SIZE) {
        cache[cacheSize].key = strdup(key);
        cache[cacheSize].value = value;
        cacheSize++;
    }
}

int pvm(int (*func)(int), int arg) {
    char key[50];
    sprintf(key, "%p:%d", func, arg);

    int result = findInCache(key);
    if (result != -1) {
        printf("Cache hit for key: %s\n", key);
        return result;
    }

    result = func(arg);
    addToCache(key, result);
    return result;
}

