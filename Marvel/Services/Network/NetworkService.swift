

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher

class NetworkService {
    
    static let sharedInstance = NetworkService()
    
    var imageDownloader: ImageDownloader = {
       var imageDownloader = ImageDownloader.default
        imageDownloader.trustedHosts = Set(["i.annihil.us"])
        
        return imageDownloader
    }()
    
    private init() {
        KingfisherManager.shared.downloader = imageDownloader
    }
    
    var manager: SessionManager!
    
    func request(_ url: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding(destination: .queryString), headers: HTTPHeaders = NetworkConstants.contentType, completion: @escaping (_ response: JSON) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        manager = Alamofire.SessionManager(configuration: configuration)
        
        
        DispatchQueue.global().async {
            self.manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseString(queue: DispatchQueue.main, encoding: String.Encoding.utf8) { response in
                        
                print("\n\n-- RESPONSE: \(response)")
                
                if response.response?.statusCode == 200 {
                    guard let callback = response.data else {
                        failure(self.generateErrorMessage(), 0)
                        return
                    }
                    let json = JSON(callback)
                    if json["code"].intValue == 200 {
                        completion(json["data"]["results"])
                    } else {
                        failure(self.generateErrorMessage(), 0)
                    }
                    
                } else {
                    failure(self.generateErrorMessage(), 0)
                }
            }
        }
    }
        
    func generateErrorMessage() -> String {
        return "error_message.somethings_wrong".localized
    }

}
