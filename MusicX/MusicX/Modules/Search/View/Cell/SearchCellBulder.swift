//
//  SearchCellBulder.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class SearchCellBuilder : BaseCellBuilder {
    func build<T>(cell: UITableViewCell, data: T) {
        guard let cellData = data as? SearchCellData else {
            return
        }
        
        switch cellData.type {
        case .track:
            guard let trackCell = cell as? SearchTrackCell, let trackData = cellData.media as? Download else {
                return
            }
            setupDownloadCell(cell: trackCell , track: trackData)
        case .artist:
            return
        case .tag:
            return
        }
    }
    
    class SearchCellData {
        let type: MediaType
        let media: BaseMediaObject
        
        init(type: MediaType, media: BaseMediaObject) {
            self.type = type
            self.media = media
        }
    }
    
    private func setupDownloadCell(cell: SearchTrackCell, download: Download) {
        
    }
}
