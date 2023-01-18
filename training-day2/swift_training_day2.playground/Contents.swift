import UIKit
import Foundation
//Swift Training Day 2 - Exercises

//2.1 First Numbers
//Write a function named first that takes an Int named N and returns an array with the first N numbers starting from 1. Use _ to ignore the argument label name.
func first(_ N: Int) -> [Int] {
    [Int](1...N)
}

//2.2 Repeat Print
//Implement a function named repeatPrint that takes a string message and a integer count as parameters. The function should print the message count times and then print a newline. Add a 1 asdefault value for the count, then call it without this parameter.
func repeatPrint(message msg: String, count number: Int = 1) {
    for _ in 0..<number {
        print(msg)
    }
}

//2.3 Parse number
//Write a function named parse(digit:) that takes a string with one character as parameter. The function should return -1 if the input is not a digit character and the digit otherwise.
func parse(digit char: Character) -> Int {
    if let num = char.isNumber {
        return Int(String(num))
    }
    return -1
}
let x = parse(digit: "1")
let y = parse(digit: "2")


//2.3 Split the name
//Write a function split(name: String) that takes a name (e.g. "Jon Snow) as input and returns the first and the last name separated into a tuple with two elements. To split a string into an array with " " as separator.

//2.4 Correct Pairs
//Write a function named verify that takes a string expression of open and closed parentheses ((, )) and returns true if they are correctly paired and false otherwise. They should be equal ( and ) and there should not be more ) than ( at any given time

//2.5 Queue
//A queue is a data structure that can perform two operations:
// push which takes a value and adds it at the end of the queue
// pop which returns the value from the start of the queue and removes it from the queue
//Your task is to implement the push and pop functions.
//The push function should take two parameters, the number and the queue as an inout parameter.
//The pop function should take queue as an inout parameter and return the first number from the queue after removing it. If the queue is empty it should return nil – the result type should be an optional integer(Int?).
//Use an array for storing the Ints

//2.6 K Times
//Write a function named applyKTimes that takes an integer K and a closure and calls the closure K times. The closure will not take any parameters and will not have a return value, but it print a string.
//Call that method

//2.7 Custom map
//Write an intMap function that receives [Int] and a closure, it calls this closure for all items in the array and stores
//each result in an result array that return after it completes. Call it with a closure that converts the array to
//Doubles from Ints, Call it with a closure that doubles(x2) each Int value. When calling use the traling expression syntax

//2.8 Custom Iterator
//Create a function with name makeCustomInterator that takes an array of Any an returns a function with no arguments that each time you call it will return the next element in the array, pass an array of 4 integers and call it 4 times to verify it works.
//Modify the above function to optionaly take a bool parameter named reversed, if true it will return a function that each time you call it will return the previous value starting from the last. The reversed should have default value false.
//Call the new method and use it to interate the array 4 times.
//Modify the above function to return optional Any?, if the next or previous element does not exist (out of bounds of the array) it should return nil

//2.9 Day of the week
//Create an enum of the days of the week, with appropriate raw values

//2.10 TimeUnit
// 10. Create enum of TimeUnit with values Second, Minute, Hour, Day and Week.
// Add a method for converting between them. e.g. TimeUnit.Day.convertTo(TimeUnit.Hour) == 24.0

//2.11 Rock, Paper, Scissors
//1) Define an enumeration named HandShape with three members: .rock, .paper, .scissors.
//2) Define an enumeration named MatchResult with three members: .win, .draw, .lose.
//3) write a function called match that takes two hand shapes and returns a match result. It should return the outcome for the first player (the one with the first hand shape).

//2.12 Deck of cards
//A card in a deck has a suite(diamonds,clubs,hearts,spades) and a rank which is a Number(from 2 to 10) or one of the following values Jack,Queen,King,Ace.
//Create a enum type of the suite and the rank. Create a tuple typealias for a Card. Create an array with all the cards of a deck and print their values(e.g. 4 of diamonds, Queen of hearts).
