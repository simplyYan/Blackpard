#include "simple_time.h"

#ifdef _WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif

EXPORT void c_start_timer() {
    start_timer();
}

EXPORT double c_elapsed_time() {
    return elapsed_time();
}

