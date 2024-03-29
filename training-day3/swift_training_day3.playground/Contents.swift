//3.0
//You have array of items and you what to print ony the strings that contain the string swift. Use the String contains method (it available from iOS 8.0+)

import Foundation

let swifts : [Any] = ["Suzuki Swift", 42, "Taylor Swift", "Maruti Swift", "someValue"]

swifts.forEach { element in
    if let substring = element as? String, substring.contains("Swift") { print(element) } }

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

protocol UserInfo {
    var firstName: String { get }
    var lastName: String { get }
}

struct ErrorResponse {
    let code: Int
    let message: String
}

enum UserCredentialsError : Error {
    case invalidUsername(ErrorResponse)
}

enum DateError: Error {
    case invalidDate(ErrorResponse)
}

extension Date {
    var displayFormat: String {
        formatted(date: .numeric, time: .omitted)
    }
}

extension DateComponents {
    static let minusSixMonths: Date? = {
        var monthComponent = DateComponents()
        monthComponent.month = -6
        let gregorianCalendar = Calendar.current
        let resultDate = gregorianCalendar.date(byAdding: monthComponent, to: Date.now)
        return resultDate
    }()
}

extension DateFormatter {
    static let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

class UserLegacy : UserInfo {
    var firstName, lastName: String

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class User : UserInfo {
    var firstName: String {
        get {
            self.userLegacy.firstName
        }
    }
    var lastName: String {
        get {
            self.userLegacy.lastName
        }
    }
    var passwordChangeDate: Date?
    var userLegacy: UserLegacy
    
    init(firstName: String, lastName: String, passwordChangeDate: String) {
        self.userLegacy = UserLegacy(firstName: firstName, lastName: lastName)
        self.passwordChangeDate = DateFormatter.dateOnlyFormatter.date(from: passwordChangeDate)
    }
}

func legacyLoginAPI(_ username: String, _ password: String) throws -> UserInfo {
    
    if username == "newUser" {
        // if wrong date(MM-dd-yyyy) format given, invalidDate error is thrown later
        return User(firstName: "Kostas", lastName: "Lambrou", passwordChangeDate: "10/29/2022")
    } else if username == "oldUser" {
        return UserLegacy(firstName: "Mitsos", lastName: "Dimitriou")
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

func checkPasswordChange(from date: Date?) throws -> Bool {
    guard let dateMinusSixMonths = DateComponents.minusSixMonths,
          let date = date else {
        throw DateError.invalidDate(ErrorResponse(code: 411, message: "DATE GIVEN ERROR."))
    }
    
    if dateMinusSixMonths < date {
        return false
    }
    return true
}

do {
    let validUserLegacy = try legacyLoginAPI("oldUser", "123456")
    let validUser = try legacyLoginAPI("newUser", "123456")// valid UserCredentials case

    if try checkPasswordChange(from: (validUser as? User)?.passwordChangeDate) {
        print("Please change your password.")
    } else {
        print("Welcome \(validUser.firstName) \(validUser.lastName), last password change on: " +
              "\((validUser as? User)?.passwordChangeDate?.displayFormat ?? "No password change yet").")
    }
    
    try legacyLoginAPI("wrongUsername", "123456") // Invalid UserCredentials
} catch UserCredentialsError.invalidUsername(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)")
}

//3.4 The calculator
//Write a Class with name Calculator that parses a String with a simple arithmetic operation(+ and *) and calculates the result e.g. "1+4", all the operands will be integers
//The class should have a method that registers a closure that performs an operation for an operand("+","*" etc.). All registered closures take two integers and return an other.
//If the operation is already registed it will replace it and print an warning message. It should check that the operand is not empty.
//The class should have a method with name calculate that takes a string and returns the result, if no valid operation is found it should print a relevant method.

extension String {
    static func isArithmeticExpression(_ str: String) -> Character? {
        if str.contains("+") {
            return "+"
        } else if str.contains("*") {
            return "*"
        } else {
            return nil
        }
    }
}

struct CalcErrorResponse {
    var code: Int
    var message: String
}

enum CalculatorError : Error {
    case invalidExpressionError(CalcErrorResponse)
    case invalidOperationError(CalcErrorResponse)
}

class Calculator {
    var multiplicationOperation: ((Int, Int) -> Int)? {
        didSet {
            if oldValue != nil {
                print("Warning: overriding previous multiplication method.")
            }
        }
    }
    var additionOperation: ((Int, Int) -> Int)? {
        didSet {
            if oldValue != nil {
                print("Warning: overriding previous addition method.")
            }
        }
    }
    var arithmeticOperator: String = ""
    
    func arithmeticOperation() throws -> ((Int, Int) -> Int)? {
        guard additionOperation != nil || multiplicationOperation != nil else {
            throw CalculatorError.invalidOperationError(CalcErrorResponse(code: 422, message: "All operations are not defined yet."))
        }
        
        if arithmeticOperator == "+" {
            return additionOperation
        } else {
            return multiplicationOperation
        }
    }
    
    func calculate(_ expression: String) throws -> Int? {
        // Check operation symbol('+' or '*') and its index in the expression has value
        guard let operSymbol = String.isArithmeticExpression(expression),
              let operSymbolIndex = expression.firstIndex(of: operSymbol) else {
            throw CalculatorError.invalidExpressionError(CalcErrorResponse(code: 423, message: "No valid symbol('+','*') found."))
        }
        
        let firstOperand = Int(expression[expression.startIndex...expression.index(before: operSymbolIndex)]) // Get left Int operand
        let secondOperand = Int(expression[expression.index(after: operSymbolIndex)...]) // Get right Int operand
        arithmeticOperator = String(operSymbol) // Set operation symbol
        if let firstOperand = firstOperand, let secondOperand = secondOperand, let operationToExecute = try arithmeticOperation() {
            return operationToExecute(firstOperand, secondOperand)
        }
        throw CalculatorError.invalidExpressionError(CalcErrorResponse(code: 424, message: "No left/right operand found."))
    }
}

var calc = Calculator()
calc.additionOperation = {(a, b) in
    a + b
}
calc.multiplicationOperation = {(a, b) in
    a * b
}

do {
    try calc.calculate("22*82") // prints 1804
    try calc.calculate("12+68") // prints 80
    try calc.calculate("12 32") // ERROR 423: No valid symbol('+','*') found.
//    try calc.calculate("12+") // ERROR 424: No left/right operand found.
} catch CalculatorError.invalidExpressionError(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)")
} catch CalculatorError.invalidOperationError(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)")
}

//// // Test to trigger didSet warning overriding message.
//calc.additionOperation = {(a, b) in
//    a+a+b+b
//}

//3.5 Points & Rectangles
//Create a type that for a Point coordinate, when create a type that for a Rectangle (use the Point)
//Add a pair of methods(mutating and non-mutating) in the Rectangle that will translate(e.g. move) a Rectangle from it's origin by an offset Point(x,y)
//Add a pair of methods that will check if two Rectangles overlap
//Add a method that will return the distance of a Point from the Axis centre 0,0
//Add a method that will return the distance of a Point from an other Point

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rectangle {
    var size = Size()
    var origin = Point()
    // when having the origin Point and size we can calculate the center each time
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
    // Move rectangle center to new Point with mutating func, recalculating self.origin
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        origin = Point(x: deltaX - (size.width / 2), y: deltaY - (size.height / 2))
    }
    
