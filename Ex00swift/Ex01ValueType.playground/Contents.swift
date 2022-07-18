import UIKit


//*** 기본 자료형
let a : Bool = true // 1
let b : Int = -5 // 8
let c : UInt = 10 // 8
let d : Float = 0.4 // 4
let e : Double = 0.4 // 8
let f : Character = "A" //16
let g : String = "Hello IOS" // 16
//* 참조변수 OS 32bit : 4byte, 64bit : 8byte

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)
print(g)
print(MemoryLayout<String>.size)


//*** Collection
//1. Array
var arr = [1, 2, 3, 4, 5]
var arr2 = [Int]()
arr2.append(10)
let arr3 = [1, 2, 3, 4, 5] //배열을 let으로 선언하면 배열 정적 크기, 구성요소 변경 불가능
//arr3.append(20) // error
//arr3[0] = 0 //error


var dir = [String : String]() // 빈 direction
var dir2 = ["key1" : "Hello IOS", "key2" : "Hello Android"] // direction 초기화
var dir3 : [String : String] = [:] // 빈 directuon
let dir4 = ["element1" : "IOS", "elment2" : "Android"]
//dir4["element2"] = "React" //error
dir2["key2"] = "React" // 구성요소 change
dir2["key3"] = "React" // 구성요소 add...
print(dir2)

var set1 : Set<Int> = [1, 2, 3, 4, 5] // set 초기화
var set2 = Set<Int>() // 빈 set

set1.insert(1)
set1.insert(2)
set1.insert(2)
print(set1)

//*** tuple
var tuple = ("Bill", 100, true) // type 추론가능
tuple.0 = "Swift"
print(tuple.0)
print()

let (name , index, isMan) = tuple
print(index)

var tuple2 = (name : "Bill", age : 30, likes : ["swift", "IOS"]) // type 추론 가능 naming index
print(tuple2.name)
print(tuple2.age)
print(tuple2.likes)



//multi return function
func plusAndMinus(a : Int, b : Int) -> (Int, Int) {
    return (a + b, a - b)
}

let (plusResult, minusResult) = plusAndMinus(a: 1, b: 2)
print(plusResult)



//*** range
//ClosedRange
//** range != array
1...10
1..<10

let value = 5
print((1...10).contains(5))
print(1...10 ~= 5)

(1...10).forEach { value in
    print(value)
}

print()

for value in 1...10 {
    print(value)
}

//PartialRange
...10
10...
..<10
print((10...).contains(9))
print((10...) ~= 11)


//*** 참고 : Comparable을 구현한 타입이면 모두 범위로 쓸 수 있다. (구조체, 클래스 등...)
1.0 ... 10.0
"A"..."B"


// *** optional
var email : String? = nil
if let requireEmail = email {
    print(requireEmail)
}

var optionalName : String? = "Do hak tae"
var optionalEmail : String? = "willd88@naver.com"

if let name = optionalName,
   let email2 = optionalEmail {
    print("\(name) : \(email2)")
}


var optionalAge : Int? = 25

if let age = optionalAge {
    if age > 20 {
        print(age)
    }
}
if let age = optionalAge, age > 20 { //조건문을 추가로 걸어줄 수 있다 특징은 ,이후의 조건절은 옵셔널 바인딩이 일어난 후 에 실행이 된다..
    print(age)
}


//optional 벗기기 -> !
var aaa : String? = nil
//print(aaa!) aaa가 nil인지 아닌지 난 상관없고 그냥 nil이 아니라고 생각하고 출력해!!
//대신 정말 nil이라면 nullPointExeption이 발생함...

//암묵적으로 벗겨진 optional
var aaa2 : String! = nil
var aaa3 : String = aaa2 //aaa2가 nil인지 상관없이 optional binding, chaning, 벗기기를 할필요가 없이 자유롭게 사용이 가능하지만 만약
//nil이라면 Error...
//왠만하면 옵셔널을 사용하여 타입 세이프하게 코드를 짜는것을 권장
print(aaa3)











