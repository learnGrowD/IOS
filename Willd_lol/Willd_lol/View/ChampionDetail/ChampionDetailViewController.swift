//
//  ChampionDetailViewController.swift
//  willd_lol
//
//  Created by 도학태 on 2022/08/11.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import SwiftUI


class ChampionDetailViewController : UIViewController {
    let disposeBag = DisposeBag()
    var viewModel : ChampionDetailViewModel?
    var detailPageData : [ChampionDetailPageDataModel] = []
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .willdBlack
        $0.register(SkinsCollectionViewCell.self, forCellWithReuseIdentifier: "SkinsCollectionViewCell")
        $0.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: "TagsCollectionViewCell")
        $0.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "SkillsCollectionViewCell")
        $0.register(LoreCollectionViewCell.self, forCellWithReuseIdentifier: "LoreCollectionViewCell")
        $0.register(LankCollectionViewCell.self, forCellWithReuseIdentifier: "LankCollectionViewCell")
        $0.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: "CommentCollectionViewCell")
        $0.register(ChampionDetailCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ChampionDetailCollectionHeader")
    }
    
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel : ChampionDetailViewModel) {
        self.viewModel = viewModel
        
        collectionView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)
        
        viewModel.detailPageData
            .drive(onNext : { [weak self] data in
                self?.detailPageData = data
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(onNext : { [weak self] in
                switch self?.detailPageData[$0.section] {
                case.skins(let title, _):
                    print(title)
                default:
                    print("Hello")
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    
    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.detailPageData[sectionNumber] {
            case .skins( _,  _):
                return self.createSkinsLayout()
            case.tags( _,  let data):
                return self.createTagsLayout(count: data.count)
            case.skills( _, _):
                return self.createSkillsLayout()
            case.playerLank( _,  _):
                return self.createLanksLayout()
            case.championComment( _, _):
                return self.createCommentsLayout()
            case .lore(_, _):
                return self.createLoreLayout()
            }
        }
    }
    
    private func createHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(24))
        let section = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return section
    }
    
    private func createSkinsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(3/4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        return section
    }
    
    private func createTagsLayout(count : Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(24))
        
        var group : NSCollectionLayoutGroup
        if count == 2 {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: count + 3)
        } else if count == 3 {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: count + 2)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: count)
        }
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
        
    }
    
    
    private func createSkillsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [self.createHeaderLayout()]
        return section
    }
    
    private func createLanksLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [self.createHeaderLayout()]
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
    private func createLoreLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [self.createHeaderLayout()]
        return section
        
    }
    
    private func createCommentsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [self.createHeaderLayout()]
        return section
        
    }
    
    func attribute() {
        collectionView.collectionViewLayout = generateLayout()
    }
    
    func layout() {
        [collectionView].forEach {
            view.addSubview($0)
        }
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        

    }
}

extension ChampionDetailViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return detailPageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch detailPageData[section] {
        case .skins( _, let data):
            return data.count
        case .tags( _, let data):
            return data.count
        case .skills( _, let data):
            return data.count
        case .lore( _, _):
            return 1
        case .playerLank( _, let data):
            return data.count
        case .championComment( _, let data):
            return data.comment.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch detailPageData[indexPath.section] {
        case .skins( _, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinsCollectionViewCell", for: indexPath) as? SkinsCollectionViewCell,
                  let viewModel = self.viewModel else {
                return UICollectionViewCell()
            }
            cell.bind(index : indexPath, viewModel.skinViewModel)
            cell.contentView.backgroundColor = .willdBlack
            return cell
        case .tags( _, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionViewCell", for: indexPath) as? TagsCollectionViewCell,
                  let viewModel = self.viewModel else {
                return UICollectionViewCell()
            }
            cell.bind(index : indexPath, viewModel.tagsViewModel)
            cell.contentView.backgroundColor = .willdBlack
            return cell
        case .skills( _, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillsCollectionViewCell", for: indexPath) as? SkillsCollectionViewCell,
                  let viewModel = self.viewModel else {
                return UICollectionViewCell()
            }
            cell.bind(index : indexPath, viewModel.skillsViewModel)
            cell.contentView.backgroundColor = .willdBlack
            return cell
        case .lore( _, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoreCollectionViewCell", for: indexPath) as? LoreCollectionViewCell,
                  let viewModel = self.viewModel else {
                return UICollectionViewCell()
            }
            cell.bind(viewModel.loreViewModel)
            cell.contentView.backgroundColor = .willdBlack
            return cell
        case .playerLank( _, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LankCollectionViewCell", for: indexPath) as? LankCollectionViewCell,
                  let viewModel = self.viewModel else {
                return UICollectionViewCell()
            }
            cell.bind(index : indexPath, viewModel.lankViewModel)
            cell.contentView.backgroundColor = .willdBlack
            return cell
        case .championComment( _, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell", for: indexPath) as? CommentCollectionViewCell,
                  let viewModel = self.viewModel else {
                return UICollectionViewCell()
            }
            cell.bind(index: indexPath, viewModel.commentViewModel)
            cell.contentView.backgroundColor = .willdBlack
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind  == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ChampionDetailCollectionHeader", for: indexPath) as! ChampionDetailCollectionHeader
                    switch detailPageData[indexPath.section] {
                    case.skins(let title, _):
                        header.configure(title: title)
                    case.tags(let title, _):
                        header.configure(title: title)
                    case.skills(let title, _):
                        header.configure(title: title)
                    case.lore(let title, _):
                        header.configure(title: title)
                    case.playerLank(let title, _):
                        header.configure(title: title)
                    case.championComment(let title, _):
                        header.configure(title: title)
                    }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    
}
