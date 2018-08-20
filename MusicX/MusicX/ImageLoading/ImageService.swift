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
    
    init(memoryCapacity: Int, diskCapacity: Int){
        self.session = URLSession(configuration: .default)
        self.imageCache = NSCache()
        self.imageCache.totalCostLimit = memoryCapacity
        self.fileManager = FileManager.default
        self.cacheFolderPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] + "/imagesCache/"
        try? fileManager.createDirectory(atPath: cacheFolderPath, withIntermediateDirectories: true, attributes: nil)
        guard (try? fileManager.contentsOfDirectory(atPath: cacheFolderPath)) != nil else {
            print("Problems with creating cache directory")
            return
        }
        
        //print("\(try! fileManager.contentsOfDirectory(atPath: cacheFolderPath))")
        
        var size = 0
        
        let files = try! fileManager.contentsOfDirectory(at: URL(string: cacheFolderPath)!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        print("files: \(files)")
        
        try! files.lazy.forEach { (url) in
            let attr = try fileManager.attributesOfItem(atPath: url.path)
            let fileSize = attr[FileAttributeKey.size] as! Int
            size += fileSize
        }
        print("size: \(size/1024)")
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
}
