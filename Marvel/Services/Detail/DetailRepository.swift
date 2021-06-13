

import Foundation

protocol DetailRepository {
    func fetchData(id: Int, completion: @escaping(Result<[Comics], ErrorModel>) -> Void)
}
