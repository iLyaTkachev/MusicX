//
//  ImageCache.swift
//  MusicX
//
//  Created by Ilya Tkachev on 8/19/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseImageService {
    func getImage(withUrl: URL)
}

class ImageService: BaseImageService {
    
    private let memoryCapacity: Int
    private let diskCapacity: Int
    private let urlCache: URLCache
    private let session: URLSession

    init(memoryCapacity: Int, diskCapacity: Int){
        self.memoryCapacity = memoryCapacity
        self.diskCapacity = diskCapacity
        self.session = URLSession(configuration: .default)
        self.urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "MyDiskPath")
        //URLCache.setSharedURLCache(urlCache)
    }
    
    func getImage(withUrl: URL) {
        //let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "MyDiskPath")
        
    }
}
