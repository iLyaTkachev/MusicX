//
//  MediaType.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/8/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

enum MediaType: String {
    case track
    case artist
    case tag
    
    func chartMethod() -> String {
        switch self {
        case .track:
            return ApiConstants.LastFmApi.Chart.getTopTracks
        case .artist:
            return ApiConstants.LastFmApi.Chart.getTopArtists
        case .tag:
            return ApiConstants.LastFmApi.Chart.getTopTags
        }
    }
    
    func chartArray() -> String {
        return rawValue + "s"
    }
}
