
import Foundation
import SwiftyJSON

class Character: BaseModel {
    
    var id: Int!
    var name: String!
    var description: String!
    var thumbnail: String!
    var comics: [String]?
    
    required init(json: JSON) {
        super.init(json: json)
        
        id = json["id"].intValue
        name = json["name"].stringValue
        description = json["description"].stringValue
        
        let thumbJSON = json["thumbnail"]
        thumbnail = thumbJSON["path"].stringValue + "." + thumbJSON["extension"].stringValue
        
        let comicsJSON = json["comics"]["items"].arrayValue
        comics = comicsJSON.compactMap { $0["name"].stringValue }
    }
}
