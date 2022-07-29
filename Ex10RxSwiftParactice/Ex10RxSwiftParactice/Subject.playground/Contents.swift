import Foundation
import RxSwift

let disposeBag = DisposeBag()

print("---publishSubject---")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 여러분 안녕하세요")

let 구독자1 = publishSubject
    .subscribe(onNext : {
        print("첫번째 구독자 : \($0)")
    })


publishSubject.onNext("2. 들리세요?")
publishSubject.on(.next("3. 안들리시나요?"))

구독자1.dispose()

let 구독자2 = publishSubject
    .subscribe(onNext : {
        print("두번쨰 구독자 : \($0)")
    })
    

publishSubject.onNext("4. 여보세요")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝났나요?")

구독자2.dispose()


publishSubject
    .subscribe(onNext : {
        print("세번째 구독 : \($0)")
    })
    .disposed(by: disposeBag)

publishSubject.onNext("6. 찍힐까요?")

print("---behaviorSubject---")
enum SubjectError : Error {
    case error1
}
        
let behaivorSubject = BehaviorSubject<String>(value: "초기값")
        
behaivorSubject.onNext("1. 첫번째값")
behaivorSubject.subscribe {
    print("첫번째 구독 :", $0.element ?? $0)
}
.disposed(by: disposeBag)
        
        
       
//behaivorSubject.onError(SubjectError.error1)
        
behaivorSubject.subscribe {
    print("두번째 구독 :", $0.element ?? $0)
}.disposed(by: disposeBag)


let value = try? behaivorSubject.value()
print(value)

print("---ReplaySubject---")
let replaySubjecty = ReplaySubject<String>.create(bufferSize: 2)
replaySubjecty.onNext("1. 여려분")
replaySubjecty.onNext("2. 힘내세요")
replaySubjecty.onNext("3. 어렵더라도!!")

replaySubjecty.subscribe {
    print("첫번째 구독 : ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubjecty.subscribe {
    print("두번째 구독 : ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubjecty.onNext("4. 할수 있어요.")
replaySubjecty.onError(SubjectError.error1)
replaySubjecty.dispose()

replaySubjecty.subscribe {
    print("세번째 구독 : ", $0.element ?? $0)
}.disposed(by: disposeBag)

        
        
