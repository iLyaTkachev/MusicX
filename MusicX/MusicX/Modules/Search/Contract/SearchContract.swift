//
//  SearchContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol SearchViewInput: BaseViewInput, ActivityIndicator {
    func updateList()
    func onError(message: String)
}

protocol SearchViewOutput : BaseViewOutput {
    func search(with name: String)
    var mediaCount: Int { get }
    var mediaType: MediaType { get }
    var cellIdentifier: String { get }
    func getMediaObject(forIndex: Int) -> BaseMediaObject?
    func cellClicked(index: Int)
}

protocol SearchInteractorInput: BaseInteractorInput {
    func searchMedia(type: MediaType, name: String, page: Int)
}

protocol SearchInteractorOutput: BaseInteractorOutput {
    func didFetchWithSuccess(response: SearchResponse)
    func didFetchWithFailure(error: CustomError)
}

protocol SearchRouterInput: BaseRouterInput {
    
}
