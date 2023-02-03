//Swift Training Day 5 - Exercises
import Foundation
import UIKit

//5.0
class Cat {
}
var things: [Any] = [0, 0.0, (0,0), "0,0", 42, { (name: String) -> String in "Hello, \(name)" }, Cat(), { arc4random() }, { print("Hello") }, UIButton(), {}, [], NSString(), UILabel().self]
//Iterate thru the array and bind their matched value to a constant of the specified type to enable its value to be printed (If it a function then call it)
//Implement it both with if statement and with case pattern matching

//for element in things {
//    if let temp = element as? Int {
//        print(temp)
//    } else if let temp = element as? Double {
//        print(temp)
//    } else if let temp = element as? (Int,Int) {
//        print(temp)
//    } else if let temp = element as? String {
//        print(temp)
//    } else if let temp = element as? (String) -> String {
//        print(temp("Thomas"))
//    } else if let temp = element as? Cat {
//        print(temp)
//    } else if let temp = element as? () -> UInt32 {
//        print(temp())
//    } else if let temp = element as? UIButton {
//        print(temp)
//    } else if let temp = element as? [Any] {
//        print(temp)
//    } else if let temp = element as? NSString {
//        print(temp)
//    } else if let temp = element as? UILabel {
//        print(temp)
//    }
//}

//for element in things {
//    if case let temp = element as? Int {
//        print(temp)
//    } else if case let temp = element as? Double {
//        print(temp)
//    } else if case let temp = element as? (Int,Int) {
//        print(temp)
//    } else if case let temp = element as? String {
//        print(temp)
//    } else if case let temp = element as? (String) -> String {
//        print(temp!("Thomas"))
//    } else if case let temp = element as? Cat {
//        print(temp)
//    } else if case let temp = element as? () -> UInt32 {
//        print(temp!())
//    } else if case let temp = element as? UIButton {
//        print(temp)
//    } else if case let temp = element as? [Any] {
//        print(temp)
//    } else if case let temp = element as? NSString {
//        print(temp)
//    } else if case let temp = element as? UILabel {
//        print(temp)
//    }
//}

//5.1
//Create MusicViewController,AlbumViewController subclass of UIViewController
//Create and array that holds the types of MusicViewController & AlbumViewController, give that array explicit type annotation
//Create a method that takes that array and returns instances of the controllers

class MusicViewController : UIViewController {
}

class AlbumViewController : UIViewController {
}

var viewControllersArray: [UIViewController] = []

func getInstances(_ viewControllersArray: [UIViewController]) -> [UIViewController] {
    return [MusicViewController(), AlbumViewController()]
}

getInstances(viewControllersArray)

//5.2
//Create a class Dog with a name property and an initializer.
//Create a makePuppy method that takes a String and returns an instance of the same type. (e.g. if it is called on Dog instance will create new Dog instance)
//Create two subclasses of that Dog class

class Dog {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
    
    class func makePuppy(_ name: String) -> Self {
        let dog = self.init(name: name)
        return dog
    }
}

class Affenpinscher : Dog {
}

class Boxer : Dog {
}

let affenDog = Affenpinscher.makePuppy("Jack")
let boxerDog = Boxer.makePuppy("Jimmy")

//5.3
//Create a UIColor exention to add an initializer that creates a color from a hex string e.g "#66CCCC

extension UIColor {
    // Convenience failable init in order to catch cases that string input is not valid
    convenience init?(hex: String) {
        // check that the input is contained by valid letters and digits
        // `{6}` can be omitted as it matches the first 6 characters of the input
        let regex = /([a-fA-F0-9]{6}+)/
        guard hex.count == 6 else {
            return nil
        }
        if hex.firstMatch(of: regex) == nil {
            return nil
        }
        // we can use force-unwrapping here as it is certain that the input string is in valid format
        let r = Int(hex[hex.startIndex...hex.index(hex.startIndex, offsetBy: 1)], radix: 16)!
        let g = Int(hex[hex.index(hex.startIndex, offsetBy: 2)...hex.index(hex.startIndex, offsetBy: 3)], radix: 16)!
        let b = Int(hex[hex.index(hex.startIndex, offsetBy: 4)...], radix: 16)!
        self.init(red: CGFloat(Float(r)/255.0), green: CGFloat(Float(g)/255.0), blue: CGFloat(Float(b)/255.0), alpha: 1)
    }
}

