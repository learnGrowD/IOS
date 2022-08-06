import UIKit
import Alamofire

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://ddragon.leagueoflegends.com/cdn/12.14.1/data/ko_KR/champion/Darius.json"
              AF.request(url,
                         method: .get,
                         parameters: nil,
                         encoding: URLEncoding.default,
                         headers: ["Content-Type":"application/json"])
                  .validate(statusCode: 200..<300) // 200~299 상태만 허용
                  .validate(contentType: ["application/json"]) // JSON format만 허용
                  .responseJSON { json in
                      print(json)
                  }
        
    }
    

}
