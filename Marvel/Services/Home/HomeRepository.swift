
import Foundation

protocol HomeRepository {
    func fetchData(limit: Int, offset: Int, completion: @escaping(Result<[Character], ErrorModel>) -> Void)
}
