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

// helping extension of Date struct to create Date instances in a more human-like manner
extension Date {
    static func fromString(_ str: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: str)
    }
}

class Car {
    let name: String
    let manufactureDate: Date
    let engine: Engine
    
    init(name: String, manufactureDate: Date, engine: Engine) {
        self.name = name
        self.manufactureDate = manufactureDate
        self.engine = engine
    }
    
}

// No return type
protocol Togglable {
    func toggle()
}

// First way with Bool return type
protocol TogglableBool {
    func toggle() -> Bool
}

// first implementation with Bool return type
/*class Engine : TogglableBool {
    var isOn = false

    func toggle() -> Bool {
        self.isOn = !self.isOn
        return self.isOn
    }
}*/

// second implementation with EngineState enum and on/off cases (more understandable)
// note that conforming to the protocol in the Engine class, because it is already
// a small sized class, so there is no need to make an extension to keep it more simple
class Engine : Togglable {
    enum EngineState {
        case off, on
    }
    var isOn: EngineState = .off

    func toggle() {
        switch isOn {
        case .off:
            self.isOn = .on
        case .on:
            self.isOn = .off
        }
    }
}

// To see the results its the exactly same initializations and functions for both implementations
// just comment out second impl and uncomment the first one. Second way switches an EngineState var
// from off to on, while the first one modifies isOn with true/false and returns the boolean value
let alfaRomeo = Car(name: "Giulietta", manufactureDate: Date.fromString("19/4/2019")!, engine: Engine())
alfaRomeo.engine.toggle()

//6.5
//Create an array of 5 cars.
//Implement the needed protocol(s) to compare Cars by name and date, validate using the contains method in the Array
//Implement the needed protocol(s) to sort the array using the sort(by: >) method in the Array
//Implement the needed protocol(s) to add the Cars instances in as keys in an dictionary.
let ford = Car(name: "Mondeo", manufactureDate: Date.fromString("11/6/2020")!, engine: Engine())
let nissan = Car(name: "Qashqai", manufactureDate: Date.fromString("23/11/2017")!, engine: Engine())
let toyota = Car(name: "Corolla", manufactureDate: Date.fromString("31/8/2015")!, engine: Engine())
let fiatScudo = Car(name: "Scudo", manufactureDate: Date.fromString("8/2/2023")!, engine: Engine())
var carArray = [alfaRomeo, ford, nissan, toyota, fiatScudo]

// a good practice to keep Car class more readable is to conform to the protocols needed outside of the class
// as extensions of the particular class, in order to keep code more readable and simple and dont create huge class.
extension Car : Equatable, Comparable {
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        lhs.name == rhs.name && lhs.manufactureDate == rhs.manufactureDate
    }
    
    static func < (lhs: Car, rhs: Car) -> Bool {
        if lhs.name != rhs.name {
            return lhs.name < lhs.name
        }
        // we assume earlier dates are > than later dates. e.g.: 12/1/2020 > 12/2/2020 returns true
        return lhs.manufactureDate > rhs.manufactureDate
    }
}

// In order to use Car types as keys in a dictionary the Car class has to conform to the Hashable protocol.
// Car type need to implement the hashValue property and be Equatable.

extension Car : Hashable {
    // create Int hash code with XOR gate
    // Deprecated way to do so
//    var hashValue: Int {
//        name.hashValue ^ manufactureDate.hashValue
//    }
    
    // More modern way to do it
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(manufactureDate)
    }
}

// we can check sorting method sort(by: >). First the method will check the name and do naming sorting
// if names are the equal then the manufacture date will be compared
// so we can test sort(by:) method when creating an object with a name that already exists
let newFiatScudo = Car(name: "Scudo", manufactureDate: Date.fromString("18/3/2023")!, engine: Engine())
carArray.append(newFiatScudo)
carArray.sort(by: >)

//6.6
//Write a generic function to count the number of elements in a collection that are are of specific class type.
//e.g. find all elements in [UIViewController(), UIView(), 3, [1,2], "42", UILabel()] that are of type UIResponder
//e.g. find all elements in [UIViewController(), UIView(), 3, [1,2], "42", UILabel()] that are of type String

// we specify that C generic has a type constraint as it is eligible to be used for resolving only
// Collection types like Array, Set, Dict., Substring and so on...
func countInstanceElements<T, C: Collection>(of type: T.Type, in collection: C) -> Int {
    collection.filter { $0 is T }.count
}

let elements: [Any] = [UIViewController(), UIView(), 3, [1,2], "42", UILabel()]

countInstanceElements(of: String.self, in: elements) // 1 instance
countInstanceElements(of: UIResponder.self, in: elements) // 3 instances

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

