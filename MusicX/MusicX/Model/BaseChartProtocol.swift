//
//  BaseChartProtocol.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseChart {
    var type: MediaType { get }
    var items: [BaseMediaObject]? { get }
    init?(type: MediaType, items: [BaseMediaObject])
}
