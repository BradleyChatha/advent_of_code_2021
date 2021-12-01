def solution(input: str):
    s1(input)
    s2(input)

def s1(input: str):
    lines = input.splitlines()
    numbers = [int(x) for x in lines]
    lastValue = -1
    count = 0

    for num in numbers:
        if lastValue != -1 and num > lastValue:
            count = count + 1
        lastValue = num
    print("__S1__ = %d" % count)

def s2(input: str):
    lines = input.splitlines()
    numbers = [int(x) for x in lines]
    lastSum = numbers[0] + numbers[1] + numbers[2]
    count = 0

    for i in range(2, len(numbers)):
        sum = numbers[i-2] + numbers[i-1] + numbers[i]
        if sum > lastSum:
            count = count + 1
        lastSum = sum
    print("__S2__ = %d" % count)