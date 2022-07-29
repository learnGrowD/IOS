import Foundation
import RxSwift

let disPoseBag = DisposeBag()

enum TraitsError : Error {
    case single
    case maybe
    case completable
}

print("---single1---")
Single<String>.just("good")
    .subscribe(onSuccess: {
        print($0)
    }, onFailure: {
        print("error : \($0)")
    }, onDisposed: {
        print("Disposed")
    }).disposed(by: disPoseBag)

print("---single2---")
Observable<String>.create { observer -> Disposable in
        observer.onError(TraitsError.single)
        return Disposables.create()
    }
    .asSingle()
    .subscribe {
        print($0)
    } onFailure: {
        print("error : \($0.localizedDescription)")
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disPoseBag)

print("---single3---")
struct SomeJson : Decodable {
    let name : String
}

enum JSONError : Error {
    case decodingError
}

let json1 = """
    {"name" : "Do"}
    """

let json2 = """
    {"my_name" : "young"}
    """

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

decode(json: json1)
    .subscribe {
        switch $0 {
        case.success(let json):
            print(json.name)
        case.failure(let error):
            print(error)
        }
    }
    .disposed(by: disPoseBag)

decode(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }.disposed(by: disPoseBag)



print("---Maybe1---")
Maybe<String>.just("Good")
    .subscribe {
        print($0)
    } onError: {
        print($0)
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("disposed")
    }.disposed(by: disPoseBag)

print("---Maybe2---")
Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.maybe)
    return Disposables.create()
}
.asMaybe()
.subscribe {
    print("성공 \($0)")
} onError: {
    print("에러 \($0)")
} onCompleted: {
    print("completed")
} onDisposed: {
    print("disposed")
}.disposed(by: disPoseBag)

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
}).disposed(by: disPoseBag)

print("---Completable2---")

Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disPoseBag)








