//
//  Tag.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/29/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

struct Tag: BaseMediaObject {
    
    enum CodingKeys : String, CodingKey {
        case name
        case reach
        case taggings
    }
    
    var name, reach, taggings: String
}
