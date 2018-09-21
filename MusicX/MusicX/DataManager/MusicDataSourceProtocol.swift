//
//  MusicDataSource.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol MusicDataSource {
    func getChart(type: MediaType, page: Int, completionHandler: @escaping (ChartResponse?, CustomError?)->Void)
    func searchMedia(type: MediaType, name: String, page: Int, completionHandler: @escaping (SearchResponse?, CustomError?)->Void)
    func getPlaylist(playlistName: String, completionHandler: @escaping (Playlist?, CustomError?)->Void)
    func deleteTrack(download: Download, completionHandler: @escaping (CustomError?)->Void)
    func downloadTrack(download: Download, completionHandler: @escaping (CustomError?)->Void)
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?)->Void)
    func getImageDirectorySize() -> Int
    func clearImageDirectory()
}
