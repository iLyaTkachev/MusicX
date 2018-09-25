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
    func deleteRow(atIndex: IndexPath)
    func onError(message: String)
    func showEmptyLabel()
}

protocol DownloadsViewOutput: BaseViewOutput {
    var mediaCount: Int { get }
    var cellIdentifier: String { get }
    func getMediaObject(forIndex: Int) -> BaseMediaObject?
    func cellClicked(index: Int)
    func deleteTrack(index: IndexPath)
    func reloadData()
}

protocol DownloadsInteractorInput: BaseInteractorInput {
    func fetchDownloads()
    func deleteDownload(download: BaseMediaObject)
}

protocol DownloadsInteractorOutput: BaseInteractorOutput {
    func didDeleteWithSuccess()
    func didDeleteWithFailure(error: CustomError)
    func didFetchWithSuccess(response: [BaseMediaObject])
    func didFetchWithFailure(error: CustomError)
}

protocol DownloadsRouterInput: BaseRouterInput {
    
}
