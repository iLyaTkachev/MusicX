//
//  SearchContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol SearchViewInput : BaseViewInput, ActivityIndicator {
    func updateList()
    func onError(message: String)
}

protocol SearchViewOutput : BaseViewOutput {
    func search(with name: String)
}

protocol SearchInteractorInput : BaseInteractorInput {
    func searchMedia(type: MediaType, name: String, page: Int)
}

protocol SearchInteractorOutput : BaseInteractorOutput {
    func didFetchWithSuccess(media: [BaseMediaObject])
    func didFetchWithFailure(error: CustomError)
}

protocol SearchRouterInput : BaseRouterInput {
    
}
