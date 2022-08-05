//
//  ViewController.swift
//  Ex15RxOperatorMPractice
//
//  Created by 도학태 on 2022/08/05.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = PublishSubject<String>()
        
        a
            .ignoreElements()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        
        a.onNext("Hello Rx")
        a.onNext("Hello Rx")
        a.onNext("Hello Rx")
        a.onError(MyError.anError)

        let b = PublishSubject<String>()
        
        b
            .element(at: 2) // 0, 1, 2 [특정 인덱스만 처리...]
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        b.onNext("1. RxSwift")
        b.onNext("2. Hello RxSwift")
        b.onNext("3. Hello IOS")
        
        
        
        Observable.of(1, 2, 3, 4, 5 ,6 ,7 ,8)
            .filter {
                $0 % 2 == 1
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        Observable.of("Hello", "Swift", "IOS", "Rx")
            .skip(2) // 2번 이전은 스킵 즉 0, 1 index skip....
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        print()
        
        Observable.of("Hello", "Swift", "IOS", "Rx")
            .skip(while: {
                $0 != "IOS" // false가 나타나기 전까지는 안내보내 다가 false이면 그때부터 방출
            })
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        print()
        
        let c = PublishSubject<String>()
        let d = PublishSubject<String>()
        
        c
            .skip(until: d)
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        c.onNext("안녕")
        c.onNext("IOS")

        d.onNext("땡!")
        c.onNext("RxSwift2")
        c.onNext("RxSwift3")
        
        print()
        
        Observable.of("Hello", "IOS", "Android", "RxSwift", "Swift", "Kotlin")
            .take(3) // 0,1,2 3번 전까지만 take하고 이후에는 하지마 skip의 반대죵?/
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        print()
        
        Observable.of("Hello", "IOS", "Android", "RxSwift", "Swift", "Kotlin")
            .take(while: {
                $0 != "Android"
            })
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
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
        수강신청.onNext("RXSwift GOOD")
        
        print()
        Observable.of("Hello", "IOS", "Android", "RxSwift", "Swift", "Kotlin")
            .enumerated() // index가 필요하면 이거 사용....
            .filter {
                $0.index < 3
            }
            .subscribe(onNext : {
                print($0.element)
            })
            .disposed(by: disposeBag)
        
        
        Observable.of("저는", "저는", "앵무세", "앵무세", "입니다", "입니다", "입니다", "입니다", "저는", "앵무세", "일까요?", "일까요?")
            .distinctUntilChanged() // 인접한 중복 값을 처리해줌...
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        //transform Operator
        Observable.of("A", "B", "C")
            .toArray()
            .subscribe(onSuccess : {
                print($0) // -> element : [String]
            })
            .disposed(by: disposeBag)
        
        
       Observable.of(Date())
            .map { date -> String in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY.MM.dd"
                dateFormatter.locale = Locale(identifier: "ko_KR")
                return dateFormatter.string(from: date)
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        print()

        let 한국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
        let 미국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

        let 올림픽경기 = PublishSubject<선수>()
        
        

        올림픽경기
            .flatMap { 선수 -> Observable<Int> in
                print("Hello")
                return 선수.점수
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)


        올림픽경기.onNext(한국국가대표)
        한국국가대표.점수.onNext(10)

        올림픽경기.onNext(미국국가대표)

        한국국가대표.점수.onNext(10)
        미국국가대표.점수.onNext(9)
        
        print()
        
        let 서울 = 높이뛰기선수(점수: BehaviorSubject(value: 7))
        let 제주 = 높이뛰기선수(점수: BehaviorSubject(value: 6))

        let 전국체전 = PublishSubject<선수>()

        전국체전
            .flatMapLatest { 선수 in
                선수.점수
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)


        전국체전.onNext(서울)
        서울.점수.onNext(9)


        전국체전.onNext(제주)
        서울.점수.onNext(10)
        제주.점수.onNext(8)
        
        print()
        
        
        let 김토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
        let 박치타 = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

        let 달리기100M = BehaviorSubject<선수>(value: 김토끼)

        달리기100M
            .flatMapLatest { 선수 in
                선수.점수.materialize()
            }
            .filter {
                guard let error = $0.element else {
                    return true
                }
                print(error)
                return false
            }
            .dematerialize()
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)

        김토끼.점수.onNext(1)
        김토끼.점수.onError(반칙.부정출발)
        김토끼.점수.onNext(2)

        달리기100M.onNext(박치타)
        
    }
    
    
    



}

struct 높이뛰기선수 : 선수 {
    var 점수: BehaviorSubject<Int>
}

protocol 선수 {
    var 점수 : BehaviorSubject<Int> {get}
}

struct 양궁선수 : 선수 {
    var 점수 : BehaviorSubject<Int>
}

enum MyError : Error {
    case anError
}

enum 반칙 : Error {
    case 부정출발
}

struct 달리기선수 : 선수 {
    var 점수 : BehaviorSubject<Int>
}

