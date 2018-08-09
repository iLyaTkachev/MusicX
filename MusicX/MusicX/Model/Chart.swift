//
//  ChartResponse.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class Chart<Item: BaseMediaObject>: BaseChart {
    
    private(set) var mediaArray: [Item]
    
    required init?(with dictionary: [String : Any]) {
        return nil
    }
    
    
}
