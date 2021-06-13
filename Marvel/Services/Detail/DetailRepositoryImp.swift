

import Foundation
import Foundation
import CryptoSwift

//https://gateway.marvel.com:443/v1/public/characters/1011334/comics?startYear=2005&orderBy=focDate&apikey=cc4314a9ebfe274451199b69d71a1a95
class DetailRepositoryImp: BaseRepository,DetailRepository {
    
    func fetchData(id: Int, completion: @escaping(Result<[Comics], ErrorModel>) -> Void) {
        
        let params = getParams()        
        
        networkService.request(NetworkConstants.comics(id: String(id)), method: .get, parameters: params) { (json) in
            
            let characters = json.arrayValue.compactMap { Comics(json: $0) }
            completion(.success(characters))
        } failure: { (errorMessage, _) in
            completion(.failure(ErrorModel(errorMessage: errorMessage)))
        }
    }
    
    private func getParams() -> [String: Any] {
        
        var params = [String: Any]()
        
        let timeStamp = Int(Date().timeIntervalSince1970)
        params["startYear"] = "2005" // 2005 yıloından sonraki
        params["apikey"] = NetworkConstants.publicKey
        params["hash"] = "\(timeStamp)\(NetworkConstants.privateKey)\(NetworkConstants.publicKey)".md5()
        params["orderBy"] = "focDate" // yeniden eskiye göre sırala
        params["ts"] = timeStamp
        params["limit"] = 10 // limit 10 roman
        return params
    }
}
