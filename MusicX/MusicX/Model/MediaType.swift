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
            return Constants.ApiComponents.Chart.getTopTracks
        case .artist:
            return Constants.ApiComponents.Chart.getTopArtists
        case .tag:
            return Constants.ApiComponents.Chart.getTopTags
        }
    }
    
    func chartArray() -> String {
        return rawValue + "s"
    }
}
