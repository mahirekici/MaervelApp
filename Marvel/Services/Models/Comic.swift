

import Foundation
import SwiftyJSON

class Comics: BaseModel {
    
    var id: Int!
    var title: String!
    var description: String!
    var thumbnail: String!
    
    var dates : [Dates]!
    
    required init(json: JSON) {
        super.init(json: json)
        
        id = json["id"].intValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        
        let thumbJSON = json["thumbnail"]
        thumbnail = thumbJSON["path"].stringValue + "." + thumbJSON["extension"].stringValue
      

        
        let list: Array<JSON> = json["dates"].arrayValue // If not an Array or nil, return []

        dates = list.compactMap { (j) -> Dates in
           return Dates.init(json: j)
        }
        
    
        
    }
}


class Dates: BaseModel {
    
    var date : String!
    var type : String!
    
    required init(json: JSON) {
        super.init(json: json)
        
        date = json["date"].stringValue
        type = json["type"].stringValue
    }
}
