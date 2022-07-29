import Foundation
import RxSwift


print("----just----")
Observable<Int>.just(1)
    .subscribe(onNext: { _ in
        print("aaaaa")
    })

print("----of1----")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext : {
        print($0)
    })

print("----of2----")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext : {
        print($0)
    })


print("----from----") //only array //array안의 각각의 요소들을 뽑아내서 방출함...
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext : {
        print($0)
    })

print("----Subscribe1----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("----Subscribe2----")
Observable.of(1, 2, 3)
    .subscribe {
        if let elment = $0.element {
            print(elment)
        }
    }


print("----Subscribe3----")
Observable.of(1, 2, 3)
    .subscribe(onNext : {
        print($0)
    })

print("----empty----")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("----Never----")
Observable<Void>.never()
    .debug("never")
    .subscribe(onNext : {
        print($0)
    }, onCompleted: {
        print("Completed")
    })

print("----range----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
      print("2*\($0)=\(2*$0)")
    })

print("----dispose----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
      print($0)
    })
    .dispose()

print("----disposeBag----")
let disposBag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposBag)

print("----create1----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
//    observer.on(.next(1))
    observer.onCompleted()
//    observer.on(.completed)
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}.disposed(by: disposBag)

print("----create2----")
enum MyError : Error {
    case anError
}

Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(1)
    return Disposables.create()
}
.subscribe {
    print($0)
} onError: {
    print($0.localizedDescription)
} onCompleted: {
    print("Completed")
} onDisposed: {
    print("Disposed")
}
.disposed(by: disposBag)

print("----deffered1----")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}.disposed(by: disposBag)

print("----deffered2----")
var 뒤집기 : Bool = false

let factory : Observable<String> = Observable.deferred {
    뒤집기 != 뒤집기
    if 뒤집기 {
        return Observable.of("A")
    }else {
        return Observable.of("B")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext :{
        print($0)
    })
    .disposed(by: disposBag)
}





    

