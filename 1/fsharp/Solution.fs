module Solution
open System

let S1 (input : string) = 
    let split = input.Split [| '\n' |]
    let numbers = split |> Seq.map int
    let enumerator = numbers.GetEnumerator()

    enumerator.MoveNext() |> ignore
    let mutable lastValue = enumerator.Current
    let mutable count = 0

    while enumerator.MoveNext() do
        if enumerator.Current > lastValue then
            count <- count + 1
        lastValue <- enumerator.Current
    
    Console.WriteLine ("__S1__ = {0}", count)
    ()

let S2 (input : string) =
    let enumerator = (input.Split [| '\n' |] |> Seq.map int).GetEnumerator()
    
    let rec doThing prev lll ll l =
        let sum = lll + ll + l
        let res = if sum > prev then 1 else 0

        if enumerator.MoveNext() then
            res + (doThing sum ll l enumerator.Current)
        else
            res
    
    enumerator.MoveNext() |> ignore
    let lll = enumerator.Current
    enumerator.MoveNext() |> ignore
    let ll = enumerator.Current
    enumerator.MoveNext() |> ignore
    let l = enumerator.Current
    let sum = lll + ll + l

    enumerator.MoveNext() |> ignore
    let res = doThing sum ll l enumerator.Current

    Console.WriteLine("__S2__ = {0}", res)
    ()
    
let Solution input =
    S1 input
    S2 input
    ()