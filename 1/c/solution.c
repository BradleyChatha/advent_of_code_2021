#include <stdio.h>
#include <stdlib.h>

void s1(const char* input, long long inputLen)
{
    #pragma GCC diagnostic ignored "-Wdiscarded-qualifiers"
    char* mutableInput = input;

    // Hard assumption: All inputs have a 3 digit number to start off with
    mutableInput[3] = '\0';
    const char* initNumber = mutableInput;
    mutableInput += 4;

    int lastNumber = atoi(initNumber);
    int count = 0;

    while(mutableInput < input + inputLen)
    {
        const char* nextNumber = mutableInput;
        if(mutableInput[3] != '\n')
        {
            mutableInput[4] = '\0';
            mutableInput += 5;
        }
        else
        {
            mutableInput[3] = '\0';
            mutableInput += 4;
        }

        const int number = atoi(nextNumber);
        count += (number > lastNumber);
        lastNumber = number;
    }

    printf("__S1__ = %d\n", count);
}

void s2(const char* input, long long inputLen)
{
    const char* currInput = input;
    int count = 0;

    #define NEXT \
        {const int offset = 4 + (1 * (currInput[3] != '\0')); \
        currInput += offset;}

    int lastLastLastValue = atoi(currInput);
    NEXT
    int lastLastValue = atoi(currInput);
    NEXT
    int lastValue = atoi(currInput);
    NEXT

    int lastSum = lastLastLastValue + lastLastValue + lastValue;

    while(currInput < input + inputLen)
    {
        lastLastLastValue = lastLastValue;
        lastLastValue = lastValue;
        lastValue = atoi(currInput);
        NEXT

        const int sum = lastLastLastValue + lastLastValue + lastValue;
        count += (sum > lastSum);
        lastSum = sum;
    }

    printf("__S2__ = %d\n", count);
}

void solution(const char* input, long long inputLen)
{
    s1(input, inputLen);
    s2(input, inputLen);
}