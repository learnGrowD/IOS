import UIKit
import Alamofire
import SnapKit

class TestViewController: UIViewController {
    
    let aas : UILabel = {
        let a = UILabel()
        a.numberOfLines = 0
        return a
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let url = "https://ddragon.leagueoflegends.com/cdn/11.16.1/data/en_US/champion/Talon.json"
              AF.request(url,
                         method: .get,
                         parameters: nil,
                         encoding: URLEncoding.default,
                         headers: ["Content-Type":"application/json"])
              .responseString { [weak self] a in
                  self?.aas.text = a.value
              }
        
        
        view.addSubview(aas)
        aas.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
    }
    

}
