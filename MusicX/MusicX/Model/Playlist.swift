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
    var downloads: [Download]?
    
    init(name: String, downloads: [Download]?) {
        self.name = name
        self.downloads = downloads
    }
}
