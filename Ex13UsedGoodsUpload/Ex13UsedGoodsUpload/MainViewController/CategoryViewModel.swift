//
//  CategoryViewModel.swift
//  Ex13UsedGoodsUpload
//
//  Created by 도학태 on 2022/08/02.
//

import RxSwift
import RxCocoa

struct CategoryViewModel {
    let disposeBag = DisposeBag()
    
    //viewModel -> View
    let cellData : Driver<[Category]>
    let pop : Signal<Void>
    
    //View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    
    
    
    //viewmodel -> paentViewModel
    let selectedCategory = PublishSubject<Category>()
    
    init() {
        let categories = [
            Category(Id: 1, name: "디지털/가전"),
            Category(Id: 2, name: "게임"),
            Category(Id: 3, name: "스포츠/레저"),
            Category(Id: 4, name: "유아/아동용품"),
            Category(Id: 5, name: "여성패션/잡화"),
            Category(Id: 6, name: "뷰티/미용"),
            Category(Id: 7, name: "남성패션/잡화"),
            Category(Id: 8, name: "생활/식품"),
            Category(Id: 9, name: "가구"),
            Category(Id: 10, name: "도서/티켓/취미"),
            Category(Id: 11, name: "기타"),
        ]
        
        self.cellData = Driver.just(categories)
        
        self.itemSelected
            .map { categories[$0] }
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
        
        self.pop = itemSelected
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())

    }
}