    // non-mutating func that checks if two rectangles overlap
    func overlaps(_ secondRectangle: Rectangle) -> Bool {
        // Bottom left Point is the origin
        var firstOrigin = Point(x: self.origin.x, y: self.origin.y)
        var secondOrigin = Point(x: secondRectangle.origin.x, y: secondRectangle.origin.y)
        
        // take the top right Point that creates the diagonal from origin to that Point
        var firstTopRight = getTopRightPoint(self)
        var secondTopRight = getTopRightPoint(secondRectangle)

        // If rectangle has area 0, no overlap
        if (firstOrigin.x == firstTopRight.x || firstOrigin.y == firstTopRight.y ||
            secondTopRight.x == secondOrigin.x || secondOrigin.y == secondTopRight.y) {
            return false
        }
        // If one rectangle is on left side of other
        if (firstOrigin.x > secondTopRight.x || secondOrigin.x > firstTopRight.x) {
            return false
        }
        // If one rectangle is above other
        if (firstOrigin.y > secondTopRight.y || secondOrigin.y > firstTopRight.y) {
            return false
        }
        
        return true
    }
    
    func getTopRightPoint(_ rectangle: Rectangle) -> Point {
        return Point(x: rectangle.origin.x + rectangle.size.width,
                     y: rectangle.origin.y + rectangle.size.height)
    }
    
