using System;
using System.Linq;

static class Solution
{
    public static void Run(string input)
    {
        S1(input);
        S2(input);
    }

    static void S1(string input)
    {
        int lastValue = -1;
        int count = 0;
        foreach(var num in input.Split("\n").Select(str => Convert.ToInt32(str)))
        {
            if(lastValue == -1)
            {
                lastValue = num;
                continue;
            }

            if(num > lastValue)
                count++;
            lastValue = num;
        }

        Console.WriteLine("__S1__ = {0}", count);
    }

    static void S2(string input)
    {
        var numbers = input.Split("\n").Select(str => Convert.ToInt32(str)).ToArray();
        int lastSum = -1;
        int count = 0;
        for(int i = 2; i < numbers.Length; i++)
        {
            int sum = numbers[i-2] + numbers[i-1] + numbers[i];
            if(lastSum != -1 && sum > lastSum)
                count++;
            lastSum = sum;
        }

        Console.WriteLine("__S2__ = {0}", count);
    }
}