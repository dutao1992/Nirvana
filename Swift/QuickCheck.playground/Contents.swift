//: Playground - noun: a place where people can play

import UIKit

/**
 *  生成随机数
 */
protocol Smaller {
    func smaller() -> Self?
}
protocol Arbitrary: Smaller {
    static func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
    static func random(from from: Int, to: Int) -> Int {
        return from + (Int(arc4random())%(to - from))
    }
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}

func tabulate<T>(times: Int, transform: Int -> T) -> [T] {
    return (0..<times).map(transform)
}

extension Character: Arbitrary {
    static func arbitrary() -> Character {
        return Character(UnicodeScalar(Int(arc4random_uniform(126-22)+21)))
    }
    func smaller() -> Character? {
        return self
    }
}

extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = Int.random(from: 0, to: 40)
        let randomCharacters = tabulate(randomLength, transform: { _ in Character.arbitrary()})
        return String(randomCharacters)
    }
    func smaller() -> String? {
        return isEmpty ? nil : String(characters.dropFirst())
    }
}
extension Float {
    static func random(from from: Float, to: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (to - from) + from
    }
}

let numberOfIterations = 10


extension CGFloat: Arbitrary {
    static func arbitrary() -> CGFloat {
        return CGFloat.random(from: -1000, to: 1000)
    }
    static func random(from from: CGFloat, to: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (to - from) + from
    }
    func smaller() -> CGFloat? {
        return self == 0.0 ? nil : self / 2.0
    }
}
extension CGSize: Arbitrary {
    static func arbitrary() -> CGSize {
        return CGSize(width: CGFloat.arbitrary(), height: CGFloat.arbitrary())
    }
    var area: CGFloat {
        return width * height
    }
    func smaller() -> CGSize? {
        return self.area ==  0.0 ?  nil : CGSize(width: width/2.0, height: height/2.0)
    }
}




func iterateWhile<A>(condition: A -> Bool, initial: A, next: A -> A?) -> A {
    if let x = next(initial) where condition(x) {
        return iterateWhile(condition, initial: x, next: next)
    }
    return initial
}

func check2<A: Arbitrary>(message: String, _ property: A -> Bool) -> () {
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        guard property(value) else {
            let smallerValue = iterateWhile( {!property($0) }, initial: value, next: {$0.smaller()})
            print("\"\(message)\" doesn`t hold \(smallerValue)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}
func check1<A: Arbitrary>(message: String, _ property: A -> Bool) -> () {
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        guard property(value) else {
            print("\"\(message)\" doesn`t hold: \(value)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}


check2("Area should be at least 0") { (size: CGSize) in size.area >= 0.0 }


check2("Int must be at least 0") { (i: Int) in i > 0 }

extension Array: Smaller {
    func smaller() -> Array? {
        guard !isEmpty else { return nil }
        return Array(dropFirst())
    }
}

extension Array where Element: Arbitrary {
    static func arbitrary() -> [Element] {
        let randomLength = Int(arc4random() % 50)
        return tabulate(randomLength) { _ in Element.arbitrary() }
    }
}

struct ArbitraryInstance<T> {
    let arbitrary: () -> T
    let smaller: T -> T?
}

func checkHelper<A>(arbitraryInstance: ArbitraryInstance<A>, _ property: A -> Bool, _ message: String) -> (){
    for _ in 0..<numberOfIterations {
        let value = arbitraryInstance.arbitrary()
        guard property(value) else {
            let smallerValue = iterateWhile({ !property($0) }, initial: value, next: arbitraryInstance.smaller)
            print("\"\(message)\" doesn`t hold: \(smallerValue)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}

func check<X: Arbitrary> (message: String, property: X -> Bool) -> () {
    let instance = ArbitraryInstance(arbitrary: X.arbitrary, smaller: { $0.smaller()})
    checkHelper(instance, property, message)
}

func check<X: Arbitrary> (message: String, _ property: [X] -> Bool) -> () {
    let instance = ArbitraryInstance(arbitrary: Array.arbitrary, smaller: { (x: [X]) in x.smaller()} )
    checkHelper(instance, property, message)
}

/**
 *  Quick sort
 */
func qsort(array: [Int]) -> [Int] {
    var arr = array
//    print("\(arr)")
    if arr.isEmpty { return [] }
    let pivot = arr.removeAtIndex(0)
    let lesser = arr.filter() { $0 < pivot }
    let greater = arr.filter() { $0 > pivot }
    return qsort(lesser) + [pivot] + qsort(greater)
}

check("qsort should behave like sort") { (x: [Int]) in return qsort(x) == x.sort(<)}