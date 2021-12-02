import std, std.datetime.stopwatch;

void main()
{
    auto input = readText("./input.txt");
    auto times = benchmark!(()=>runSolution(input))(1);
    writeln("__TIME__ = ", times[0].total!"usecs");
}

void runSolution(string input)
{
    static struct S { string direction; int amount; }
    auto range = input.splitter('\n')
                      .map!(s => s.splitter(' '))
                      .map!((r){
                          S s;
                          s.direction = r.front;
                          r.popFront();
                          s.amount = r.front.to!int;
                          return s;
                      });
    s1(range);
    s2(range);
}

void s1(R)(R range)
{
    int horiz;
    int vert;

    range.each!((s){
        final switch(s.direction)
        {
            case "up": vert -= s.amount; break;
            case "down": vert += s.amount; break;
            case "forward": horiz += s.amount; break;
        }
    });

    writeln("__S1__ = ", horiz * vert);
}

void s2(R)(R range)
{
    int horiz;
    int vert;
    int aim;

    range.each!((s){
        final switch(s.direction)
        {
            case "up": aim -= s.amount; break;
            case "down": aim += s.amount; break;
            case "forward": horiz += s.amount; vert += s.amount * aim; break;
        }
    });

    writeln("__S2__ = ", horiz * vert);
}