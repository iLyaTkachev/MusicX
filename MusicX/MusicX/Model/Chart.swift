//
//  ChartResponse.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class Chart : BaseChart {
    
    private(set) var type: MediaType
    private(set) var items: [BaseMediaObject]?

    required init?(with dictionary: [String : Any]) {
        //print(T.type)
    }
}
