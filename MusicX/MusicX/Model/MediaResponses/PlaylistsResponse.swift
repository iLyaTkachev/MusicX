//
//  PlaylistResponse.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/19/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class PlaylistsResponse {
    var playlists: [Playlist]
    
    init(playlists: [Playlist]) {
        self.playlists = playlists
    }
}
