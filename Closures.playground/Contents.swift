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



