import UIKit

final class MusicRepository: MusicDataSource {

    static let shared = MusicRepository()
    
    private let remoteDataSource: MusicDataSource
    private let localDataSource: MusicDataSource
    private let imageService: BaseImageService
    
    private init() {
        remoteDataSource = MusicRemoteDataSource(queryService: QueryService())
        localDataSource = MusicLocalDataSource()
        imageService = ImageService(memoryCapacity: Constants.memoryCapacityForImageCache, diskCapacity: Constants.diskCapacityForImageCache, percentOfClearing: Constants.percentOfImageCacheClearing)
    }
    
    func getChart(type: MediaType, page: Int, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        return remoteDataSource.getChart(type: type, page: page, completionHandler: completionHandler)
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        imageService.getImage(withUrl: withUrl, completionHandler: completionHandler)
    }
    
    func getImageDirectorySize() -> Int {
        return imageService.getImageDirectorySize()
    }
    
    func clearImageDirectory() {
        imageService.clearImageCache()
    }
}
