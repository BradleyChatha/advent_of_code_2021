#include <stdio.h>

typedef struct Movement
{
    char direction;
    int amount;
} Movement;

Movement nextMovement(const char* input, char const** nextInput)
{
    Movement m = {};

    m.direction = *input;
    switch(m.direction)
    {
        case 'f':
            input += 8;
            break;
        case 'u':
            input += 3;
            break;
        case 'd':
            input += 5;
            break;

        default: __builtin_trap();
    }

    char num = *input;
    num &= 0x0F;
    m.amount = num;

    input += 2;
    *nextInput = input;

    return m;
}

void s1(const char* input, long long inputLen)
{
    int horiz = 0, vert = 0;

    const char* end = input + inputLen;
    while(input < end)
    {
        Movement m = nextMovement(input, &input);
        switch(m.direction)
        {
            case 'f':
                horiz += m.amount;
                break;
            case 'u':
                vert -= m.amount;
                break;
            case 'd':
                vert += m.amount;
                break;

            default: __builtin_trap();
        }
    }

    printf("__S1__ = %d\n", horiz * vert);
}

void s2(const char* input, long long inputLen)
{
    int horiz = 0, vert = 0, aim = 0;

    const char* end = input + inputLen;
    while(input < end)
    {
        Movement m = nextMovement(input, &input);
        switch(m.direction)
        {
            case 'f':
                horiz += m.amount;
                vert += aim * m.amount;
                break;
            case 'u':
                aim -= m.amount;
                break;
            case 'd':
                aim += m.amount;
                break;

            default: __builtin_trap();
        }
    }

    printf("__S2__ = %d\n", horiz * vert);
}

void solution(const char* input, long long inputLen)
{
    s1(input, inputLen);
    s2(input, inputLen);
}