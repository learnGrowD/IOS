import UIKit

//제어문 control flow
//1. for (Array 결합)
//2. if / else And Guard else
//3. *** switch
// +a) tuple, range, where, case let 결합

//swift pattrn
//* 어떠한 값과 일치하는 패턴
//1. 와일드카드 패턴(Wildcard Pattern)
//2. 식별자 패턴(Identifier Pattern)
//3. 값 바인딩 패턴(Value-Binding Pattern)
//4. 튜플 패턴(Tuple Pattern)
//* 어떠한 값과 일치하지 않는 패턴
//1. 열거형 케이스 패턴(Enumeration Case Pattern)
//2. 옵셔널 패턴(Optional Pattern)
//3. 타입 캐스팅 패턴(Type-Casting Pattern)
//4. 표현 패턴(Expression Pattern)

//*** 1. for문 (반복문) basic..
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)")
}

print()

for name in names[...2] { //Array배열의 인덱스를 Ragme로 구간을 설정하면 그에 대해서만 반복문 적용 가능...
    print(name)
}

let numberOfLegs = ["spider" : 8, "ant" : 6, "cat" : 4]
for (aniamlName, legCount) in numberOfLegs {
    print("\(aniamlName)s have \(legCount) legs")
}


for index in 1...10 {
    print(index)
}

print()

(1...10).forEach {value in
    print(value)
}

let times = 50
for i in 0..<times {
    print(i)
}

print()

(0..<times).forEach { value in
    print(value)
}
        

let a = 0
switch a {
case 0 as Int : print("dd")
default:
    print("")
}


//where과 결합..
for i in 1...30 where i < 10{
    print(i)
}


//2. if /else and Guard / else basic
var aa = 90
if aa <= 32 {
    print("a")
}else if 86... ~= aa { //range..
    print("b")
}else {
    print("c")
}



//guard / [else -> return or throw...]
//var someValue = 0
//guard someValue != 0 else { return or throw }
//print("Hello IOS")


//3. switch

//java에서는 break를 걸어줘서 특정 case의 것만 실행하게 했다면 swift에서는 기본적으로 break를 걸어주지 않다도 특정 case만 실행
//그러나 특정 케이스에서 의도적으로 switch문을 끝내고 싶을때 break를 걸어줄 수도 있음..
let bbb : Character = "z"
switch bbb {
case "a", "c" : //여러개 가능 -> kotlin의 when과 비슷...
    print("Hello IOS")
case "b" :
    print("Hello Android")
default :
    print("Hello Swift")
}


let arrayOfOptionalInt : [Int?] = [nil, 2, 3, nil, 5]
for number in arrayOfOptionalInt {
    if let number = number {
        print("Found a \(number)")
    }
}

//range
let approximateCount = -1
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5 :
    naturalCount = "a few"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hunreds of"
case var x : // 일반적인 case도 모두 담고있어서 -1이면 이쪽으로 빠지겠넴...
    x = 2000
    naturalCount = "\(x)"
}

//tuple
print("There are \(naturalCount) \(countedThings).")

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("a")
case (_, 0):
    print("b")
case (0, _):
    print("c")
case (-2...2, -2...2): //tuple + range //swift는 직관적인 언어이기 때문에 우리가 생각하는 대부분을 표현해줌... 그냥 시도해보면서 알아봐도 될듯..
    print("d")
default:
    print("e")
}


//case let
let anotherPoint = (2, 0)
switch anotherPoint {
case (var x, 0): //var, let 등 switch안에서 상수, 변수 선언이 가능한듯..
    x = 10
    print(x)
case (0, let y):
    print(y)
case let (x, y) : //일반적인 case를 모두 담아서 default가 필요없는듯...
    print("\(x) : \(y)")
}

//where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y :
    print("a")
case let (x, y) where x == -y :
    print("b")
case let (x, y):
    print("\(x) : \(y)")
}

//break, return, throw.., continue

//for i in 1...10 {
//    if i == 3 {
//        break or continue
//    }
//    print(i)
//}


//swift basic pattern...
//















