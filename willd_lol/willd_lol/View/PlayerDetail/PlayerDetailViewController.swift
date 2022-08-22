//
//  PlayerDetailViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit
import Alamofire

class PlayerDetailViewController : UIViewController {
    let disposeBag = DisposeBag()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .willdBlack
        $0.register(DefaultCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DefaultCollectionViewHeader")
        $0.register(SummonerCollectionViewCell.self, forCellWithReuseIdentifier: "SummonerCollectionViewCell")
        $0.register(MostChampionGuideCollectionViewCell.self, forCellWithReuseIdentifier: "MostChampionGuideCollectionViewCell")
        $0.register(MostChampionCollectionViewCell.self, forCellWithReuseIdentifier: "MostChampionCollectionViewCell")
        $0.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: "MatchCollectionViewCell")
    }
    
    var playerDetailData : [PlayerDetailData] = []
    var viewModel : PlayerDetailViewModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ viewModel : PlayerDetailViewModel) {
        self.viewModel = viewModel
        
        viewModel.playerDetailData
            .filter { !$0.isEmpty }
            .drive(onNext : { [weak self] in
                self?.playerDetailData = $0
                self?.collectionView.reloadData()
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


//layout...
extension PlayerDetailViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.playerDetailData[sectionNumber] {
            case.summoner( _, _):
                return self.createSummnerLayout()
            case.mostChampionGuide( _, _):
                return self.createMostChampionGuideLayout()
            case.mostChampion( _, _):
                return self.createMostChampionLayout()
            case.match( _, _):
                return self.createMatchLayout()
            }
        }
    }
    
    
    private func createSummnerLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(4/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        return section
    }
    
    private func createMostChampionGuideLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(4/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        return section
    }
    
    private func createMostChampionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [createHeaderLayout()]
        section.contentInsets = .init(top: 18, leading: 18, bottom: 64, trailing: 18)
        return section
    }
    
    private func createMatchLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(224))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderLayout()]
        section.contentInsets = .init(top: 18, leading: 18, bottom: 64, trailing: 18)
        return section
        
    }
    
    
    
}


extension PlayerDetailViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return playerDetailData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch playerDetailData[section] {
        case.summoner( _, _):
            return 1
        case.mostChampionGuide( _, _):
            return 1
        case.mostChampion(_ , let data):
            return data.count
        case.match(_, let data):
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch playerDetailData[indexPath.section] {
        case.summoner( _, _):
            guard let viewModel = viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SummonerCollectionViewCell", for: indexPath) as? SummonerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(viewModel.summonerViewModel)
            return cell
        case.mostChampionGuide( _, _):
            guard let viewModel = viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostChampionGuideCollectionViewCell", for: indexPath) as? MostChampionGuideCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(viewModel.mostChampionGuideViewModel)
            return cell
        case.mostChampion(_ , _):
            guard let viewModel = viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostChampionCollectionViewCell", for: indexPath) as? MostChampionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(index: indexPath, viewModel.mostChampionViewModel)
            return cell
        case.match(_, _):
            guard let viewModel = viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCollectionViewCell", for: indexPath) as? MatchCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bind(index: indexPath, viewModel.matchViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DefaultCollectionViewHeader", for: indexPath) as! DefaultCollectionViewHeader
            switch playerDetailData[indexPath.section] {
            case.summoner(let title, _):
                header.sectionNameLabel.text = title
            case.mostChampionGuide(let title, _):
                header.sectionNameLabel.text = title
            case.mostChampion(let title, _):
                header.sectionNameLabel.text = title
            case.match(let title, _):
                header.sectionNameLabel.text = title
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
}
