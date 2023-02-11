import UIKit
import Foundation
//Swift Training Day 2 - Exercises

//2.1 First Numbers
//Write a function named first that takes an Int named N and returns an array with the first N numbers starting from 1. Use _ to ignore the argument label name.

func first(_ N: Int) -> [Int]? {
    guard N > 0 else {
        return nil
    }
    return [Int](1...N)
}

//2.2 Repeat Print
//Implement a function named repeatPrint that takes a string message and a integer count as parameters. The function should print the message count times and then print a newline. Add a 1 asdefault value for the count, then call it without this parameter.

func repeatPrint(message msg: String, count number: Int = 1) {
    //    for _ in 0..<number {
    //        print(msg)
    //    }
    //    print("\n")
    (0..<number).forEach({_ in
        print(msg)
    })
    print("\n")
}

//2.3 Parse number
//Write a function named parse(digit:) that takes a string with one character as parameter. The function should return -1 if the input is not a digit character and the digit otherwise.
// na to kanw me nil-coalescing

func parse(digit char: Character) -> Int {
    Int(String(char)) ?? -1
}

//2.3 Split the name
//Write a function split(name: String) that takes a name (e.g. "Jon Snow) as input and returns the first and the last name separated into a tuple with two elements. To split a string into an array with " " as separator.

func split(_ name: String) -> (Substring, Substring) {
    let arrayName = name.split(separator: " ")
    return (arrayName[0], arrayName[1])
}

//2.4 Correct Pairs
//Write a function named verify that takes a string expression of open and closed parentheses ((, )) and returns true if they are correctly paired and false otherwise. They should be equal ( and ) and there should not be more ) than ( at any given time

func verify2(_ expr: String) -> Bool {
    var counter = 0
    for index in expr.indices {
        if expr[index] == "(" {
            counter += 1
        }
        if expr[index] == ")" {
            counter -= 1
        }
        if counter < 0 {
            return false
        }
    }
    return counter == 0
}

//2.5 Queue
//A queue is a data structure that can perform two operations:
// push which takes a value and adds it at the end of the queue
// pop which returns the value from the start of the queue and removes it from the queue
//Your task is to implement the push and pop functions.
//The push function should take two parameters, the number and the queue as an inout parameter.
//The pop function should take queue as an inout parameter and return the first number from the queue after removing it. If the queue is empty it should return nil – the result type should be an optional integer(Int?).
//Use an array for storing the Ints

var queue: [Int] = []

func push(number num: Int, _ queue: inout [Int]) {
    queue.insert(num, at: 0)
}

func pop(_ queue: inout [Int]) -> Int? {
    queue.isEmpty ? nil : queue.removeLast()
}

//2.6 K Times
//Write a function named applyKTimes that takes an integer K and a closure and calls the closure K times. The closure will not take any parameters and will not have a return value, but it print a string.
//Call that method

func applyKTimes(_ K: Int, _ closure: () -> Void) {
    for _ in 0..<K {
        closure()
    }
}

// Trailing Closure
applyKTimes(7) {
    print("Hello, I am a trailing closure.")
}

//2.7 Custom map
//Write an intMap function that receives [Int] and a closure, it calls this closure for all items in the array and stores
//each result in an result array that return after it completes. Call it with a closure that converts the array to
//Doubles from Ints, Call it with a closure that doubles(x2) each Int value. When calling use the traling expression syntax

func intMap(_ array: [Int], _ closure: ([Int]) -> [Any]) {
    closure(array)
}

// Trailing closure for doubling each element
intMap([1, 2, 3], { array in
    var result: [Int] = []
    for i in 0..<array.count {
        result.append(array[i]*2)
    }
    return result
})

// Trailing closure for converting to Double
intMap([1, 2, 3], { array in
    var result: [Double] = []
    for i in 0..<array.count {
        result.append(Double(array[i]))
    }
    return result
})

//2.8 Custom Iterator
//Create a function with name makeCustomInterator that takes an array of Any an returns a function with no arguments that each time you call it will return the next element in the array, pass an array of 4 integers and call it 4 times to verify it works.
//Modify the above function to optionaly take a bool parameter named reversed, if true it will return a function that each time you call it will return the previous value starting from the last. The reversed should have default value false.
//Call the new method and use it to interate the array 4 times.
//Modify the above function to return optional Any?, if the next or previous element does not exist (out of bounds of the array) it should return nil

postfix operator ++
postfix func ++(x: inout Int) -> Int {
    x+=1
    return x
}

postfix operator --
postfix func --(x: inout Int) -> Int {
    x-=1
    return x
}

func makeCustomInterator(_ array: ([Any]), _ reversed: Bool = false) -> () -> Any? {
    var lastIndex = array.endIndex
    var startingIndex = array.startIndex - 1

    func getElement() -> Any? {
        // From last
        if reversed {
            return array.indices.contains(lastIndex--) ? array[lastIndex] : nil
        }
        // From start
        return array.indices.contains(startingIndex++) ? array[startingIndex] : nil
    }
    return getElement
}

