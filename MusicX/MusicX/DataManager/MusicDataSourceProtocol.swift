//
//  MusicDataSource.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol MusicDataSource {
    func getChart(type: MediaType, page: Int, completionHandler: @escaping (Chart?, CustomError?)->Void)
    func searchMedia(type: MediaType, name: String, completionHandler: @escaping ([BaseMediaObject]?, CustomError?)->Void)
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?)->Void)
    func getImageDirectorySize() -> Int
    func clearImageDirectory()
}
