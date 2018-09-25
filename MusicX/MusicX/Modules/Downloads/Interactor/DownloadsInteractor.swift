//
//  DownloadsInteractor.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class DownloadsInteractor: DownloadsInteractorInput {

    weak var output: DownloadsInteractorOutput!
    var repository: MusicDataSource!
    
    func fetchDownloads() {
        repository.getPlaylist(playlistName: "Downloads") { [weak self] (response, error) in
            if error != nil {
                self?.output.didFetchWithFailure(error: error!)
            } else if response != nil{
                self?.output.didFetchWithSuccess(response: response!.downloads!)
            }
        }
    }
    
    func deleteDownload(download: BaseMediaObject) {
        guard let download = download as? Download else {
            return
        }
        
        repository.deleteTrack(download: download) { [weak self] (error) in
            guard let errorToShow = error else {
                self?.output.didDeleteWithSuccess()
                return
            }
            
            self?.output.didDeleteWithFailure(error: errorToShow)
        }
    }
}
