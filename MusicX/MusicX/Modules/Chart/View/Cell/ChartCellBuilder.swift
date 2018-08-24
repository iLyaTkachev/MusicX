//
//  ChartCellBuilder.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/21/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartCellBuilder : BaseCellBuilder {
    
    func build<T>(cell: UITableViewCell, data: T) {
        guard let cellData = data as? ChartCellData else {
            return
        }
        
        switch cellData.type {
        case .track:
            guard let trackCell = cell as? ChartTrackCell, let trackData = cellData.media as? Track else {
                return
            }
            setupTrackCell(cell: trackCell , track: trackData)
        case .artist:  //TODO: change
            break
        case .tag:
            break
        }
    }
    
    class ChartCellData {
        let type: MediaType
        let media: BaseMediaObject
        
        init(type: MediaType, media: BaseMediaObject) {
            self.type = type
            self.media = media
        }
    }

    
    private func setupTrackCell(cell: ChartTrackCell, track: Track) {
        cell.trackNameLabel.text = track.name
        cell.artistNameLabel.text = track.artist?.name
        cell.imageURL =  track.imageUrl
        cell.artistImageView.image = nil
        cell.spinner.startAnimating()
        
        CoreX.shared.repository.getImage(withUrl: track.imageUrl) { (image, error) in
            DispatchQueue.main.async {
                if image != nil && cell.imageURL == track.imageUrl {
                    cell.artistImageView.image = image
                }
                
                cell.spinner.stopAnimating()
            }
        }
    }
}

