module Solution
open System

let S1 (input : seq<string * int>) =
    let horiz = input 
                |> Seq.map (fun tup -> 
                    match tup with
                    | ("forward", n) -> n
                    | _ -> 0
                )
                |> Seq.sum
    let vert = input 
                |> Seq.map (fun tup -> 
                    match tup with
                    | ("up", n) -> -n
                    | ("down", n) -> n
                    | _ -> 0
                )
                |> Seq.sum

    Console.WriteLine("__S1__ = {0}", horiz * vert)

let S2 input =
    let mutable horiz = 0
    let mutable vert = 0
    let mutable aim = 0

    for tup in input do
        match tup with
        | ("up", n) -> aim <- aim - n
        | ("down", n) -> aim <- aim + n
        | ("forward", n) ->
            horiz <- horiz + n
            vert <- vert + (n * aim)
        | _ -> failwith "Bad case"

    Console.WriteLine("__S2__ = {0}", horiz * vert)

let Solution (input : string) =
    let values = (input.Split '\n') 
                 |> Seq.map (fun line -> line.Split ' ')
                 |> Seq.map (fun segments -> (segments.[0], int(segments.[1])))
    S1 values
    S2 values