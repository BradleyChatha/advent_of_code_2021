import time
from solution import solution

input = ""
with open("input.txt", "rb") as f:
    input = f.read().decode("utf-8")

start = time.time()
solution(input)
end = time.time()
print("__TIME__ = %d" % ((end-start) * 1000000))