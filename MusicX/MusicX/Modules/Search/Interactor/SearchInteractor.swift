//
//  SearchInteractor.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class SearchInteractor: SearchInteractorInput {

    weak var output: SearchInteractorOutput!
    var repository: MusicDataSource!

    func searchMedia(type: MediaType, name: String) {
        repository.searchMedia(type: type, name: name) { (mediaArray, error) in
            
        }
    }
}
