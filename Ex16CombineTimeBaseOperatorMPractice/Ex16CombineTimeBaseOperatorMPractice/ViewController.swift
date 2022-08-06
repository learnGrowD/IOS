//
//  ViewController.swift
//  Ex16CombineTimeBaseOperatorMPractice
//
//  Created by 도학태 on 2022/08/05.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.of("A","B","C")
            .enumerated()
            .map { index, element in
                "\(element) 어린이 \(index)"
            }
            .startWith("선생님")
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        let a = Observable<String>.of("1", "2", "3")
        let b = Observable<String>.of("선생님")
        
        Observable
            .concat([a, b])
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        b
            .concat(a)
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        let aa : [String : Observable<String>] = [
            "노랑반" : Observable.of("1", "2", "3"),
            "파랑반" : Observable.of("4", "5", "6")
        ]
        
        
        Observable.of("노랑반", "파랑반")
            .concatMap { 반 in
                aa[반] ?? .empty()
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구", "AA"])
        let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천궅"])
        
        Observable.of(강북, 강남)
            .merge()
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        print()
        
        Observable.of(강북, 강남)
            .merge(maxConcurrent: 1)
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
            
            
            
        print()
        let 성 = PublishSubject<String>()
        let 이름 = PublishSubject<String>()
        
        Observable
            .combineLatest(성, 이름) { 성, 이름 in
                성 + 이름
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        성.onNext("김")
        이름.onNext("똘똘")
        이름.onNext("영수")
        이름.onNext("은영")
        성.onNext("박")
        성.onNext("이")
        성.onNext("조")
        
        
        let lastName = PublishSubject<String>()
        let firstName = PublishSubject<String>()

        let fulName = Observable
            .combineLatest([lastName, firstName]) { name in
                name.joined(separator: " ")
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)

        lastName.onNext("Kim")
        firstName.onNext("Paul")
        firstName.onNext("Stella")
        firstName.onNext("Lily")
        lastName.onNext("Do")
        
        
        let 승부 = Observable<승패>.of(.승, .승, .패, .승, .패)
        let 선수 = Observable<String>.of("한국", "스위스", "미국", "일본", "중국", "브라질")

        
        let 시험결과 = Observable
            .zip(승부, 선수) { 결과, 대표선수 in
                return 대표선수 + "선수 " + "\(결과)"
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        let 발사 = PublishSubject<Void>()
        let 달리기선수 = PublishSubject<String>()

        발사
            .withLatestFrom(달리기선수)
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        달리기선수.onNext("1")
        달리기선수.onNext("1, 2")
        달리기선수.onNext("1, 2, 3")
        발사.onNext(Void())
        
        
        
        let 출발 = PublishSubject<Void>()
        let F1선수 = PublishSubject<String>()

        F1선수
            .sample(출발)
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)


        F1선수.onNext("1")
        F1선수.onNext("1, 2")
        F1선수.onNext("1,   2, 3")
        출발.onNext(Void())
        F1선수.onNext("1,   2, 3, 4")
        출발.onNext(Void())
//        출발.onNext(Void())
        
        let aab1 = PublishSubject<String>()
        let aab2 = PublishSubject<String>()
        
        let 선착순 = aab1.amb(aab2) //둘중 먼저 도달한 친구만 출력
        
        선착순
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        aab2.onNext("안녕하세요")
        aab1.onNext("Hello")
        aab2.onNext("RxSwift")
        aab1.onNext("RxKotilin")
        aab1.onNext("RxJava")
        
        let 학생1 = PublishSubject<String>()
        let 학생2 = PublishSubject<String>()
        let 학생3 = PublishSubject<String>()
        
        let 손들기 = PublishSubject<Observable<String>>()
        let 손든사람만말할수있는교실 = 손들기.switchLatest()
        
        
        손든사람만말할수있는교실
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        손들기.onNext(학생1)

        학생1.onNext("학생1 : ㅁㅁ")
        학생2.onNext("학생2 : ㅁㅁㅁㄴㅇ")


        손들기.onNext(학생2)
        학생2.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱ")
        학생1.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍ")

        손들기.onNext(학생3)
        학생2.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱㅂㄷㅎㄹㅎㄷㅉㄷㅎ")
        학생3.onNext("학생3 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍqwdqwdqwdqwqwf")

        손들기.onNext(학생1)
        학생1.onNext("학생1 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱㅂㄷㅎㄹㅎㄷㅉㄷㅎㅂㅈㅇㅂㅈㅇ")
        학생2.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍqwdqwdqwdqwㅈㄷㄹㅈㄷㄱ혿ㄱㅎqwf")
        학생3.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱㅂㄷㅎㄹㅎㄷㅉㄷㅎ")
        학생1.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍqwdqwdqwdㅈㄷㅎㄹㅎㅈㄷㄱㅎㅈㄷㅎqwqwf")
            
        
        Observable.from((1...10))
            .reduce(0) {
                $0 + $1
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        Observable.from((1...10))
            .scan(0) {
                $0 + $1
            }
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        print("-----replay-----")
        let 인사말 = PublishSubject<String>()
        let 반복하는앵무새 = 인사말.replay(1)

        반복하는앵무새.connect()
        인사말.onNext("1. Hello")
        인사말.onNext("2. hi")

        반복하는앵무새
            .subscribe(onNext : {
            print($0)
            })
            .disposed(by: disposeBag)

        인사말.onNext("3. 안녕하세요")
        
        let 닥터스트레인지 = PublishSubject<String>()
        let 타임스톤 = 닥터스트레인지.replayAll()
        타임스톤.connect()
        
        닥터스트레인지.onNext("1. 도르마무")
        닥터스트레인지.onNext("2. 거래를 하러왔다")
        닥터스트레인지.onNext("3. 거래를 하러왔다")
        
        
        타임스톤
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
//        Observable<Int>
//            .interval(
//                .seconds(3),
//                scheduler: MainScheduler.instance
//            )
//            .subscribe(onNext : {
//                print($0)
//            })
//            .disposed(by: disposeBag)

//
//        Observable<Int>
//            .timer(
//                .seconds(5),
//                period: .seconds(1),
//                scheduler: MainScheduler.instance
//            )
//            .subscribe(onNext : {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
    }

}

class AA {
    var a = 10
}

enum 승패 {
    case 승
    case 패
}

