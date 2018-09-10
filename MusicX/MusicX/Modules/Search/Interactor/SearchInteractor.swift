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

    func searchMedia(type: MediaType, name: String, page: Int) {
        repository.searchMedia(type: type, name: name, page: page) { [weak self] (response, error) in
            if error != nil {
                self?.output.didFetchWithFailure(error: error!)
            } else if response != nil{
                self?.output.didFetchWithSuccess(response: response!)
            }
        }
    }
}