let cyan = UIColor.init(hex: "47F4B3")
let colorTest1 = UIColor.init(hex: "47F4G3") // Fails as it contains letter `G`
let colorTest2 = UIColor.init(hex: "abc23dd") // Fails as input.count > 6

//5.4
//Create a UIColor exention with the 4 basic colors of our Prooduct application. These should be constants and static, because their value will not change and will be the same across all instance of UIColor

extension UIColor {
    static let basicGray = UIColor.init(hex: "808080")
    static let basicMagenta = UIColor.init(hex: "FF00FF")
    static let basicCyan = UIColor.init(hex: "7CFFFB")
    static let basicLime = UIColor.init(hex: "00FF00")
}

//5.5
//Extend the Date class to add some convenience methods to calculate time units using DateComponents.
//The methods to add plusMonths plusWeeks plusDays plusHours minusMonths minusWeeks minusDays minusHours
//The methods should replace the current object and return it
//You should be able to calculate this:
//let date1 = Date().plusMonths(2).minusDays(5).plusHours(15)

extension Date {
    func plusMonths(_ months: Int) -> Date {
        var monthComponent = DateComponents()
        monthComponent.month = months
        return Calendar.current.date(byAdding: monthComponent, to: self)!
    }
    
    func minusDays(_ days: Int) -> Date {
        var dayComponent = DateComponents()
        dayComponent.day = -days
        return Calendar.current.date(byAdding: dayComponent, to: self)!
    }

    func plusWeeks(_ weeks: Int) -> Date {
        var weekComponent = DateComponents()
        weekComponent.weekOfMonth = weeks
        return Calendar.current.date(byAdding: weekComponent, to: self)!
    }

    func plusHours(_ hours: Int) -> Date {
        var hourComponent = DateComponents()
        hourComponent.hour = hours
        return Calendar.current.date(byAdding: hourComponent, to: self)!
    }
    
    // minusMonths(), minusWeeks(), plusDays(), minusHours() are omitted for brevity
}

let date1 = Date().plusMonths(2).plusWeeks(2).minusDays(3).plusHours(3)

//5.6
//Create an inverse method that takes a Double an returns the inversed (1/x) value.
//Call this method with values 1,2,0
//The method should throw an custom error if the X is zero.

struct ErrorResponse {
    let code: Int
    let message: String
}

enum InverseError : Error {
    case ZeroDivisionError(ErrorResponse)
}

func inversed(_ num: Double) throws -> Double {
    guard num != 0 else {
        throw InverseError.ZeroDivisionError(ErrorResponse.init(code: 440, message: "Division by zero."))
    }
    return 1/num
}

do {
    try inversed(0)
} catch InverseError.ZeroDivisionError(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)")
}

//5.7
//Create an HttpClient class. It should have two methods, a userLogin that takes a username,password and returns a userID and a getUserProfile that takes a userID and returns a Userprofile(struct with first and last name of the user) .
//The HttpClient should hold internaly a list of valid username/passwords and their mapping to userIDs and UserProfiles
//The methods userLogin/getUserProfile should throw the appropriate errors for wrong username/password and wrong userID.

class HttpClient {
    private var userCredentials: [String : String] = [:] // username:password
    private var usernameUserIDMapping: [String : Int] = [:] // map username with user ID
    private var userIDuserProfileMapping: [Int : UserProfile] = [:] // map user ID with UserProfile

    // enclose error enum and response struct to avoid potential namespace collisions
    struct ErrorResponse {
        let code: Int
        let message: String
    }

