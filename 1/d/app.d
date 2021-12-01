import std, std.datetime.stopwatch;

int g_s1, g_s2;

void main()
{
    auto input = readText("./input.txt");
    auto times = benchmark!(()=>runSolution(input))(1);
    writeln("__TIME__ = ", times[0].total!"usecs");
    writeln("__S1__   = ", g_s1);
    writeln("__S2__   = ", g_s2);
}

void runSolution(string input)
{
    s1(input);
    s2(input);
}

void s1(string input)
{
    int last;
    int count;
    auto numbers = input.splitter('\n').map!(to!int);
    last = numbers.front;
    numbers.popFront();

    numbers.each!((n){
        count += (n > last);
        last = n;
    });

    g_s1 = count;
}

void s2(string input)
{
    const numbers = input.splitter('\n').map!(to!int).array;
    int last;
    foreach(n; 3..numbers.length)
    {
        const sum = numbers[n-2] + numbers[n-1] + numbers[n];
        g_s2 += (sum > last);
        last = sum;
    }
}