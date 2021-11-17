import UIKit


class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
    
}

extension UserStruct {
    init(age: Int) {
        self.name = "손님"
        self.age = age
    }
}

// 인스턴스는 저장 프로퍼티를 초기화 해야한다.
let a = User() // 초기화구문, 초기화 메서드 -> Defalut Initializer
let b = UserStruct(name: "", age: 9) // -> Memberwise Initializer
let c = UserStruct()

let color = UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
let color2 = UIColor.init(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
// .init 초기화 메서드 생략 가능

class Coffee {
    let shot: Int
    let size: String
    let menu: String
    let mind: String
    
    // Designated initializer
    init(shot: Int, size: String, menu: String, mind: String) {
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    convenience init(value: String) {
        self.init(shot: 2, size: "보통", menu: value, mind: "대략정성")
    }
    
    let coffee = Coffee(shot: 2, size: "크게", menu: "아아", mind: "정성듬뿍")
    let coffee2 = Coffee(value: "뜨아")
}

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let customColor = UIColor(red: 28, green: 12, blue: 205)


// 프로토콜 - 프로퍼티, 메서드, 초기화 구문
protocol Seuoh {
    // getter, setter -> 확인 !
    init() // 초기화 구문
}
// ---------------------------------
//class Hello: Seuoh {
//    required init() {
//
//    }
//    func welcome() {
//        print("Welcome")
//    }
//}
//
//class HelloBrother: Hello {
//    required init() {
//
//    }
//}
// ---------------------------------

class Hello {
    init() {
        print("Hello")
    }
}

class HelloBrother: Hello, Seuoh {
    required override init() {
        super.init()
        print("HelloBrother")
    }
}

let hello = HelloBrother()

// 초기화 구문 델리게이션
class A {
    var value: Int
    
    init() {
        self.value = 10
    }
}

class B: A {
    override init() {
        super.init()
        print("B")
    }
}

class C: B {
    override init() {
        super.init()
    }
    deinit {
        print("deinit")
    }
}

var test: C? = C()
test = nil
