//3.0
//You have array of items and you what to print ony the strings that contain the string swift. Use the String contains method (it available from iOS 8.0+)

import Foundation

let swifts : [Any] = ["Suzuki Swift", 42, "Taylor Swift", "Maruti Swift", "someValue"]

for element in swifts {
    if let substring = element as? String {
        if substring.contains("Swift") {
            print(substring)
        }
    }
}

//3.1 grading
//You need to write a function that takes an array of exams grades scores with value from 0 to 100 return the grade character for it (A - F). less or equal to 60 is F and then it uses the next character for each 10 points. Use pattern matching with ranges, the array will contain the grades as Ints or Strings and will contain nil values(you should count them as zero)
let grades : [Any?] = [10, 55, 80, nil, "90", 100, 66, "42", 78, 89]

// 0-60: F
// 60-70: D
// 70-80: C
// 80-90: B
// 90-100: A

func evaluate(_ grades: [Any?]) -> [Character] {
    var gradesEvaluated: [Character] = []
    for element in grades {
        if let num = element as? Int {
            gradesEvaluated.append(mapToChar(num))
        } else if let string = element as? String, let num = Int(string) {
            // Could skip 'let num Int(String)' and force unwrap Int(string)! here
            // but it's a bad pracice, as it's runtime error when grade is a
            // String? non-convertible to Int, e.g: "ACX" and so on...
            // (Assume non-convertible String? returns "F" grade)
            gradesEvaluated.append(mapToChar(num))
        } else {
            gradesEvaluated.append("F")
        }
    }
    
    func mapToChar(_ num: Int) -> Character {
        if (0...60).contains(num) {
            return "F"
        } else if (61...70).contains(num) {
            return "D"
        } else if (71...80).contains(num) {
            return "C"
        } else if (81...90).contains(num) {
            return "B"
        } else {
            return "A"
        }
    }
    return gradesEvaluated
}

evaluate(grades)

//3.2 Legacy API
//Create a legacyLoginAPI function that takes a username/password and returns one of the following
//For username 'newUser'
//a User object with 3 variables first,last name,last password change date
//For username 'oldUser'
//a UserLegacy object with 2 variables first and last name,last password change date
//For any other username
//a Error object with a string error description

protocol UserCredentials {
    var firstName: String { get }
    var lastName: String { get }
    var passwordChangeDate: Date? { get }
}

struct ErrorResponse {
    let code: Int
    let message: String
}

enum UserCredentialsError : Error {
    case invalidUsername(ErrorResponse)
}

extension Date {
    var displayFormat: String {
        formatted(date: .numeric, time: .complete)
    }
}

extension DateFormatter {
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

class User : UserCredentials {
    var firstName, lastName: String
    var passwordChangeDate: Date?
    
    init(firstName: String, lastName: String, passwordChangeDate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.passwordChangeDate = DateFormatter.dateOnly.date(from: passwordChangeDate)
    }
}

class UserLegacy : UserCredentials {
    var firstName, lastName:String
    var passwordChangeDate: Date?
    
    init(firstName: String, lastName: String, passwordChangeDate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.passwordChangeDate = DateFormatter.dateOnly.date(from: passwordChangeDate)
    }
}

func legacyLoginAPI(_ username: String, _ password: String) throws -> UserCredentials {
    
    if username == "newUser" {
        return User(firstName: "Kostas", lastName: "Lambrou", passwordChangeDate: "12/23/2022")
    } else if username == "oldUser" {
        return UserLegacy(firstName: "Mitsos", lastName: "Dimitriou", passwordChangeDate: "08/09/2004")
    } else {
        // Throw Unauthorized Client Error
        throw UserCredentialsError.invalidUsername(ErrorResponse(code: 401, message: "WRONG USER NAME GIVEN."))
    }
}

//3.3 Legacy API Cont.
//Write code that handles the legacyLoginAPI reponse with the following logic:
//If it returns Error print it.
//If it returns A user that has not change it's password for 6 months print "Please change your password"
//Else print "Wellcome <first Name last name>"

do {
    var monthComponent    = DateComponents()
    monthComponent.month    = -6 // For removing one day (yesterday): -1
    let theCalendar     = Calendar.current
    let nextDate        = theCalendar.date(byAdding: monthComponent, to: Date())
    print("nextDate : \(String(describing: nextDate?.displayFormat))")
    
    var validUser = try legacyLoginAPI("newUser", "123456") // valid UserCredentials
    var validUserLegacy = try legacyLoginAPI("oldUser", "123456") // valid UserCredentials
    if nextDate! < Date.now {
        print("Please change your password.")
    } else {
        print("Welcome \(validUser.firstName) \(validUser.lastName)")
    }
    try legacyLoginAPI("wrongUsername", "123456") // Invalid UserCredentials
} catch UserCredentialsError.invalidUsername(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)", terminator: "")
}

//3.4 The calculator
//Write a Class with name Calculator that parses a String with a simple arithmetic operation(+ and *) and calculates the result e.g. "1+4", all the operands will be integers
//The class should have a method that registers a closure that performs an operation for an operand("+","*" etc.). All registered closures take two integers and return an other.
//If the operation is already registed it will replace it and print an warning message. It should check that the operand is not empty.
//The class should have a method with name calculate that takes a string and returns the result, if no valid operation is found it should print a relevant method.

//3.5 Points & Rectangles
//Create a type that for a Point coordinate, when create a type that for a Rectangle (use the Point)
//Add a pair of methods(mutating and non-mutating) in the Rectangle that will translate(e.g. move) a Rectangle from it's origin by an offset Point(x,y)
//Add a pair of methods(mutating and non-mutating that will check if two Rectangles overlap
//Add a method that will return the distance of a Point from the Axis centre 0,0
//Add a method that will return the distance of a Point from an other Point

//3.6 Phone and battery
//Create a type to represent a Phone, it should have a name, a batteryCharge and a display resolution as properties.
//You can use the phone for 6 activities (Call,Video,Photo,GPS,Screen, Charge) each reduces the charge at specific rate per minute (0.5, 3.5, 1.5, 2.5, 2.0, -5.5)
//Create a method that will peform an activity for x minutes. This method will print "consumed <X> battery for <Activity name>" if there is enough battery, then is should reduce the remaining battery charge
//if not it will print not enough energy for <x> minutes of <Activity>.

//3.7 Poker Game
//Create a Player Object that has a name, and an array of Cards (from the 2.12 exercise Deck of cards)
//Create a PokerEngine Object that will have
//a init method that adds an array of Players
//a method deal that give 5 random cards to each player
//The player should print the each card's name when it is given, use property observers
