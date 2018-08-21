//
//  ChartCellBuilder.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/21/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartCellBuilder {
    func build(table: UITableView, indexPath: IndexPath, media: BaseMediaObject, type: MediaType) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch type {
        case .track:
            cell = table.dequeueReusableCell(withIdentifier: ChartTrackCell.identifier, for: indexPath)
            TrackCellBuilder.setup(cell: cell as! ChartTrackCell, track: media as! Track)
        case .artist:  //TODO: change
            break
        case .tag:
            break
        }
        
        return cell
    }
}

private class TrackCellBuilder {
    static func setup(cell: ChartTrackCell, track: Track) {
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
