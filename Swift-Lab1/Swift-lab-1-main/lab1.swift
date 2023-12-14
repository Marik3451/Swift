import Foundation


func add(number1: Int?, number2: Int?) -> Int {
    return number1! + number2!
}
func subtract(number1: Int?, number2: Int?) -> Int {
    return number1! - number2!
}
func multiply(number1: Int?, number2: Int?) -> Int {
    return number1! * number2!
}
func divide(number1: Int?, number2: Int?) -> Int {
    return number1! / number2!
}
let operation: String? = "*"
let number1: Int? = 20
let number2: Int? = 50
var result: Int?
if let operation = operation, let number1 = number1, let number2 = number2 {
    switch operation {
        case "+":
            result = add(number1: number1, number2: number2)
        case "-":
            result = subtract(number1: number1, number2: number2)
        case "*":
            result = multiply(number1: number1, number2: number2)
        case "/":
            result = divide(number1: number1, number2: number2)
        default:
            print("This operation is not supported!")
            result = 0
    }  
}
print("\(number1!) \(operation!) \(number2!) = \(result!)")
