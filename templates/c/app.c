#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "solution.h"

long long getTimeAsUSecs()
{
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return (t.tv_sec * 1000000) + (t.tv_nsec / 1000);
}

int main()
{
    FILE* file = fopen("./input.txt", "rb");
    if(!file)
    {
        perror("Could not open file");
        return -1;
    }

    fseek(file, SEEK_END, 0);
    const long inputLen = ftell(file);
    fseek(file, SEEK_SET, 0);

    char* input = (char*)malloc(inputLen+1);
    *(input + inputLen) = '\0';
    fread(input, inputLen, 1, file);

    const long long start = getTimeAsUSecs();
    solution(input, inputLen);
    const long long end = getTimeAsUSecs();

    printf("__TIME__ = %lld\n", end-start);
    free(input);
    return 0;
}
