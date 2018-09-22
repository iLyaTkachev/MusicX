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
    
    func fetchTracks() {
        repository.getPlaylist(playlistName: "Downloads") { [weak self] (response, error) in
            if error != nil {
                self?.output.didFetchWithFailure(error: error!)
            } else if response != nil{
                self?.output.didFetchWithSuccess(response: response!.downloads!)
            }
        }
    }
    
    func deleteTrack(download: Download) {
        
    }
}