let fromLastElement = makeCustomInterator([1, 2, 3, 4], true)
let nextElement = makeCustomInterator([1, 2, 3, 4])
fromLastElement()
fromLastElement()
fromLastElement()
fromLastElement()
fromLastElement()
nextElement()
nextElement()
nextElement()
nextElement()
nextElement()

//2.9 Day of the week
//Create an enum of the days of the week, with appropriate raw values

enum Days: Int {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
}

//2.10 TimeUnit
// 10. Create enum of TimeUnit with values Second, Minute, Hour, Day and Week.
// Add a method for converting between them. e.g. TimeUnit.Day.convertTo(TimeUnit.Hour) == 24.0

enum TimeUnit {
    case Second, Minute, Hour, Day, Week
    
    func convertTo(_ to: TimeUnit) -> Int? {
        switch self {
        case .Minute:
            if to == .Second {
                return 3600
            } else if to == .Minute {
                return 1
            } else {
                return nil
            }
        case .Second:
            if to == .Second {
                return 1
            }
            return nil
        case .Hour:
            if to == .Second {
                return 86400
            } else if to == .Minute {
                return 60
            } else if to == .Hour {
                return 1
            } else {
                return nil
            }
        case .Day:
            if to == .Second {
                return 86400
            } else if to == .Minute {
                return 1440
            } else if to == .Hour {
                return 24
            } else if to == .Day {
                return 1
            } else {
                return nil
            }
        case .Week:
            if to == .Second {
                return 86400*7
            } else if to == .Minute {
                return 1440*7
            } else if to == .Hour {
                return 24*7
            } else if to == .Day {
                return 1*7
            }else {
                return 1
            }
        }
    }
}

var fromDayToSecond = TimeUnit.Day.convertTo(.Second)
var fromWeekToDay = TimeUnit.Week.convertTo(.Day)
var fromWeekToSeconds = TimeUnit.Week.convertTo(.Second)
var fromDayToMinutes = TimeUnit.Day.convertTo(.Minute)

//2.11 Rock, Paper, Scissors
//1) Define an enumeration named HandShape with three members: .rock, .paper, .scissors.
//2) Define an enumeration named MatchResult with three members: .win, .draw, .lose.
//3) write a function called match that takes two hand shapes and returns a match result. It should return the outcome for the first player (the one with the first hand shape).

enum HandShape {
    case rock, paper, scissors
}

enum MatchResult {
    case win, draw, lose
}

func match(firstPlayer handShape1: HandShape, secondPlayer handShape2: HandShape) -> MatchResult {
    switch handShape1{
    case .paper:
        if handShape2 == .paper {
            return .draw
        } else if handShape2 == .rock {
            return .win
        } else {
            return .lose
        }
    case .rock:
        if handShape2 == .paper {
            return .lose
        } else if handShape2 == .rock {
            return .draw
        } else {
            return .win
        }
    case .scissors:
        if handShape2 == .paper {
            return .win
        } else if handShape2 == .rock {
            return .lose
        } else {
            return .draw
        }
    }
}

let firstGame = match(firstPlayer: .rock, secondPlayer: .rock)
let secondGame = match(firstPlayer: .rock, secondPlayer: .paper)
let thirdGame = match(firstPlayer: .scissors, secondPlayer: .paper)

//2.12 Deck of cards
//A card in a deck has a suite(diamonds,clubs,hearts,spades) and a rank which is a Number(from 2 to 10) or one of the following values Jack,Queen,King,Ace.
//Create a enum type of the suite and the rank. Create a tuple typealias for a Card. Create an array with all the cards of a deck and print their values(e.g. 4 of diamonds, Queen of hearts).

enum Suit: String {
    case diamonds = "\u{2662}", clubs = "\u{2663}", hearts = "\u{2661}", spades = "\u{2660}"
}

enum Rank {
    case number(Int)
    case faceCards(String)
}

typealias Card = (rank: Rank, suit: Suit)
var cards: [Card] = []

// Initialize arrays for suites, numbers for cards, facecard symbols
let suitsArray: [Suit] = [Suit.diamonds, Suit.clubs, Suit.hearts, Suit.spades]

var ranks: [Rank] = [.faceCards("J"), .faceCards("Q"), .faceCards("K"), .faceCards("A")]
(2..<11).forEach { number in ranks.append(Rank.number(number)) }

// Now create all deck cards, like [Card(faceCards("J"), diamonds), Card({number 2}, spades)]...
cards = ranks.flatMap { suit in
    suitsArray.map { rank in (suit, rank) }
}

func printDeck(_ cards: [Card]) {
    for card in cards {
        var temp: Any = 0
        if case let .faceCards(str) = card.rank {
            temp = str
        }
        if case let .number(num) = card.rank {
            temp = num
        }
        print("\(temp)\(card.suit.rawValue)")
    }
}

printDeck(cards)
