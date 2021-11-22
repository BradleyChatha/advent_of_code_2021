import std, std.datetime.stopwatch;

void main()
{
    auto input = readText("./input.txt");
    auto times = benchmark!(()=>runSolution(input))(1);
    writeln("__TIME__ = ", times[0].total!"usecs");
}

void runSolution(string input)
{
}