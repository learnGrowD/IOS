import UIKit
import Foundation

//함수...
//swift function (closue)
//0. override, overloading 지원...
//1. 고차함수 : 함수형언어에서 함수는 일급 객체.. : 파라미터로 전달 할 수 있고, 함수 객체를 리턴 받을 수 있다. : 함수를 파라미터로 전달하고 리턴받는 다는 것의
//의의는 규격을 전달하냐 전달받느냐의 의미를 지닌다. map, filter, reduce..는 결국 규격을 넘겨서 값을 처리하는데 있다.
//전달인자 레이블을 통해서 overloading 구현가능
//overloading이라는것이 파라미터를 통해서 함수를 구별하는것인데 전달인자 레이블을 통해서 충분히 함수를 구분할 수 있으니까 오버로딩이 가능한거임


let (a, b) = aaa(second : "Hello")
print(a)
print(b)
func aaa(first a : Int = 10, second b : String) -> (Int, String){
    return (a, b)
}

let (c, d) = aaa(b : "Hello IOS")
print(c)
print(d)

func aaa(a : Int = 10, b : String) -> (Int, String) { //전달인자 레이블을 통해서 오버로딩구현..
    return (a + 10, b)
}

//집합 파라미터 (variadic params)
print(sum(1, 2, 3, 4, 5))
func sum(_ numbers : Int...) -> Int {
    print(type(of: numbers)) //type of 찍어보면 가변인자 파라미터 이거 결국에는 그냥 Array 배열임...
    var total : Int = 0
    for number in numbers {
        total += number
    }
    return total
}

//in-out 파라미터
//기본적으로 함수의 파라미터는 let임... 즉 전달한 객체의 주소값을 변경하거나 값변경이 불가능 하다는 소리임
//그러나 나는 변경해주고 싶어 그럼 in-out 파라미터를 사용하는것임...

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
public func swapTwoInts(_ a : inout Int, _ b : inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


//closure ***
//in을 기준으로 Closure Head와 Body를 구분함...
//{(Parameters) -> Return Type in
//    실행구문 Closure Body
//
//}

let closure = { () -> () in
    print("Closure")
}

let closure2 = { (name : String) -> String in
    return "Hello, \(name)"
}

print(closure2("Haktae"))



func doSomething10(closure : () -> ()) {
    closure()
}

doSomething10(closure: { () -> () in
    print("Hello ㅎㅎ")
})

//함수에 전달하는 마지막 파라미터가 클로저라면 전달인자 생략하고 밖으로 뺼수 있음 -> kotlin과 똑같음..
doSomething10() { () -> () in
    
}


//근데 여기에 더해서 함수에 전달하는 파라미터가 클로저 하나밖에 없어? 그럼 ()도 생략가능
doSomething10 { () -> () in
    
}



func doSomething11(closure : (Int, Int, Int) -> Int) -> Int {
    return closure(1, 2, 3)
}

doSomething11 { (a : Int, b : Int, c : Int) -> Int in
    return a + b + c
}

doSomething11 { (a, b, c) in
    return a + b + c
}

doSomething11 {
    return $0 + $1 + $2
}

print(doSomething11 {
    $0 + $1 + $2
})


//ARC(Automatic Reference Count)
var john : Person?
var unit4A : Apartment?
john = Person(name : "john Appleseed")
unit4A = Apartment(unit : "4A")
john?.apartment = unit4A
unit4A?.tenant = john


john = nil
//john의 참조카운트는 1이였기 때문에 위에처럼 nil을 해주면 메모리에서 해제됨
//그리고 unit4A의 tenant는 weak 참조이기 때문에 자동으로 nil이 됨
//그러므로 Optional이여야 되고 var이 여야됨
//weak참조는 참조카운트에 반영되지 않음...



class Person {
    let name : String
    init(name : String) {
        self.name = name
    }
    var apartment : Apartment?
    deinit {
        print("\(name) is being deinitiallized")
    }

}

class Apartment {
    let unit : String
    init(unit : String) {
        self.unit = unit
    }
    weak var tenant : Person?
    deinit {
        print("Apartment \(unit) is being deinitiallized")
    }
}


//closure capture, capture list
func doSomething12() {
    var message = "Hi i am Haktae"
    
    var num = 10
    let closure = {
        print(num) //num capture...
    }
    print(message)
    
}

func doSomething13() {
    var num : Int = 0
    print("num #1 = \(num)")
    
    let closure = {
        print("num #3 = \(num)")
    }
    
    num = 20
    print("num #2 = \(num)")
    closure()
}
doSomething13()

func doSomething14() {
    var num : Int = 0
    print("num #1 = \(num)")
    
    let closure = {
        num = 20
        print("num #2 = \(num)")
    }
    closure()
    print("num #3 = \(num)")

}

doSomething14()


//value Type을 Value capture하고 싶어...
//capture list...


func doSomething15() {
    var num: Int = 0
      print("num check #1 = \(num)")
      
      let closure = { [num] in // let 상수임...
          print("num check #3 = \(num)")
      }
      
      num = 20
      print("num check #2 = \(num)")
      closure()
}
doSomething15()


//closure와 ARC


class Human {
    var name = ""
    //언제 unowned를 사용하는가 : 신용카드와 고객의 관계
    //강한 순환참조로 Human이 메모리에 살고 closure에 메모리에 사는 경우 있음
    //weak, unowned를 통해서 강한 순환참조 끊으면 Human이 없어지는 동시에 그에 해당하는 멤버변수인 클로서 삭제 가능
    //Human은 살고 그에 해당하는 멤버변서 nil값으로 충분히 가능
    //즉 Human의 생명주기는 클로저와 같거나 더 김 클로저가 더 길 상황은 없음
    //이럴때는 danger pointer의 위험성이 무의미해짐 그러므로 unowned를 사용해도 되겠다..
    lazy var getName : () -> String = { [unowned self] in //danger pointer
        return self.name
    }
    
    init(name : String) {
        self.name = name
    }
    
    deinit {
        print("Human Deinit!")
    }
}



var haktae : Human? = .init(name: "Do hak tae")
print(haktae?.getName)
haktae = nil




class AAA {
    var a : Int = 10
    init() {
        a = aaa()
    }
    func aaa() -> Int{
        return 20
    }
}

let htd : AAA = AAA()
print(htd.a)



