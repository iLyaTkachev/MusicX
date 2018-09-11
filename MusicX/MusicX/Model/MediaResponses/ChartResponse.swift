//
//  ChartResponse.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ChartResponse: BaseMediaResponse {
    let type: MediaType
    let page: Int
    let items: [BaseMediaObject]
    
    init(type: MediaType, page: Int, items: [BaseMediaObject]) {
        self.type = type
        self.page = page
        self.items = items
    }
}
