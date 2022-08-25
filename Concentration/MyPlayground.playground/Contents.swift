import UIKit

var greeting = "Hello, playground"
var sum = 0.0
for i in stride(from: 0.5, through: 15.25, by: 0.3) {
  sum += i
}
//print(sum)
let x: (String, Int, Double) = ("hello", 5, 0.85)
let (word, number, value) = x
//print(word, number, value)

let y: (w: String, i: Int, v: Double) = ("hello", 5, 0.85)
//print(y.w)
//print(y.i)
//print(y.v)

func getSize() -> (weight: Double, height: Double) { return (250, 80)}
let size = getSize()
//print("weight is \(size.weight)")
//print("height is \(getSize().height)")

var foo: Double {
  get {
    return 10.0
  }
  set {
    print("foo = \(newValue)")
  }
}
//foo = 5
