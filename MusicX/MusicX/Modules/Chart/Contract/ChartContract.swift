//
//  ChartListContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol ChartViewInput: BaseViewInput, ActivityIndicator {
    func updateList()
    func onError(message: String)
    func setType(type: MediaType)
}

protocol ChartViewOutput: BaseViewOutput {
    var mediaCount: Int { get }
    var mediaType: MediaType { get }
    var cellIdentifier: String { get }
    func getMediaObject(forIndex: Int) -> BaseMediaObject?
    func cellClicked(index: Int)
    func loadMedia(isReloading: Bool)
    func changeType(type: MediaType)
}

protocol ChartInteractorInput: BaseInteractorInput {
    func fetch(contentType: MediaType, page: Int?)
}

protocol ChartInteractorOutput: BaseInteractorOutput {
    func didFetchWithSuccess(chart: BaseMediaResponse)
    func didFetchWithFailure(error: CustomError)
}

protocol ChartRouterInput: BaseRouterInput {
    func presentArtistDetails(artist: Artist)
    func playTrack(track: Track)
}
