#ifndef MEMOIZE_H
#define MEMOIZE_H

#ifdef __cplusplus
extern "C" {
#endif

int pvm(int (*func)(int), int arg);

#ifdef __cplusplus
}
#endif

#endif /* MEMOIZE_H */