    func toString() {
        print("Rectangle center point: \(self.center)\n" +
              "Rectangle origin point: \(self.origin)\n" +
              "Rectangle size: \(self.size.width) width, \(self.size.height) height.\n")
    }
    
    static func zeroAxisDistance(from point: Point) -> Double {
        sqrt(pow(point.x, 2) + pow(point.y, 2))
    }
    
    static func pointToPointDistance(from point1: Point, to point2: Point) -> Double {
        sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}

var rectangle = Rectangle()
// size of each edge
rectangle.size = Size(width: 25.0, height: 15.0)
// set the center Point of the rectangle using the setter of computed variable center
rectangle.center = Point(x: 0.0, y: 0.0)
rectangle.toString()
// set the new center Point using mutating func moveBy
rectangle.moveBy(x: 3.0, y: 16.0)

var rectangle2 = Rectangle()
rectangle2.size = Size(width: 15.0, height: 10.0)
rectangle2.center = Point(x: 17.5, y: 10) // rectangle2 - overlapping case with rectangle
rectangle2.toString()
rectangle.overlaps(rectangle2)
rectangle2.center = Point(x: 14.40, y: 2.76) // rectangle2 - not overlapping case
rectangle.overlaps(rectangle2)

Rectangle.zeroAxisDistance(from: Point(x: 12.4, y: -33.2)) // 35.44 Euclidean distance from start of Axis
Rectangle.pointToPointDistance(from: Point(x: 12.4, y: -33.2), to: Point(x: 32.4, y: -55.2))

//3.6 Phone and battery
//Create a type to represent a Phone, it should have a name, a batteryCharge and a display resolution as properties.
//You can use the phone for 6 activities (Call,Video,Photo,GPS,Screen, Charge) each reduces the charge at specific rate per minute (0.5, 3.5, 1.5, 2.5, 2.0, -5.5)
//Create a method that will peform an activity for x minutes. This method will print "consumed <X> battery for <Activity name>" if there is enough battery, then is should reduce the remaining battery charge
//if not it will print not enough energy for <x> minutes of <Activity>.

struct Resolution {
    var height: Int
    var width: Int
}

enum PhoneActivity : Float {
    case Call = 0.5
    case Video = 3.5
    case Photo = 1.5
    case GPS = 2.5
    case Screen = 2.0
    case Charge = -5.5
}

class Phone {
    var name: String
    var batteryCharge: Float
    var displayResolution: Resolution
    
    init(name: String, batteryCharge: Float, displayResolution: Resolution) {
        self.name = name
        self.batteryCharge = batteryCharge
        self.displayResolution = displayResolution
    }
    
    func performActivity(activity operation: PhoneActivity, for minutes: Int) -> Void {
        let batteryNeeded = Float(minutes) * operation.rawValue
        if self.batteryCharge - batteryNeeded > 0 {
            self.batteryCharge -= batteryNeeded
            print("Phone '\(self.name)' consumed \(batteryNeeded)% of battery for \(minutes) minutes of activity." +
                  " Battery remained after activity is \(self.batteryCharge)%.")
        } else {
            print("Not enough battery (\(self.batteryCharge)%) to perform this activity for \(minutes) minutes.")
        }
    }
    
