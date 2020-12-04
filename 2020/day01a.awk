#!/usr/bin/awk -f

{
  a[n++] = $1
}
END {
  for (i=1; i<=n; i++)
    for (j=i+1; j<=n; j++)
      if (a[i] + a[j] == 2020) {
        printf("%s + %s == %s (answer: %s)\n", a[i], a[j], a[i]+a[j], a[i]*a[j])
	exit
      }

  printf("Non found :(\n")
}
