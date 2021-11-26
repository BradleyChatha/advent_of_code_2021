using System;
using System.Diagnostics;
using System.IO;

var watch = new Stopwatch();
var input = File.ReadAllText("./input.txt");
watch.Start();
Solution.Run(input);
watch.Stop();

Console.WriteLine("__TIME__ = {0}", watch.ElapsedMilliseconds * 1000);