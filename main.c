#include <stdio.h>
#include <time.h>

extern long long ent(void);

int N_ITERATIONS = 5;

int main() {
  clock_t t;
  long long ans;

  t = clock();

  for (int i = 0; i < N_ITERATIONS; ++i) {
    ans = ent();
  }

  t = clock() - t;
  double time_taken = ((double) t)/CLOCKS_PER_SEC;

  printf("The value is %lld\n", ans);
  printf("Total time taken for %d iterations: %fs\n", N_ITERATIONS, time_taken);
  printf("Average time for 1 iteration: %fs\n", time_taken/N_ITERATIONS);

  return 0;
}
