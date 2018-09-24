//
//  DownloadsContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol DownloadsViewInput: BaseViewInput, ActivityIndicator {
    func updateList()
    func onError(message: String)
}

protocol DownloadsViewOutput: BaseViewOutput {
    var mediaCount: Int { get }
    var cellIdentifier: String { get }
    func getMediaObject(forIndex: Int) -> BaseMediaObject?
    func cellClicked(index: Int)
    func deleteTrack(index: Int)
    func reloadData()
}

protocol DownloadsInteractorInput: BaseInteractorInput {
    func fetchTracks()
    func deleteTrack(download: Download)
}

protocol DownloadsInteractorOutput: BaseInteractorOutput {
    func didFetchWithSuccess(response: [BaseMediaObject])
    func didFetchWithFailure(error: CustomError)
}

protocol DownloadsRouterInput: BaseRouterInput {
    
}
