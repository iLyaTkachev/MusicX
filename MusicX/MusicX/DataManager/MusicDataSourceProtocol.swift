//
//  MusicDataSource.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol MusicDataSource {
    func getChart(type: MediaType, page: Int?) -> Chart?
}
