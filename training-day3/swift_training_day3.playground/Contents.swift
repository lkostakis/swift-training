//3.0
//You have array of items and you what to print ony the strings that contain the string swift. Use the String contains method (it available from iOS 8.0+)
let swifts : Any = ["Suzuki Swift", 42, "Taylor Swift", "Maruti Swift", "someValue"]

//3.1 grading
//You need to write a function that takes an array of exams grades scores with value from 0 to 100 return the grade character for it (A - F). less or equal to 60 is F and then it uses the next character for each 10 points. Use pattern matching with ranges, the array will contain the grades as Ints or Strings and will contain nil values(you should count them as zero)
let grades : [Any?] = [10, 55, 80, nil, "90", 100, 66, "42", 78, 89]

//3.1 Legacy API
//Create a legacyLoginAPI function that takes a username/password and returns one of the following
//For username 'newUser'
//a User object with 3 variables first,last name,last password change date
//For username 'oldUser'
//a UserLegacy object with 2 variables first and last name,last password change date
//For any other username
//a Error object with a string error description

//3.2 Legacy API Cont.
//Write code that handles the legacyLoginAPI reponse with the following logic:
//If it returns Error print it.
//If it returns A user that has not change it's password for 6 months print "Please change your password"
//Else print "Wellcome <first Name last name>"

//3.3 The calculator
//Write a Class with name Calculator that parses a String with a simple arithmetic operation(+ and *) and calculates the result e.g. "1+4", all the operands will be integers
//The class should have a method that registers a closure that performs an operation for an operand("+","*" etc.). All registered closures take two integers and return an other.
//If the operation is already registed it will replace it and print an warning message. It should check that the operand is not empty.
//The class should have a method with name calculate that takes a string and returns the result, if no valid operation is found it should print a relevant method.

//3.4 Points & Rectangles
//Create a type that for a Point coordinate, when create a type that for a Rectangle (use the Point)
//Add a pair of methods(mutating and non-mutating) in the Rectangle that will translate(e.g. move) a Rectangle from it's origin by an offset Point(x,y)
//Add a pair of methods(mutating and non-mutating that will check if two Rectangles overlap
//Add a method that will return the distance of a Point from the Axis centre 0,0
//Add a method that will return the distance of a Point from an other Point

//3.5 Phone and battery
//Create a type to represent a Phone, it should have a name, a batteryCharge and a display resolution as properties.
//You can use the phone for 6 activities (Call,Video,Photo,GPS,Screen, Charge) each reduces the charge at specific rate per minute (0.5, 3.5, 1.5, 2.5, 2.0, -5.5)
//Create a method that will peform an activity for x minutes. This method will print "consumed <X> battery for <Activity name>" if there is enough battery, then is should reduce the remaining battery charge
//if not it will print not enough energy for <x> minutes of <Activity>.

//3.6 Poker Game
//Create a Player Object that has a name, and an array of Cards (from the 2.12 exercise Deck of cards)
//Create a PokerEngine Object that will have
//a init method that adds an array of Players
//a method deal that give 5 random cards to each player
//The player should print the each card's name when it is given, use property observers
