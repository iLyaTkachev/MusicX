//
//  ManagedObjectParser.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/22/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ManagedObjectParser {
    
    func playlistParser(managedObject: Playlists) -> Playlist? {
        var downloads: [Download] = []
        
        if let downloadsFromCoreData = managedObject.downloads?.array as? [Downloads], !downloadsFromCoreData.isEmpty {
            
            downloadsFromCoreData.forEach({ (item) in
                if let download = downloadParser(managedObject: item) {
                    downloads.append(download)
                }
            })
        }
        
        if let name = managedObject.name {
            return Playlist(name: name, downloads: downloads)
        }
        
        return nil
    }
    
    func downloadParser(managedObject: Downloads) -> Download? {
        if let downloadUrl = managedObject.fileUrl,
            let duration = managedObject.duration,
            let bitrate = managedObject.bitrate,
            let managedTrack = managedObject.track,
            let track = trackParser(managedObject: managedTrack) {
            
            return Download(track: track, downloadUrl: downloadUrl, duration: duration, bitrate: bitrate)
        }
        
        return nil
    }
    
    func artistParser(managedObject: Artists) -> Artist? {
        if let name = managedObject.name,
            let id = managedObject.id {
            let artist = Artist(name: name, id: id)
            return artist
        }
        
        return nil
    }
    
    func trackParser(managedObject: Tracks) -> Track? {
        if let name = managedObject.name,
            let id = managedObject.id,
            let managedArtist = managedObject.artist,
            let artist = artistParser(managedObject: managedArtist) {
            
            return Track(name: name, id: id, artist: artist)
        }
        
        return nil
    }
    
    
}
