//
//  Playlist.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/19/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

struct Playlist: BaseMediaObject {
    var name: String
    var tracks: [Track]
    
    init(name: String, tracks: [Track]) {
        self.name = name
        self.tracks = tracks
    }
}