    // Create this helping func when activity is Charge because
    // of not adding an extra if in the performActivity()
    func batteryCharged(minutes mins: Float) -> Void {
        self.batteryCharge -= PhoneActivity.Charge.rawValue * mins
        print("Phone '\(self.name)' charged for \(mins) minutes, battery percentage is \(self.batteryCharge)%.")
    }
}
var phone1 = Phone(name: "iPhone", batteryCharge: 5, displayResolution: Resolution(height: 1080, width: 1980))
phone1.performActivity(activity: .Call, for: 20) // Not enough battery
phone1.batteryCharged(minutes: 10)  // Charge battery
phone1.performActivity(activity: .Call, for: 20) // Try to perform activity again
phone1.performActivity(activity: .Video, for: 7) // 25.5% remained
phone1.performActivity(activity: .Photo, for: 8) // 13.5% remained
phone1.performActivity(activity: .GPS, for: 5) // 1% remained
phone1.performActivity(activity: .Screen, for: 2) // Not enough ...

//3.7 Poker Game
//Create a Player Object that has a name, and an array of Cards (from the 2.12 exercise Deck of cards)
//Create a PokerEngine Object that will have
//a init method that adds an array of Players
//a method deal that give 5 random cards to each player
//The player should print the each card's name when it is given, use property observers

// ****************************** 2.12 from previous day ********************************** //
enum Suit: String {
    case diamonds = "\u{2662}", clubs = "\u{2663}", hearts = "\u{2661}", spades = "\u{2660}"
}

enum Rank {
    case number(Int)
    case faceCards(String)
}

typealias Card = (rank: Rank, suit: Suit)

func createDeck() -> [Card] {
    // Initialize arrays for suites, numbers for cards, facecard symbols
    let suitsArray: [Suit] = [Suit.diamonds, Suit.clubs, Suit.hearts, Suit.spades]
    var ranks: [Rank] = [.faceCards("J"), .faceCards("Q"), .faceCards("K"), .faceCards("A")]
    (2..<11).forEach { number in ranks.append(Rank.number(number)) }
    
    return ranks.flatMap { suit in suitsArray.map { rank in (suit, rank) }}.shuffled()
}

//func printDeck(_ cards: [Card]) {
//    for card in cards {
//        var temp: Any = 0
//        if case let .faceCards(str) = card.rank {
//            temp = str
//        }
//        if case let .number(num) = card.rank {
//            temp = num
//        }
//        print("\(temp)\(card.suite.rawValue)")
//    }
//}
// ****************************** END ********************************** //

func printCard(_ card: Card) -> String {
    var temp: Any = 0
    if case let .faceCards(str) = card.rank {
        temp = str
    }
    if case let .number(num) = card.rank {
        temp = num
    }
    return "\(temp)\(card.suit.rawValue)"
}

class Player {
    var name: String
    var cards: [Card] {
        didSet {
            if let lastCard = cards.last {
                print("Player \(self.name) got \(printCard(lastCard)).")
            }
        }
    }
    
    init(name: String) {
        self.name = name
        self.cards = []
    }
}

class PokerEngine {
    var players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
    
    func deal() -> Void {
        var cards = createDeck()
        for player in self.players {
            for _ in 0..<5 {
                if let card = cards.popLast() {
                    player.cards.append(card)
                }
                else {
                    print("Not enough cards to deal.")
                    break
                }
            }
            if cards.isEmpty {
                break
            }
        }
    }
}

var playerX = Player(name: "Mariana")
var playerY = Player(name: "Dimitra")
var pokerEngine = PokerEngine(players: [playerX, playerY])
pokerEngine.deal()

//***********Example when deck is not enough************** //
//var player1 = Player(name: "Kostas")
//var player2 = Player(name: "Dimitris")
//var player3 = Player(name: "Rafail")
//var player4 = Player(name: "Jimis")
//var player5 = Player(name: "Lamros")
//var player6 = Player(name: "Christos")
//var player7 = Player(name: "Nikos")
//var player8 = Player(name: "Leonardos")
//var player9 = Player(name: "Ernesto")
//var player10 = Player(name: "Mariana")
//var player11 = Player(name: "Dimitra")
//var pokerEngine2 = PokerEngine(players: [player1, player2, player3, player4, player5, player6, player7, player8, player9, player10, player11])
//pokerEngine2.deal()
