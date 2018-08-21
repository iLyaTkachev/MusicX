//
//  ImageCache.swift
//  MusicX
//
//  Created by Ilya Tkachev on 8/19/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol BaseImageService {
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?)->Void)
}

class ImageService: BaseImageService {
    
    private let session: URLSession
    
    private let fileManager: FileManager
    private let cacheFolderPath: String
    
    let imageCache: NSCache<NSString, UIImage>
    
    init(memoryCapacity: Int, diskCapacity: Int, percentOfClearing: Int = 50){
        self.session = URLSession(configuration: .default)
        self.imageCache = NSCache()
        self.imageCache.totalCostLimit = memoryCapacity
        self.fileManager = FileManager.default
        self.cacheFolderPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] + "/imagesCache/"
        
        clearDiskCacheIfNeeded(fileManager: fileManager, directoryPath: URL(string: cacheFolderPath)!, maxSize: diskCapacity, percent: percentOfClearing)
        
        try? fileManager.createDirectory(atPath: cacheFolderPath, withIntermediateDirectories: true, attributes: nil)
        guard (try? fileManager.contentsOfDirectory(atPath: cacheFolderPath)) != nil else {
            print("Problems with creating cache directory")
            return
        }
        
        //print("\(try! fileManager.contentsOfDirectory(atPath: cacheFolderPath).count)")
        //print("\(countDirectorySize(fileManager: fileManager, path: URL(string: cacheFolderPath)!))")
        
        print("\(getDeviceFreeSpace()!/1024/1024)")
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?)->Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let nsUrlForCache = withUrl as NSString
            
            if let cachedVersion = self.imageCache.object(forKey: nsUrlForCache) {
                completionHandler(cachedVersion, nil)
            } else if let cachedVersion = try? Data(contentsOf: URL(fileURLWithPath: self.cacheFolderPath.appending(Utils.getFileNameFromImageUrl(url: withUrl)))) {
                completionHandler(UIImage(data: cachedVersion), nil)
            } else {
                let url = URL(string: withUrl)!
                let webRequest = URLRequest(url: url)
                
                self.session.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
                    
                    guard let data = webData else {
                        completionHandler(nil, apiError)
                        print(apiError!)
                        return
                    }
                    
                    let image = UIImage(data: data)
                    self.imageCache.setObject(image!, forKey: nsUrlForCache, cost: data.count)
                    completionHandler(image, nil)
                    let fileUrl = self.cacheFolderPath.appending(Utils.getFileNameFromImageUrl(url: withUrl))
                    self.fileManager.createFile(atPath: fileUrl, contents: data, attributes: nil)
                    }.resume()
            }
        }
    }
    
    private func countDirectorySize(fileManager: FileManager, path: URL) -> Int {
        var folderSize = 0
        (try? fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: nil))?.lazy.forEach {
            folderSize += (try? $0.resourceValues(forKeys: [.totalFileAllocatedSizeKey]))?.totalFileAllocatedSize ?? 0
        }
        
        return folderSize
    }
    
    private func getDeviceFreeSpace() -> Int? {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        guard
            let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
            let freeSize = systemAttributes[.systemFreeSize] as? Int
            else {
                return nil
        }
        return freeSize
    }
    
    private func clearDiskCacheIfNeeded(fileManager: FileManager, directoryPath: URL, maxSize: Int, percent: Int) {
        let currentSize = countDirectorySize(fileManager: fileManager, path: directoryPath)
        
        if currentSize > maxSize {
            do {
                
                if let imageUrls = try? fileManager.contentsOfDirectory(at: directoryPath, includingPropertiesForKeys: nil) {
                    
                    let sortedImageUrls = try imageUrls.sorted(by: { (try $0.resourceValues(forKeys: [.contentAccessDateKey])).contentAccessDate! > (try $1.resourceValues(forKeys: [.contentAccessDateKey])).contentAccessDate! })
                    
                    let startIndex: Int = sortedImageUrls.count * percent / 100
                    let oldImageUrls = sortedImageUrls[startIndex..<sortedImageUrls.count]
                    
                    try oldImageUrls.forEach{ try fileManager.removeItem(at: $0) }
                }
            }
            catch let error as NSError {
                print("Problems with clearing of image cache directory : \(error)")
            }
        }
    }
}
