#ifndef RDTSC_H
#define RDTSC_H

#include <time.h>
#include <sys/time.h>

#ifndef CPU_FREQ
#define CPU_FREQ 1000
#endif

unsigned long long int rdtsc()
{
#ifndef WASM
  unsigned long long int ret = 0;
  unsigned int cycles_lo;
  unsigned int cycles_hi;
  __asm__ volatile ("RDTSC" : "=a" (cycles_lo), "=d" (cycles_hi));
  ret = (unsigned long long int)cycles_hi << 32 | cycles_lo;

  return ret;
#else
    struct timeval Tp;
    int stat;
    stat = gettimeofday (&Tp, NULL);
    if (stat != 0)
      printf ("Error return from gettimeofday: %d", stat);
    return (Tp.tv_sec + Tp.tv_usec * 1.0e-6);
#endif
}

#endif /* RDTSC_H */
