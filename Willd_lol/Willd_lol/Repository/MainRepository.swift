
import Foundation
import RxSwift

class MainRepository : MainRepositoryProtocal {
    static let instance = MainRepository()
    private let apiService : ApiService
    private init() {
        apiService = ApiService.instance
    }
    
}
