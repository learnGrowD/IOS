import UIKit

var aa : AA? = .init(c : true)
let bb : BB = .init(c : false)
var bb2 : BB = .init(c : true)
aa?.a = 30
aa?.aaa()

//ValueType은 Vlue이기 때문에 let으로 선언하면 당연히 접근 할 수 없다.
//bb.a = 50
//bb.bbb()

bb2.a = 50
bb2.bbb()


//print(aa?.e)
//aa?.e = "willd"
//print(aa?.e)
aa = nil

//저장 프로퍼티
class AA {
    var a : Int = 10
    var b : String?
    var c : Bool
    let d : String = "Hello class"
    lazy var e = "IOS"
    init(c : Bool) {
        self.c = c
    }
    
    init(cc : Bool) { //전달인자 레벨을 통한 생성자 overloading..
        self.c = cc
    }
    
    func aaa() {
        print("\(a) : \(d)")
    }
    

    
    deinit {
        print("AA instance deinit")
    }

}

struct BB {
    var a : Int = 20
    var b : String?
    var c : Bool
    let d : String = "Hello struct"
    init(c : Bool) {
        self.c = c
    }
    
    func bbb() {
        print("\(a) : \(d)")
    }
}

class CC : AA {
    var aka : String
    init(aka : String) {
        self.aka = aka // 자식 초기화 먼저
        super.init(c: false) //그다음 부모 초기화..
    }

}


//계산 프로퍼티

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center : Point { // origin에 대한 getter, setter...
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//읽기전용 프로퍼티
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume : Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print(fourByFiveByTwo.volume)

//프로퍼티 옵저버.. ***
class StepCounter {
    var totalSteps : Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360
stepCounter.totalSteps = 896


struct SomeStructure {
    static var storedTypePropery = "Some Value.."
    static var CoputedTypeProperty : Int {
        return 1
    }
}


protocol FullyNamedProtocal {
    var name : String {get}
    static var age : Int {get set}
    func sum()

}

class FullyNamed : FullyNamedProtocal {
    
    var name: String {
        return ""
    }
    
    static var age: Int = 10
    
    func sum() {
        print("")
    }
}



//extension class, struct, emum에 새로운 property, 새로운 method 정의 가능
//특정 protocal을 confirm 하도록 확장 가능 (where을 통해서 제약도 걸어 줄 수 있음..) -> BindingAdapter
extension String {
    
}


//emum -> Sealed class
// 관련값
// Raw값 : Int, Character, String, Floating
// 진가는 switch Case, DataStream에서 발휘 될거 같다.
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune // Raw값을 설정안해줘도 온전한 값...
}


