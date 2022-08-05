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
    
    }

}

class AA {
    var a = 10
}

enum 승패 {
    case 승
    case 패
}

