//
//  ResponseConverter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseMediaResponseParser {
    func parseMedia(type: MediaType, data: Data) -> [BaseMediaObject]?
}

class MediaResponseParser: BaseMediaResponseParser {
    
    func parseMedia(type: MediaType, data: Data) -> [BaseMediaObject]? {
        return parse(type: type, data: data)
    }
    
    
    private func parse(type: MediaType, data: Data) -> [BaseMediaObject]? {
        let decoder = JSONDecoder()
        guard let wrapper = try? decoder.decode(MediaWrapper.self, from: data) else {
            print("Dictionary does not contain \(type.rawValue) key\n")
            return nil
        }
        
        switch type {
        case .track:
            return wrapper.tracks?.trackList
        case .artist:
            return wrapper.artists?.artistList
        case .tag:
            return wrapper.tags?.tagList
        }
    }
}

private struct MediaWrapper: Codable {
    
    var tracks: MediaList?
    var artists: MediaList?
    var tags: MediaList?
    
    enum CodingKeys : String, CodingKey {
        case tracks
        case artists
        case tags
    }
    
    struct MediaList: Codable {
        
        var trackList: [Track]?
        var artistList: [Artist]?
        var tagList: [Tag]?
        var info: [String : String]?
        
        enum CodingKeys : String, CodingKey {
            case info = "@attr"
            case trackList = "track"
            case artistList = "artist"
            case tagList = "tag"
        }
    }
}
