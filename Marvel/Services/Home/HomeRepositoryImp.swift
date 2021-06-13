

import Foundation
import CryptoSwift


class HomeRepositoryImp: BaseRepository,HomeRepository {
    
    func fetchData(limit: Int, offset: Int, completion: @escaping(Result<[Character], ErrorModel>) -> Void) {
        
        let params = getParams(limit: limit, offset: offset)
        networkService.request(NetworkConstants.characters, method: .get, parameters: params) { (json) in
            let characters = json.arrayValue.compactMap { Character(json: $0) }
            completion(.success(characters))
        } failure: { (errorMessage, _) in
            completion(.failure(ErrorModel(errorMessage: errorMessage)))
        }
    }
    
    private func getParams(limit: Int, offset: Int) -> [String: Any] {
        
        var params = [String: Any]()
        
        let timeStamp = Int(Date().timeIntervalSince1970)
        params["ts"] = timeStamp
        params["apikey"] = NetworkConstants.publicKey
        params["hash"] = "\(timeStamp)\(NetworkConstants.privateKey)\(NetworkConstants.publicKey)".md5()
        params["limit"] = limit
        params["offset"] = offset
        
        return params
    }
}
