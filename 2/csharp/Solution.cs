using System;
using System.Collections.Generic;
using System.Linq;

static class Solution
{
    public static void Run(string input)
    {
        var data = input.Split('\n')
                        .Select(line => line.Split(' '))
                        .Select(arr => (arr[0], Convert.ToInt32(arr[1])));
        S1(data);
        S2(data);
    }

    public static void S1(IEnumerable<(string, int)> input)
    {
        int horiz = input.Where(tup => tup.Item1 == "forward").Select(tup => tup.Item2).Sum();
        int vert  = input.Where(tup => tup.Item1 != "forward")
                         .Select(tup => tup.Item1 == "up" ? -tup.Item2 : tup.Item2)
                         .Sum();
        Console.WriteLine("__S1__ = {0}", horiz * vert);
    }

    public static void S2(IEnumerable<(string, int)> input)
    {
        int horiz = 0, vert = 0, aim = 0;

        foreach(var tup in input)
        {
            if(tup.Item1 == "up")
                aim -= tup.Item2;
            else if(tup.Item1 == "down")
                aim += tup.Item2;
            else
            {
                horiz += tup.Item2;
                vert += tup.Item2 * aim;
            }
        }

        Console.WriteLine("__S2__ = {0}", horiz * vert);
    }
}