//
//  MediaBuilder.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/27/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseMediaBuilder {
    func build(type: MediaType, from dictionary: [String : Any]) -> BaseMediaObject?
}

class MediaBuilder: BaseMediaBuilder {
    
    private let trackBuilder: BaseMediaBuilder
    private let artistBuilder: BaseMediaBuilder
    
    init() {
        self.artistBuilder = ArtistBuilder()
        self.trackBuilder = TrackBuilder(artistBuilder: artistBuilder)
    }
    
    func build(type: MediaType, from dictionary: [String : Any]) -> BaseMediaObject? {
        switch type {
        case .track:
            return trackBuilder.build(type: type, from: dictionary)
        case .artist:
            return artistBuilder.build(type: type, from: dictionary)
        case .tag:
            return nil
        }
    }
}

private class TrackBuilder: BaseMediaBuilder {
    
    private enum Keys: String {
        case name, playcount, listeners, artist, image
        case imageUrl = "#text"
    }
    
    let artistBuilder: BaseMediaBuilder
    
    init(artistBuilder: BaseMediaBuilder) {
        self.artistBuilder = artistBuilder
    }
    
    func build(type: MediaType, from dictionary: [String : Any]) -> BaseMediaObject? {
        
        guard let name = dictionary[Keys.name.rawValue] as? String,
            let playcount = dictionary[Keys.playcount.rawValue] as? String,
            let listeners = dictionary[Keys.listeners.rawValue] as? String,
            let imagesArray = dictionary[Keys.image.rawValue] as? [Any],
            let imageDictionary = imagesArray[2] as? [String : Any],
            let imageUrl = imageDictionary[Keys.imageUrl.rawValue] as? String,
            let artistDictionary = dictionary[Keys.artist.rawValue] as? [String : Any],
            let artist = artistBuilder.build(type: .artist, from: artistDictionary) as? Artist else {
                print("Problem with parsing of track\n")
                return nil
        }
        
        return Track(name: name, playcount: playcount, listeners: listeners, imageUrl: imageUrl, artist: artist)
    }
}

private class ArtistBuilder: BaseMediaBuilder {
    
    private enum Keys: String {
        case name, mbid, playcount, listeners, image
        case imageUrl = "#text"
    }
    
    func build(type: MediaType, from dictionary: [String : Any]) -> BaseMediaObject? {
        
        guard let name = dictionary[Keys.name.rawValue] as? String,
            let mbid = dictionary[Keys.mbid.rawValue] as? String else {
                print("Problem with parsing of artist\n")
                return nil
        }
        
        guard let playcount = dictionary[Keys.playcount.rawValue] as? String,
        let listeners = dictionary[Keys.listeners.rawValue] as? String,
        let imagesArray = dictionary[Keys.image.rawValue] as? [Any],
        let imageDictionary = imagesArray[2] as? [String : Any],
        let imageUrl = imageDictionary[Keys.imageUrl.rawValue] as? String else {
            return Artist(name: name, mbid: mbid)
        }
        
        return Artist(name: name, mbid: mbid, playcount: playcount, listeners: listeners, imageUrl: imageUrl)
    }
}
