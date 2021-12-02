def solution(input: str):
    values = [(split[0], int(split[1])) for split in (
        line.split(' ') for line in input.splitlines())]
    s1(values)
    s2(values)


def s1(values: list[tuple[str, int]]):
    horiz = sum(tup[1] for tup in values if tup[0] == "forward")
    vert = sum(
        (tup[0] == "up" and -tup[1] or tup[1]) for tup in values if tup[0] != "forward"
    )

    print("__S1__ = %d" % (horiz*vert))


def s2(values: list[tuple[str, int]]):
    horiz = 0
    vert = 0
    aim = 0
    
    for tup in values:
        if tup[0] == "forward":
            horiz += tup[1]
            vert += tup[1] * aim
        elif tup[0] == "down":
            aim += tup[1]
        else:
            aim -= tup[1]

    print("__S2__ = %d" % (horiz * vert))
