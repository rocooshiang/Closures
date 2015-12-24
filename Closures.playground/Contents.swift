
/***

Closure Expression Syntax

Closure expression syntax has the following general form:

{ (parameters) -> return type in
statements
}

***/

import UIKit

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, _ s2: String) -> Bool {
  return s1 > s2
}

var reversed = names.sort(backwards)


//Closure Expression Syntax
var reversed2 = names.sort({(s1: String,  s2: String) -> Bool in return s1 > s2
})


//Inferring Type From Context
var reversed3 = names.sort({s1,s2 in return s1 > s2})


//Implicit Returns from Single-Expression Closures
var reversed4 = names.sort({s1,s2 in s1 > s2})


//Shorthand argument names
var reversed5 = names.sort( { $0 > $1 } )


//Operator Functions
var reversed6 = names.sort(>)


//Trailing Closures
var reversed7 = names.sort(){ $0 > $1}


//If a closure expression is provided as the function or method’s only argument
var reversed8 = names.sort{ $0 > $1 }

//----------------------------------------------

let digitNames = [
  0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
  5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map {
  (var number) -> String in
  var output = ""
  while number > 0 {
    output = digitNames[number % 10]! + output
    number /= 10
  }
  return output
}


//Capturing Values
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

//Closures Are Reference Types
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


/***

Marking a closure with @noescape lets the compiler make more aggressive optimizations because it knows more information about the closure’s lifespan.

***/
//Nonescaping Closures
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
  closure()
}

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
  completionHandlers.append(completionHandler)
}


class SomeClass {
  var x = 10
  func doSomething() {
    someFunctionWithEscapingClosure { self.x = 100 }
    someFunctionWithNoescapeClosure { x = 200 }
  }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)


completionHandlers.first?()
print(instance.x)


//Autoclosures
//The code below shows how a closure delays evaluation.
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)


func serveCustomer(customerProvider: () -> String) {
  print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )


func serveCustomer(@autoclosure customerProvider: () -> String) {
  print("Now serving \(customerProvider())!")
}
serveCustomer(customersInLine.removeAtIndex(0))


var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
  customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))

print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
  print("Now serving \(customerProvider())!")
}

