//: Playground - noun: a place where people can play

import UIKit

var array = Array(repeating: 12, count: 5 )
var array2 = Array(repeating: 14, count:6 )
var arrayTotal = array + array2
print("目前有\(arrayTotal.count)個數在 ＡrrayTotal 中。")
array = []
var array3 = [String]()
print("目前有\(array.count)個數在 Ａrray1 中。")

array3 = ["可樂", "雪碧"]
print("目前有\(array3.count)個數在 Array3 中。")

if array3.isEmpty {
    print("Array3是空的")
}
else{
    print("Array3還有\(array3.count)物品")
}
print("Array3現在有\(array3)")
for (i,item) in array3.enumerated(){
    print("項目\( i + 1 ) \(item)")
}

for index in 1...9{
    print("2 * \(index) = \(index * 2)")
}

var scores = ["國文": 100, "英文": 98, "數學" : 99]
for (subject, score) in scores{
    print("\(subject)分數為\(score)")
}

var two = 2
var total = 1
for _ in 0...10{
    total *= two
    print("\(total)")
}
total = 1
for _ in stride(from: 0, through: 10, by: 1){
total *= two
print("\(total)")
}

var i = 1
while i < 10 {
    print("5 * \(i) = \(i * 5)")
    i += 1
}
i = 1
repeat{
    print("5 * \(i) = \(i * 5)")
    i += 1
} while i < 10

let food = "可樂1"

switch food {
case "炸雞", "薯條":
    print("你點的是炸雞、與薯條")
    fallthrough
case "可樂":
    print("你點的是可樂")
    fallthrough
case "可樂1":
    print("你點的是可樂")
default:
    print("抱歉我們沒有賣這個")
}

let point = (2, 5)

switch point{
case (let x, 0):
    print("此點在Ｘ軸上，Ｘ值為\(x)")
case(0, let y):
    print("此點在Y軸上，Ｘ值為\(y)")
case let(x, y):
    print("不再Ｘ軸也不再Ｙ軸上")
}

var num = 1
gameLoop: while num < 10{
switch num{
case 1...4:
    num += 1
case 1...5:
    num *= 10
    break gameLoop
default:
    num += 100
}
    print(num)
}
print(num)
for n in 1...10{
    if n < 3 {
        continue
    }
    print("\(n), ")
}

func div(first num1: Int,second num2: Int) -> (result: Int, other: Int){
    var a = 0, b = 0
    
    if num1 > num2{
        a = num1 / num2
        b = num1 % num2
        print("\(num1) / \(num2) = \(a)...\(b)")
    }else{
        a = num2 / num1
        b = num2 % num1
        print("\(num1) / \(num2) = \(a)...\(b)")
    }
    return (a, b)
}

print(div(first:20, second:3))

