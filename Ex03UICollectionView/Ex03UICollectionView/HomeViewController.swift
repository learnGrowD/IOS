import UIKit
import Then
import SnapKit


class HomeViewController: UICollectionViewController {
    var contents : [Content] = []
    var mainItem : Content.Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        
        //data 설정 및 준비
        contents = getContents()
        mainItem = contents.first?.contentItem.randomElement()
        
        
        registCollectionView()
        
        
    }
    
    func setNavigation() {
        let _ = navigationController?.then {
            $0.navigationBar.backgroundColor = .clear
            $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
            $0.navigationBar.shadowImage = UIImage()
            $0.hidesBarsOnSwipe = true
        }
        
        //navigationItem..
        let _ = navigationItem.then {
            $0.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix"), style: .plain, target: nil, action: nil)
            $0.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        }
    }
    
    //CollectionView Flow
    //data
    //collectionView setting...
    
    //Datasource, Delegate
    //cell (supplement : Header, Footer cell)
    //section
    //layout (supplement : Header, Footer layout)
    
    
    func registCollectionView() {
        collectionView.backgroundColor = .black
        
        //1. Cell 생성 -> CollectionView에 등록
        collectionView.register(ContentCollectionViewMainCell.self, forCellWithReuseIdentifier: "ContentCollectionViewMainCell")
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentCollectionViewRankCell.self, forCellWithReuseIdentifier: "ContentCollectionViewRankCell")
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
        
        //2. Datasource, Delegate 설정
        // - cell 설정 (petch)
            // - section의 개수 설정
            // - section당 보여질 cell의 개수
            // - Header, FooterView 설정(선택)
        
        //4. 이 section들을 가지고 있는 layout 주입
            // - section 생성
        collectionView.collectionViewLayout = layout()
        
    }
    
    //data 설정 및 가져오기
    func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        return list
    }
    
    //3. section 생성
       // - 만약 Header, Footer도 생성했다면 이에 걸맞는 layout도 설정을 해줘야 된다..
    
    //각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            case .large:
                return self.createLargeTypeSection()
            case .rank:
                return self.createRankTypeSection()
            case .main:
                return self.createMainTypeSection()
            }
        }
    }
    
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .fractionalHeight(0.85))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
    
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .fractionalWidth(0.85))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 20, bottom: 0, trailing: 20)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
    
    //순위 표시 sectionLayout 설정
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .fractionalWidth(0.85))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    
        
        //section..
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    
    }
    
    private func createMainTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
        
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }

}

extension HomeViewController {
    
    
    //cell 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .main :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewMainCell", for: indexPath) as? ContentCollectionViewMainCell else { return UICollectionViewCell()}
            cell.mainImg.image = mainItem?.image
            cell.descriptionLabel.text = mainItem?.description
            return cell
        case .basic, .large :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return ContentCollectionViewCell() }
            cell.img.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        case .rank :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewRankCell", for: indexPath) as? ContentCollectionViewRankCell else { return ContentCollectionViewCell() }
            cell.img.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1)
            return cell
        }
        
    }
    
    
    //section 개수
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    //section당 cell개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    
    //header, footer 설정...
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequee Header") }
            header.sectionNameLabel.text = contents[indexPath.section].sectionName
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    //cell 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("Test : \(sectionName) 섹션의 \(indexPath.row + 1)번째 콘텐츠")
    }

}
