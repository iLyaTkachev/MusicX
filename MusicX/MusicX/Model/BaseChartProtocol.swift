//
//  BaseChartProtocol.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseMediaResponse {
    var type: MediaType { get }
    var page: Int { get }
    var items: [BaseMediaObject] { get }
}
