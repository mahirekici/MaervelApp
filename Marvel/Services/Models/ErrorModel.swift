

import Foundation

class ErrorModel: Error {
    
    var errorMessage: String
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
