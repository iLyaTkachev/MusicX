//
//  ChartCellBuilder.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/21/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartCellBuilder: BaseCellBuilder {
    
    class ChartCellData {
        let table: UITableView
        let indexPath: IndexPath
        let media: BaseMediaObject
        let type: MediaType
        
        init(table: UITableView, indexPath: IndexPath, media: BaseMediaObject, type: MediaType) {
            self.table = table
            self.indexPath = indexPath
            self.media = media
            self.type = type
        }
    }
    
    func build<T>(withData: T) -> UITableViewCell? {
        var cell: UITableViewCell?
        
        if let data = withData as? ChartCellData {
            
            switch data.type {
            case .track:
                cell = data.table.dequeueReusableCell(withIdentifier: ChartTrackCell.identifier, for: data.indexPath)
                setupTrackCell(cell: cell as! ChartTrackCell, track: data.media as! Track)
            case .artist:  //TODO: change
                break
            case .tag:
                break
            }
        }
        return cell
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

