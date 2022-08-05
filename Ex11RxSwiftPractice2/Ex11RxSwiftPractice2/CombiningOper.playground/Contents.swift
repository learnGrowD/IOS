import RxSwift
import Foundation

let disposBag = DisposeBag()

print("-----starWith-----")
let 노랑반 = Observable.of( "1", "2", "3" )

노랑반
    .enumerated()
    .map { index, element in
        element + "어린이" + "\(index)"
    }
    .startWith("선생님") // String
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

print("-----concat1-----")
let 노랑반어린이들 = Observable<String>.of("1", "2", "3")
let 선생님 = Observable<String>.of("선생님")


let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

print("-----concat2-----")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

print("-----concatMap-----") //flatMap
let 어린이집 : [String : Observable<String>] = [
    "노랑반" : Observable.of("1", "2", "3"),
    "파랑반" : Observable.of("4", "5")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)


print("-----merge1-----")
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구", "AA"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천궅"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

print("-----merge2-----")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)



print("-----combineLatest1-----")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")

print("-----combineLatest2-----")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(
        날짜표시형식,
        현재날짜,
        resultSelector: { 형식, 날짜 -> String in
            let dataFormatter = DateFormatter()
            dataFormatter.dateStyle = 형식
            return dataFormatter.string(from: 날짜)
        }
        
    )

현재날짜표시
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)


print("-----combineLatest3-----")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fulName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }
    
fulName
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")

print("-----zip-----")
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승, .패)
let 선수 = Observable<String>.of("한국", "스위스", "미국", "일본", "중국", "브라질")

let 시험결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }

시험결과
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)



//triger...
print("-----withLatestFrom1-----")
let 발사 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

발사
    .withLatestFrom(달리기선수)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

달리기선수.onNext("1")
달리기선수.onNext("1, 2")
달리기선수.onNext("1, 2, 3")
발사.onNext(Void())
발사.onNext(Void())


print("-----sample-----")
let 출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(출발)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)


F1선수.onNext("1")
F1선수.onNext("1, 2")
F1선수.onNext("1,   2, 3")
출발.onNext(Void())
출발.onNext(Void())
출발.onNext(Void())


print("-----amb-----")
let 버스 = PublishSubject<String>()
let 버스2 = PublishSubject<String>()

let 버스정류장 = 버스.amb(버스2)

버스정류장
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

print("-----switchLatest-----")
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만말할수있는교실 = 손들기.switchLatest()

손든사람만말할수있는교실
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)

손들기.onNext(학생1)

학생1.onNext("학생1 : ㅁㅁ")
학생2.onNext("학생2 : ㅁㅁㅁㄴㅇ")


손들기.onNext(학생2)
학생2.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱ")
학생1.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍ")

손들기.onNext(학생3)
학생2.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱㅂㄷㅎㄹㅎㄷㅉㄷㅎ")
학생3.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍqwdqwdqwdqwqwf")

손들기.onNext(학생1)
학생1.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱㅂㄷㅎㄹㅎㄷㅉㄷㅎㅂㅈㅇㅂㅈㅇ")
학생2.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍqwdqwdqwdqwㅈㄷㄹㅈㄷㄱ혿ㄱㅎqwf")
학생3.onNext("학생2 : ㅁㅁㅁㄴㅇㅂㅈㅎㄱㄷㅎㄷㄱㅂㄷㅎㄹㅎㄷㅉㄷㅎ")
학생2.onNext("학생1 : ㅁㅁㅂㅈㅇㅎㄹㅇㅍㅌㅊㅍㅌㅊㅍqwdqwdqwdㅈㄷㅎㄹㅎㅈㄷㄱㅎㅈㄷㅎqwqwf")


print("-----reduce-----")
Observable.from((1...10))
    .reduce(0, accumulator: { sumary, newValue in
        return sumary + newValue
    })
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)


print("-----scan-----")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposBag)


    
