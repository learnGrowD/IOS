//
//  MainViewController.swift
//  Ex14RxSwiftMPractice
//
//  Created by 도학태 on 2022/08/05.
//

import Foundation
import UIKit
import RxSwift


class MainViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observable...
        //trips
        //subject..
        
        
        //Observable 기본
        Observable<Int>.just(1)
            .subscribe(onNext : { _ in
                print("AAAA")
            })
        
        Observable<Int>.of(1, 2, 3, 4, 5)
            .subscribe(onNext : {
                print($0)
            })
        
        Observable.of([1, 2, 3, 4, 5])
            .subscribe(onNext : {
                print($0)
            })
        
        Observable.from([1, 2, 3, 4, 5])
            .subscribe(onNext : {
                print($0)
            })
        
        
        Observable.of(1, 2, 3)
            .subscribe {
                print($0)
            }
        
        Observable.of(1, 2, 3)
            .subscribe {
                if let elment = $0.element {
                    print(elment)
                }
            }
        
        Observable.of(1, 2, 3)
            .subscribe(onNext : {
                print($0)
            })
        
        Observable<Void>.empty()
            .subscribe {
                print($0)
            }
        
        Observable<Void>.never()
            .debug("never")
            .subscribe {
                print($0)
            }
        
        let disposeBag = DisposeBag()
        Observable.range(start: 1, count: 9)
            .subscribe(onNext : {
                print("2*\($0)=\(2*$0)")
            }).disposed(by: disposeBag)
        
        Observable.range(start: 1, count: 9)
            .subscribe(onNext : {
                print("2*\($0)=\(2*$0)")
            }).dispose()
        
        
        Observable<Any>.create { observer -> Disposable in
            observer.onNext(11)
        //    observer.on(.next(1))
            observer.onCompleted()
        //    observer.on(.completed)
            observer.onNext(22)
            return Disposables.create()
        }.subscribe { a in
            print(a)
        } onError: { e in
            print(e)
        } onCompleted: {
            print("Complete")
        } onDisposed: {
            print("disposeHH")
        }

        
        Observable<Int>.create { observer -> Disposable in
            observer.onNext(1)
            observer.onError(MyError.anError)
            observer.onCompleted()
            observer.onNext(2)
            return Disposables.create()
        
        }
        .subscribe {
            print($0)
        }.disposed(by: disposeBag)
        //Observable을 만들어 내는 팩토리를 리턴
        Observable.deferred {
            Observable.of(1, 2, 3)
        }
        .subscribe(onNext : {
            print($0)
        })
        .disposed(by: disposeBag)
        
        var isA : Bool = false
        let t : Observable<String> = Observable.deferred {
            isA = !isA
            if isA {
                return Observable.of("A")
            }else {
                return Observable.of("B")
            }
        }
        
        for _ in 0...3 {
            t
                .subscribe(onNext : {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        
        //subject
        //1. PublishSubject
        //2. BehaviorSubject
        //3. RelaySubject
        
        
        let publishSubject = PublishSubject<String>()
        
        publishSubject.onNext("1. 여러분 안녕하세요")
        
        let 구독자1 = publishSubject
            .subscribe(onNext : {
                print($0)
            })
            
        
        
        publishSubject.onNext("2. 들리세요?")
        publishSubject.on(.next("3. 안들리시나요?"))
        
        구독자1.dispose()
        
        let 구독자2 = publishSubject
            .subscribe {
                print("두번째 구독 : \($0)")
            }
            

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
            print("첫번째 구독 :", $0)
        }
        .disposed(by: disposeBag)
                
        behaivorSubject.onError(MyError.anError)
                
        behaivorSubject.subscribe {
            print("두번째 구독 :", $0)
        }.disposed(by: disposeBag)
        
        behaivorSubject.onNext("2. HELLO")
        
        
        behaivorSubject.subscribe {
            print("세번째 구독 :", $0)
        }.disposed(by: disposeBag)


        let value = try? behaivorSubject.value()
        print(value)
        
        
        
        print("---ReplaySubject---")
        let replaySubjecty = ReplaySubject<String>.create(bufferSize: 2)
        replaySubjecty.onNext("1. 여려분")
        replaySubjecty.onNext("2. 힘내세요")
        replaySubjecty.onNext("3. 어렵더라도!!")

        replaySubjecty.subscribe { a in
            print(a)
        } onError: { e in
            print(e)
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("dispose")
        }

        

        replaySubjecty.subscribe {
            print("두번째 구독 : ", $0.element ?? $0)
        }
        .disposed(by: disposeBag)

        replaySubjecty.onNext("4. 할수 있어요.")
        replaySubjecty.onNext("5. ㅎㅎ")
        replaySubjecty.onError(MyError.anError)
        replaySubjecty.dispose()
        

        replaySubjecty.subscribe {
            print("세번째 구독 : ", $0.element ?? $0)
        }.disposed(by: disposeBag)
        
        
        
        //traits..
        //1. Single // 단일 element만 방출하는것을 보장
        //2. Maybe // onSuccess, onFailer, onComplete..
        //3. Completed element를 방출하지 않는 것을 보장
        enum TraitsError : Error {
            case single
            case maybe
            case completable
        }
        
        Single<String>.just("Good")
            .subscribe(onSuccess: {
               print($0)
            }, onFailure: {
                print("error : \($0)")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)

        Observable<String>.create { observer -> Disposable in
            observer.onError(TraitsError.single)
            return Disposables.create()
        }
        .asSingle()
        .subscribe(onSuccess: {
            print($0)
        }, onFailure: {
            print("Error : \($0)")
        }, onDisposed: {
            print("Disposed")
        })
        .disposed(by: disposeBag)

        
        
        let json1 = """
            {"name" : "Do"}
        """
        let json2 = """
            {"my_name" : "Young"}
        """
        
        decode(json: json1)
            .subscribe {
                switch $0 {
                case .success(let json):
                    print(json.name)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        decode(json: json2)
            .subscribe {
                switch $0 {
                case .success(let json):
                    print(json)
                case .failure(let error):
                    print(error)
                    
                }
            }
        
        
        print("Maybe")
        Maybe<String>.just("Good RxSwift")
            .subscribe(onSuccess: {
                print($0)
            }, onError: {
                print("error : \($0)")
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
               print("DisPosed")
            })
            .disposed(by: disposeBag)
        
        Maybe<String>.create { observer -> Disposable in
            observer(.success("Hello"))
            observer(.success("dd"))
            return Disposables.create()
        }
        .subscribe(onSuccess: {
            print($0)
        }, onError: {
            print("error : \($0)")
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
           print("DisPosed")
        })
        .disposed(by: disposeBag)
        
        print("---Completable1---")
        Completable.create { observer -> Disposable in
            observer(.error(TraitsError.completable))
            return Disposables.create()
        }
        .subscribe(onCompleted: {
            print("Ccompleted")
        }, onError: {
            print("Error : \($0)")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)

        print("---Completable2---")

        Completable.create { observer -> Disposable in
            observer(.completed)
            return Disposables.create()
        }
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
        
    }
    
    func decode(json : String) -> Single<SomeJson> {
        Single<SomeJson>.create { observer -> Disposable in
            guard let data = json.data(using: .utf8),
                  let json = try? JSONDecoder().decode(SomeJson.self, from: data) else {
                observer(.failure(JSONError.decodingError))
                return Disposables.create()
            }
            observer(.success(json))
            return Disposables.create()
        }
    }
    
}


enum JSONError : Error {
    case decodingError
}


enum MyError : Error {
    case anError
}

struct SomeJson : Decodable {
    let name : String
}
