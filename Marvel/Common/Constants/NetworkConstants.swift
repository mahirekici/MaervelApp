

import Foundation

struct NetworkConstants {
    fileprivate static let baseUrl = "https://gateway.marvel.com/v1/public"
    static let characters = NetworkConstants.baseUrl + "/characters"
    //static let comics = NetworkConstants.baseUrl + "/characters"+"/Id"+"/comics"
    
    
    static let publicKey = "330d36db4dc523b5bb99b32206ad008e"
    static let privateKey = "d74876aed220ccb77e0dc11295606ea513f23cb7"

    static let urlNoImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Noimage.svg/739px-Noimage.svg.png"
    
    static let contentType = ["Content-Type": "application/json"]
    
    static func comics(id:String) -> String{
        return NetworkConstants.baseUrl + "/characters/" + id + "/comics"
    }
}
