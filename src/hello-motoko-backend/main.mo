import Array "mo:base/Array"; 
import Nat "mo:base/Nat";     

actor HelloMotoko {
    public query func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

    public query func sortArray(arr: [Int]) : async [Int] {
        let n : Nat = arr.size();
        var sortedArr : [var Int] = Array.thaw<Int>(arr); 

        for (i in Array.tabulate<Nat>(n - 1, func(x : Nat) : Nat { x + 1 }).vals()) {  
            let key : Int = sortedArr[i];
            var j : Nat = i;  
            
            while (j > 0 and sortedArr[j - 1] > key) {
                sortedArr[j] := sortedArr[j - 1];
                j -= 1;
            };
            sortedArr[j] := key;
        };

        return Array.freeze(sortedArr); 
    };
};
