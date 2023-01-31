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
    convenience init(hex: String) {
        var r = Int(hex[hex.startIndex...hex.index(hex.startIndex, offsetBy: 1)] , radix: 16)!
        var g = Int(hex[hex.index(hex.startIndex, offsetBy: 1)...hex.index(hex.startIndex, offsetBy: 3)] , radix: 16)!
        var b = Int(hex[hex.index(hex.startIndex, offsetBy: 3)...] , radix: 16)!
        self.init(red: CGFloat(r), green: CGFloat(b), blue: CGFloat(g), alpha: 1)
    }
}

var k = UIColor.init(hex: "66CCCC")

//5.4
//Create a UIColor exention with the 4 basic colors of our Prooduct application. These should be constants and static, because their value will not change and will be the same across all instance of UIColor

//5.5
//Extend the Date class to add some convenience methods to calculate time units using DateComponents.
//The methods to add plusMonths plusWeeks plusDays plusHours minusMonths minusWeeks minusDays minusHours
//The methods should replace the current object and return it
//You should be able to calculate this:
//let date1 = Date().plusMonths(2).minusDays(5).plusHours(15)

//5.6
//Create an inverse method that takes a Double an returns the inversed (1/x) value.
//Call this method with values 1,2,0
//The method should throw an custom error if the X is zero.

//5.7
//Create an HttpClient class. It should have two methods, a userLogin that takes a username,password and returns a userID and a getUserProfile that takes a userID and returns a Userprofile(struct with first and last name of the user) .
//The HttpClient should hold internaly a list of valid username/passwords and their mapping to userIDs and UserProfiles
//The methods userLogin/getUserProfile should throw the appropriate errors for wrong username/password and wrong userID.

//5.8
//Add shuffle method to the Array type that performs a random permutation of its items

//5.9
//Add a replace(target: String, withString: String) -> String method in String type

//5.10
//Create a class Temperature with a double value to hold the current temp in kelvin.
//Adopt the protocol ExpressibleByFloatLiteral (implement  init(floatLiteral val: Float){})
//declare a variable with type Temperature and assing Assign it the value -273.15
//read the documentation of ExpressibleByFloatLiteral

