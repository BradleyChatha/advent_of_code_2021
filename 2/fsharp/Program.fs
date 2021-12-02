open System
open System.Diagnostics
open System.IO

[<EntryPoint>]
let main argv =
    let watch = new Stopwatch();
    let input = File.ReadAllText("../input.txt");
    watch.Start();
    Solution.Solution input
    watch.Stop();

    Console.WriteLine($"__TIME__ = {watch.ElapsedMilliseconds * 1000L}");
    0