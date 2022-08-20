//
//  HomeViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/09.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit

class HomeViewController : UIViewController {
    let disposeBag = DisposeBag()
    var viewModel : HomeViewModel?
    var homeData : [HomePageData] = []
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .willdBlack
        $0.register(DefaultCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DefaultCollectionViewHeader")
        $0.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendCollectionViewCell")
        $0.register(TierTagsCollectionViewCell.self, forCellWithReuseIdentifier: "TierTagsCollectionViewCell")
        $0.register(TierCollectionViewCell.self, forCellWithReuseIdentifier: "TierCollectionViewCell")
        $0.register(PlayerRankCollectionViewCell.self, forCellWithReuseIdentifier: "PlayerRankCollectionViewCell")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ viewModel : HomeViewModel) {
        self.viewModel = viewModel
        collectionView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)
        
        viewModel.homeData
            .drive(onNext : { [weak self] in
                self?.homeData = $0
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .bind(onNext : { [weak self] index in
                guard let self = self else { return }
                switch self.homeData[index.section] {
                case.championRecommend( _, let data):
                    let championDetailVc = ChampionDetailViewController().then { vc in
                        let viewModel = ChampionDetailViewModel(championKey: data[index.row].champion.championKey ?? "", championName: data[index.row].champion.name ?? "")
                        vc.hidesBottomBarWhenPushed = true
                        vc.bind(viewModel)
                        vc.view.backgroundColor = .willdBlack
                        vc.title = data[index.row].champion.name
                    }
                    self.show(championDetailVc, sender: nil)
                case.championTier( _, let data):
                    let championDetailVc = ChampionDetailViewController().then { vc in
                        let viewModel = ChampionDetailViewModel(championKey: data[index.row].championKey ?? "", championName: data[index.row].championName ?? "")
                        vc.hidesBottomBarWhenPushed = true
                        vc.bind(viewModel)
                        vc.view.backgroundColor = .willdBlack
                        vc.title = data[index.row].championName
                    }
                    self.show(championDetailVc, sender: nil)
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        collectionView.collectionViewLayout = generateLayout()
            
    }
    
    private func layout() {
        [collectionView].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//createLayout
extension HomeViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.homeData[sectionNumber] {
            case .championRecommend( _, _):
                return self.createChampionRecommendLayout()
            case .championTier( _, _):
                return self.createTierListLayout()
            case .championTags( _):
                return self.createTierTagsLayout()
            case .playerLank( _, _):
                return self.createPlayerRankLayout()
            
            }
        }
    }
    
    func createHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(24))
        
        let section = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return section
    }
    
    func createChampionRecommendLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 18
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(3/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets.trailing = 18
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = .init(top: 18, leading: 18, bottom: 64, trailing: 0)

        return section
    }
    
    func createTierTagsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(24))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 18, leading: 18, bottom: 12, trailing: 18)
        section.boundarySupplementaryItems = [self.createHeaderLayout()]
        return section
    }
    
    func createTierListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 18
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 18, bottom: 80, trailing: 18)
        section.interGroupSpacing = 24
        return section
    }
    
    func createPlayerRankLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [self.createHeaderLayout()]
        section.contentInsets = .init(top: 18, leading: 10, bottom: 80, trailing: 10)
        section.interGroupSpacing = 32
        return section
    }
    
}


extension HomeViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch homeData[section] {
        case .championRecommend( _, let data):
            return data.count
        case.championTags( _):
            return 1
        case .championTier( _, let data):
            return data.count
        case .playerLank( _, let data):
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch homeData[indexPath.section] {
        case .championRecommend( _, _):
            guard let viewModel = self.viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(row : Observable.just(indexPath.row) ,viewModel.recommendViewModel)
            return cell
        case.championTags( _):
            guard let viewModel = self.viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TierTagsCollectionViewCell", for: indexPath) as? TierTagsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(viewModel.tierTagsViewModel)
            return cell
        case .championTier( _, _):
            guard let viewModel = self.viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TierCollectionViewCell", for: indexPath) as? TierCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(row : Observable.just(indexPath.row) ,viewModel.tierListViewModel)
            return cell
        case .playerLank( _, _):
            guard let viewModel = self.viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerRankCollectionViewCell", for: indexPath) as? PlayerRankCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(row : Observable.just(indexPath.row) ,viewModel.playerLankViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DefaultCollectionViewHeader", for: indexPath) as! DefaultCollectionViewHeader
            switch homeData[indexPath.section] {
            case .championRecommend(let title, _):
                header.configure(title: title)
            case.championTags(let title):
                header.configure(title: title)
            case .championTier(let title, _):
                header.configure(title: title)
            case .playerLank(let title, _):
                header.configure(title: title)
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}
