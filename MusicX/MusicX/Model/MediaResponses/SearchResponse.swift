//
//  SearchResponse.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/10/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class SearchResponse: ChartResponse {
    let searchName: String
    
    init(type: MediaType, searchName: String, page: Int, items: [BaseMediaObject]) {
        self.searchName = searchName
        super.init(type: type, page: page, items: items)
    }
}
