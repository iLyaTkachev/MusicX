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
        repository.getPlaylist(playlistName: "Downloads") { (playlist, error) in
            
        }
    }
    
    func deleteTrack(download: Download) {
        
    }
}