    enum HttpClientError : Error {
        case InvalidCredentials(ErrorResponse)
        case InvalidUserID(ErrorResponse)
    }

    struct UserProfile {
        let firstName, lastName: String
    }

    func userLogin(username: String, password: String) throws -> Int? {
        guard let storedCredentials = userCredentials[username], storedCredentials == password else {
            throw HttpClientError.InvalidCredentials(ErrorResponse.init(code: 420, message: "INVALID CREDENTIALS."))
        }
        return usernameUserIDMapping[username]
    }

    func getUserProfile(userID: Int) throws -> UserProfile? {
        guard let storedUserProfile = userIDuserProfileMapping[userID] else {
            throw HttpClientError.InvalidUserID(ErrorResponse.init(code: 421, message: "NO USER WITH GIVEN USER ID EXISTS."))
        }
        return storedUserProfile
    }

    // Setup a test HttpClient model, init `userCredentials`, `usernameUserIDMapping`, `userIDuserProfileMapping`.
    private func setupUserIDMapping() {
        usernameUserIDMapping["johnK1992"] = 1
        usernameUserIDMapping["mari@Kappa"] = 2
    }

    private func setupUserCredentials() {
        userCredentials["johnK1992"] = "passw0rd123"
        userCredentials["mari@Kappa"] = "p@ssw0rd23"
    }

    private func setupUserProfileMapping() {
        userIDuserProfileMapping[1] = UserProfile(firstName: "John", lastName: "Kefalas")
        userIDuserProfileMapping[2] = UserProfile(firstName: "Maria", lastName: "Karolou")
    }

    init() {
        setupUserIDMapping()
        setupUserProfileMapping()
        setupUserCredentials()
    }
}

let client = HttpClient()

do {
    try client.userLogin(username: "johnK1992", password: "passw0rd123") // fetch user ID when valid credentials given
    try client.userLogin(username: "mari@Kappa", password: "p@ssw0rd23") // fetch user ID when valid credentials given
    try client.getUserProfile(userID: 1) // fetch UserProfile when valid user ID given
    try client.getUserProfile(userID: 2) // fetch UserProfile when valid user ID given
    
    // some error tests, when wrong password or username given
    try client.userLogin(username: "johnK1992", password: "wrongPassword")
    // try client.userLogin(username: "wrongUsername", password: "passw0rd123")
    // test when wrong user ID given
    // try client.getUserProfile(userID: 3)
} catch HttpClient.HttpClientError.InvalidCredentials(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)")
} catch HttpClient.HttpClientError.InvalidUserID(let errorResponse) {
    print("ERROR \(errorResponse.code): \(errorResponse.message)")
}

//5.8
//Add shuffle method to the Array type that performs a random permutation of its items

// Swift offers shuffled() to return an array with a random permutation of its items, but
// let's try doing it from scratch using the famous Fisher–Yates shuffle Algorithm
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
func shuffles(_ array: [Int]) -> [Int] {
    var resultArray = array // copy input array to a temp in order to prevent mutating function
    
    for i in stride(from: array.count-1, to: 0, by: -1) {
        resultArray.swapAt(i, Int(arc4random_uniform(UInt32(i+1))))
    }
    return resultArray
}

shuffles(numbers)

//5.9
//Add a replace(target: String, withString: String) -> String method in String type

extension String {
    func replace(target: String, withString: String) -> String {
            return self.replacingOccurrences(of: target, with: withString)
        }
}

let originalString = "Hello, World!"
let modifiedString = originalString.replace(target: "Hello, World!", withString: "Swift")
print(originalString)

//5.10
//Create a class Temperature with a double value to hold the current temp in kelvin.
//Adopt the protocol ExpressibleByFloatLiteral (implement  init(floatLiteral val: Float){})
//declare a variable with type Temperature and assing Assign it the value -273.15
//read the documentation of ExpressibleByFloatLiteral

