import RxSwift

let disposeBag = DisposeBag()
print("---ignoreElements---")
let 취침모드 = PublishSubject<String>()
취침모드
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

취침모드.onNext("Hello Rx")
취침모드.onNext("Hello Rx")
취침모드.onNext("Hello Rx")

취침모드.onCompleted()

print("---elementAt---")
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2) //특정 인덱스만 처리한다.
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("Hello Rx")      //index 0
두번울면깨는사람.onNext("Hello RxSwift") //index 1
두번울면깨는사람.onNext("Hello Rx")      //index 2
두번울면깨는사람.onNext("Hello Rx")      //index 3


print("---fillter---")

Observable.of(1, 2, 3, 4, 5, 6, 7, 8) //[1, 2, 3, 4, 5, 6, 7, 8]
    .filter {
        $0 % 2 == 0
    }
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

print("----skip---")
Observable.of("Hello", "IOS", "Rx", "Swift")
    .skip(2)
    .subscribe(onNext : {
        print($0)
    }).disposed(by: disposeBag)

print("----skipWhile---")
Observable.of("Hello", "IOS", "Rx", "Swift")
    .skip(while:  {
        $0 != "Hello"
    })
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)


print("----skipUntil---")

let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님 // 현재 observable
    .skip(until: 문여는시간) // 다른 observalbe
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("Hello")
손님.onNext("IOS")

문여는시간.onNext("땡!")
손님.onNext("RxSwift")


print("----take---")
Observable.of("Hello", "IOS", "Android", "RxSwift", "Swift", "Kotlin")
    .take(3)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)


print("----takeWhile---")
Observable.of("Hello", "IOS", "Android", "RxSwift", "Swift", "Kotlin")
    .take(while: {
        $0 != "Android"
    })
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

    
print("---enumerated---")
Observable.of("Hello", "IOS", "Android", "RxSwift", "Swift", "Kotlin")
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

print("---takeUntil---")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("HAHA")
수강신청.onNext("RxSwift")

신청마감.onNext("끝!")
수강신청.onNext("IOS")


print("---distinctUntilChanged---")
Observable.of("저는", "저는", "앵무세", "앵무세", "입니다", "입니다", "입니다", "입니다", "저는", "앵무세", "일까요?", "일까요?")
    .distinctUntilChanged()
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)















