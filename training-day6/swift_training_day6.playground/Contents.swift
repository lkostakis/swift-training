//Swift Training Day 6 - Exercises
import UIKit

//6.0
//Add a infix ^^ operator to the Int type that raises the left operant to the power specificed by the right operant. e.g. 2^^3 = 8
infix operator ^^
func ^^ (lhs: Int, rhs: Int) -> Int {
    Int(pow(Double(lhs), Double(rhs)))
}
2^^3

//6.1
//Create a type Apple and Orange that inherit from a type Fruit, They should have a name, type and size properties.
//Override the + operator so that it take an apple and an orange and return an array of Fruit
//Now add apples instances with orange instances

// we assigned Fruit parameters to `+` overloading in purpose of addition's commutative property:
// `orange + apple` and `apple + orange`.
func +(lhs: Fruit, rhs: Fruit) -> [Fruit] {
    return [lhs, rhs]
}

class Fruit {
    let name: String
    let type: String
    let size: Double
    
    init (name: String, type: String, size: Double) {
        self.name = name
        self.type = type
        self.size = size
    }
}

class Apple : Fruit {
    override init(name: String, type: String, size: Double) {
        super.init(name: name, type: type, size: size)
    }
}

class Orange : Fruit {
    override init(name: String, type: String, size: Double) {
        super.init(name: name, type: type, size: size)
    }
}

let bloodOrange: Orange = Orange(name: "Blood Orange", type: "Sanguinello", size: 220.32)
let empireApple: Apple = Apple(name: "Empire", type: "McIntosh", size: 198.27)
let fruitArray = bloodOrange + empireApple

//6.2
//Implement a <-> swap operator that takes two variables and swapes their values

infix operator <->
func <-><T> (_ a: inout T, _ b: inout T) -> Void {
    let tempA = a
    a = b
    b = tempA
}

//6.3
//Add an extension for the Apples and Oranges and Fruit that adopts the Equality protocol.
//Add an extensions that implements CustomStringConvertible, try and print an Apple object

// Equatable extensions for Orange, Apple subclasses are omitted as they are also Fruit types
extension Fruit : Equatable {
    static func == (lhs: Fruit, rhs: Fruit) -> Bool {
        lhs.name == rhs.name && lhs.type == rhs.type && lhs.size == rhs.size
    }
}

extension Fruit : CustomStringConvertible {
    var description: String {
        return "name: \(name), type: \(type), size: \(size)"
    }
}
print(bloodOrange)
print(empireApple)

//6.4
//Create a Class Car that contains a property name, a property manufacture date
//and a property of Class type with name Engine that has a BOOL property isOn and default value false
//Create an instance of Car and reverse the isOn property of the engine.
//Create a protocol Togglable with a single method tongle that return Bool.
//Make the Swift Bool type implement it, it's implementation should reversing it's value.
//Modify the code reversing the isOn property to make it sorter and more readable.

//6.5
//Create an array of 5 cars.
//Implement the needed protocol(s) to compare Cars by name and date, validate using the contains method in the Array
//Implement the needed protocol(s) to sort the array using the sort(by: >) method in the Array
//Implement the needed protocol(s) to add the Cars instances in as keys in an dictionary.


//6.6
//Write a generic function to count the number of elements in a collection that are are of specific class type.
//e.g. find all elements in [UIViewController(), UIView(), 3, [1,2], "42", UILabel()] that are of type UIResponder
//e.g. find all elements in [UIViewController(), UIView(), 3, [1,2], "42", UILabel()] that are of type String

//6.7
//write a generic function that takes an array an returns an dictionary which contains as keys the elements of the array and as values the frequency they appeared in the array.

//6.8
//Create a protocol APIRequestProtocol, which contains two methods requestURL and performRequest, and the members baseURL and queryURL. The requestURL is a concatenation of baseURL and queryURL the performRequest performs an the http request(You can use a print statement in the function body).
//Then, we create three classes, UsersAPIRequest, GroupsAPIRequest ResourcesAPIRequest, to get the users, groups and static data from an API request. The first two will have the same requestURL, all three will have different queryURL. The methods performRequest and requestURL will be the same. Use protocol extensions to give default implemenetations.

//6.9
//Create a Shareable protocol that inherits from the APIRequestProtocol.
//It will have a method share that if the current adopter supports textual representation (e.g. CustomStringConvertible)
//it will share the text using https://example.com/share/text, else if the current instance is UIImage it will share it
//using https://example.com/share/image

