#!/usr/bin/awk -f

{
  a[n++] = $1
}
END {
  for (i=1; i<=n; i++)
    for (j=i+1; j<=n; j++)
      for (k=j+1; k<=n; k++)
      if (a[i] + a[j] + a[k] == 2020) {
        printf("%s + %s + %s == %s (answer: %s)\n", a[i], a[j], a[k], a[i]+a[j]+a[k], a[i]*a[j]*a[k])
	exit
      }
  printf("Non found :(\n")
}
