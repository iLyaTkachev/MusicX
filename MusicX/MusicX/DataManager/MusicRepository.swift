import UIKit

final class MusicRepository: MusicDataSource {
    
    private let remoteDataSource: MusicDataSource
    private let localDataSource: MusicDataSource
    private let imageService: BaseImageService
    
    init(coreDataManager: BaseCoreDataManager) {
        remoteDataSource = MusicRemoteDataSource(queryService: QueryService())
        localDataSource = MusicLocalDataSource(coreDataManager: coreDataManager)
        imageService = ImageService(memoryCapacity: Constants.memoryCapacityForImageCache, diskCapacity: Constants.diskCapacityForImageCache, percentOfClearing: Constants.percentOfImageCacheClearing)
    }
    
    func getChart(type: MediaType, page: Int, completionHandler: @escaping (ChartResponse?, CustomError?)->Void) {
        return remoteDataSource.getChart(type: type, page: page, completionHandler: completionHandler)
    }
    
    func searchMedia(type: MediaType, name: String, page: Int, completionHandler: @escaping (SearchResponse?, CustomError?) -> Void) {
        remoteDataSource.searchMedia(type: type, name: name, page: page, completionHandler: completionHandler)
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