func arithmeticMean(numbers: Double...) -> Double{
    var total: Double = 0
    for number in numbers{
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(numbers:1, 2, 3, 4, 5)

func reference(num1: inout Int, num2: inout Int){
    num1 += 30
    num2 += 100
}

var testNum1 = 20
var testNum2 = 10
reference(num1: &testNum1, num2: &testNum2)

print(testNum1, testNum2)

//可選元組返回型別
func nilTest(arr: [Int]) -> (Int, Int)?{
    if arr.isEmpty{
        return nil
    }else{
        let n = arr[0] + 10
        let n2 = arr[0] + 100
    return(n, n2)
    }
}

if let nilNum = nilTest(arr: [11, 22, 33]){
    print("\(nilNum.0) and \(nilNum.1)")
}

if let nilNum = nilTest(arr: []) {
    print("這裡不會被印出來")
}


func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}
var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")

func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(mathFunction: addTwoInts, a:5,b:3)
printMathResult(mathFunction: multiplyTwoInts, a: 5, b: 3)

func price( money:Double ) -> Double{
    return(money * 0.9)
}

func discount( money:Double) -> Double{
    return(money * 0.79)
}

func choose( range:Bool ) -> (Double) -> Double{
    return range ? discount : price
}

var product:Double = 2000
let Getdiscount = choose(range: product>1000)

if product>1000{
    product = Getdiscount(product)
    print("得到79折優惠\(Int(product))")
}

let numberArray = [0:"0",1:"1",2:"2",3:"3",4:"4",5:"5",6:"6",7:"7",8:"8",9:"9"]
let numbers = [1234,567,89,0]


let strung = numbers.map{ (number) -> String in
    var number = number
    var output = ""
    repeat{
        output = numberArray[number%10]! + output
        number /= 10
    } while number > 0
    return output
    
    
}

print(strung)


func addFunc5 (_ number:Int) -> () -> Int{
    var total = 0
    func add() ->Int {
        total += number
        return total
    }
    return add
}

func addFunc10 (_ number:Int) -> () -> Int{
    var total = 0
    func add() ->Int {
        total += number
        return total
    }
    return add
}

let addFunc = addFunc5(5)
let addFunc2 = addFunc5(10)
addFunc()
addFunc2()
addFunc()
addFunc2()
let finalScore = addFunc()
let finalScore2 = addFunc2()
print(finalScore,finalScore2)

var completionHandlers:[() -> Void] = []

func someFuctionEscaping (completionHandler: @escaping () -> Void){
    completionHandlers.append(completionHandler)
}

func someFunctonNoescaping(clousure: () -> Void){
    clousure()
}

class someClass {
    var x = 10
    func dosomthing() {
        someFuctionEscaping {
            self.x = 100
        }
        someFunctonNoescaping {
            x = 100
        }
    }
}

enum direction {
    case Up
    case Down
}
var dierction1 = direction.Up
dierction1 = .Down
switch dierction1 {
case .Up:
    print("⬆️")
case .Down:
    print("⬇️")
default:
    print("wrong")
}



var customersInLine = ["kai", "Min", "Co"]
let customerProvider = { customersInLine.remove(at: 0) }
var customerProviders: [() -> String] = []
var cus123 = ["Eggs", "Milk"]
cus123.append(customersInLine.remove(at: 0))
print(cus123[2])
func collectCustomerProviders(remove customerInLine: @autoclosure () -> String){
    customerProviders.append(customerProvider)
}

collectCustomerProviders(remove: customersInLine.remove(at: 0))
collectCustomerProviders(remove: customerProvider())

print("獲得了\(customerProviders.count)成員)")

enum AlphabeticalOder:Int {
    case A = 1,B,C,D,F,G
}
let orderFind = 2
if let someOrder = AlphabeticalOder(rawValue: orderFind){
    switch someOrder {
    case .A,.B,.C:
        print("在原始值範圍中，\(someOrder)")
    default:
        print("在原始值範圍中，但不存在此case")
    }
}else{
    print("超出範圍")
}

indirect enum Calculation{
    case number(Int)
    case add(Calculation, Calculation)
    case mul(Calculation, Calculation)
}

let five = Calculation.number(5)
let three = Calculation.number(3)
let sum = Calculation.add(five, three)
let product2 = Calculation.mul(sum, Calculation.number(3))

func math (_ count:Calculation) -> Int{
    switch count {
    case let .number(value):
        return value
    case let .add(a, b):
        return math(a) + math(b)
    case let .mul(a, b):
        return math(a) * math(b)
    }
}
print(math(product2))

class Clock{
    var hours = 0
    var minutes = 0

    func minCount(m min:Int){
        minutes += min
    }
    func hrCount(h hr:Int){
        hours += hr
    }
    func minTohr(){
        if minutes >= 60{
            hours += minutes/60
            minutes -= 60 * (minutes/60)
            
        }
    }
}

let timeCount = Clock()
timeCount.minCount(m:241)
timeCount.hrCount(h : 5)
timeCount.minTohr()

print("現在時間為\(timeCount.hours)小時，又\(timeCount.minutes)分")

struct Coordinate{
    var x:Double = 0.0, y:Double = 0.0
    mutating func move (x Xmove:Double, y Ymove:Double){
        x += Xmove
        y += Ymove
    }
}

var position = Coordinate(x :5.0, y :5.0)
position.move(x: 10.0, y: 10.0)
print("位置為Ｘ:\(position.x) Y:\(position.y)")
var pos2 = Coordinate(x :5.0, y :10.0)
print("位置為Ｘ:\(pos2.x) Y:\(pos2.y)")
print("位置為Ｘ:\(position.x) Y:\(position.y)")

class mathFunc{
    class func add(_ a:Int, _ b:Int)->Int{
        return a + b
    }
}

var addResult = mathFunc.add(4, 5)
print(addResult)

struct Area{
    static func position(_ x:Int, _ y:Int)->Int {
        var result = x * y
        if result < 0 {
            result = -result
            return result
        } else{
            return result
        }
    }
}
let result = Area.position(10, -10)
print(result)

class Week{
    var dayArray = ["Mon", "Thu", "Wed", "Thr", "Fri", "Sat", "Sun"]
    subscript (index:Int) -> String{
        get {
            return dayArray[index]
        }
    }
}
var day = Week()
print(day[5])

var queue = ["apple":1, "banana":2, "cat":3]
queue["dog"] = 4
queue.sorted(by: >)

enum _math{
    case add, sub, mul, div
}

class Computer{
    var result = 0
    func calculation(Num1 a:Int, Num2 b:Int, method:_math ) -> Int {
        switch method {
        case .add:
            result = a + b
        case .sub:
            result = a - b
        case .mul:
            result = a * b
        case .div:
            result = a / b
        }
        return result
    }
        subscript (Num1 a:Int, Num2 b:Int, method:_math ) -> Int {
            result = calculation(Num1: a, Num2: b, method:method)
            return result
        }
    }
    
let mathMethod = Computer()
print("2 * 10 結果為 \(mathMethod[Num1: 2, Num2: 10, _math.mul])")

class Transportation {
    var speed = 0
    var information :String{
        return "的時速為:\(speed)km/h"
    }
    func distance(hour a:Int) -> Int{
        return speed * a
    }
}
let some = Transportation()
some.speed = 10
print("這個交通工具\(some.information)")

class Car:Transportation{
    var wheel = 4
}
let tricycle = Car()
tricycle.speed = 1
tricycle.wheel = 3
print("三輪車\(tricycle.information)，輪子有\(tricycle.wheel)")

class ElectricCar:Car{
    var energe = "電力"
}
let electricCar = ElectricCar()
electricCar.speed = 20
print("這台電動車是靠\(electricCar.energe)發動的，輪子有\(electricCar.wheel)，它\(electricCar.speed)")

class broken:Transportation{
    override func distance(hour a: Int) -> Int {
        print("這台車無法行駛，速度為\(speed)")
        return speed * a
    }
}
let brokenCar = broken()
brokenCar.distance(hour: 100)

class Stuck:Transportation{
    override var information: String{
        return "現在阻塞了"
    }
}
let traffic = Stuck()
print(traffic.information)


