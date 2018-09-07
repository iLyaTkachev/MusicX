//
//  PlaymusSearchParser.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/5/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation
import SwiftSoup

class PlaymusSearchParser: BaseMediaResponseParser {
    
    func parseMedia(type: MediaType, data: Data) -> [BaseMediaObject]? {
        guard type == .track else {
            return nil
        }
        
        var result: [BaseMediaObject]? = []
        
        if let html = String(data: data, encoding: .utf8),
            let doc = try? SwiftSoup.parse(html) {
            
            try? doc.getElementsByClass("ListTrack__item").forEach({ (link) in
                if let artistName = try? link.attr("data-artist"),
                let artistId = try? link.attr("data-id-artist"),
                    let trackName = try? link.attr("data-name"),
                    let trackId = try? link.attr("data-id"),
                    let downloadUrl = try? link.attr("data-link-mp3") {
                    let artist = Artist(name: artistName, id: artistId)
                    let track = Track(name: trackName, id: trackId, artist: artist)
                    let download = Download(track: track, downloadUrl: downloadUrl)
                    result?.append(download)
                }
            })
        }
        
        return result
    }
}
