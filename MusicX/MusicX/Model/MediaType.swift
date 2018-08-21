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
            return ApiConstants.ApiComponents.Chart.getTopTracks
        case .artist:
            return ApiConstants.ApiComponents.Chart.getTopArtists
        case .tag:
            return ApiConstants.ApiComponents.Chart.getTopTags
        }
    }
    
    func chartArray() -> String {
        return rawValue + "s"
    }
}
