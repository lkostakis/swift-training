//Swift Training Day 4 - Exercises
import UIKit

//4.1
//Create a Shape base class and derive from it a Circle, Square and Rectangle classes.
//Shape should have two methods area() -> Float and perimeter() -> Float that both return 0. Implement the methods and add the necessary properties

class Shape {
    func area() -> Float {
        return 0
    }
    
    func perimeter() -> Float {
        return 0
    }
}

class Circle : Shape {
    var radius: Float
    
    init(radius: Float) {
        self.radius = radius
    }
    
    override func area() -> Float {
        return Float.pi * pow(radius, 2)
    }
    
    override func perimeter() -> Float {
        return 2*Float.pi*radius
    }
}

class Square : Shape {
    var side: Float
    
    init(side: Float) {
        self.side = side
    }
    
    override func area() -> Float {
        return pow(side, 2)
    }
    
    override func perimeter() -> Float {
        return 4*side
    }
}

class Rectangle: Shape {
    var length, width: Float
    
    init(length: Float, width: Float) {
        self.length = length
        self.width = width
    }
    
    override func area() -> Float {
        return width * length
    }
    
    override func perimeter() -> Float {
        return 2*(width+length)
    }
}

//4.2
//Create a subclass of UILabel named UILabelDebug that prints a message when the text, font or color is changed

class UILabelDebug : UILabel {
    override func 
}


//4.3
//Create a class type with name CustomNumber that holds a integer number it should have a initilizer that takes an Integer. Add a subscript operator that takes an integer index and returns the digit of the number in that position e.g. the [2] of 4567 id 5. Add an overloaded initializer that accepts strings.

//4.4
//Given an array of numbers write a filter method that only selects odd integers

//4.5
//Given an array of strings that only some can be converted to Int, map this array to an array of Ints filtering out th nil values

//4.6
//Given an array of Users which have properties name:String and age:Int write a map function that returns an array of strings consisting of the user’s names

//4.7
//Given an array of UIViews write a filter function that selects only those views that are a subclass of UILabel

//4.8
//Geven an array of strings use map to return an array of URLs

//4.9
//Given an array of numbers find the sum of the squares of all the odd numbers from numbers and then print it. Use map, filter and reduce to solve this problem.

//4.10
//Create an array of tuples with (image name as string, image url as string), use map to convert it to an array of images, then filter out the nil objects, then merge photos in one using method mergeImages()
// [("myImage.png", "https://imagesite..."), ("","")]
// tha ksekninisw me ena array p na ehei imagenames k dipla ena url pou tha vrw afto to image, kapoia stigmh tha to metatrepsw se klaseis UIImage
//func mergeImages(imageView: UIImageView) -> UIImage? {
//    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
//    imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    return image
//}
