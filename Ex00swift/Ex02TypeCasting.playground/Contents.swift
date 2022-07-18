import UIKit

//기본자료형 : Bool, Int, UInt, Float, Double, Character, String
// 형변환 : Int(), Double()... -> type : optional, String()
let a = "50"
//if let b = Int(a) {
//    print(b)
//}
let b = Int(a) ?? 40
print(b + 20)
let c = String(b + 20)

print(type(of: c))
print(c)


let d = "5.5"
let e = Double(d) ?? 0.0
print(e)


//기본적으로 형변환 as, is..
//protocal에 의거한 상속관계에서 as, is를 통해서 upCasting, downCasting 가능

//상속관계
//protocal - protocal
//class - class
//class - protocal
//struct - protocal
let bb : AA = BB()
let cc : AA = CC()

print(bb is BB)
print(cc is CC)

(bb as? BB)?.aaa()
(cc as? CC)?.bbb()

print(bb as? CC)


class BB : AA {
    func aaa() {
        print("Hello IOS")
    }
}

struct CC : AA {
    func bbb() {
        print("Hello Swift")
    }
}

protocol AA : DD {

}

protocol DD {
    
}




    

    



