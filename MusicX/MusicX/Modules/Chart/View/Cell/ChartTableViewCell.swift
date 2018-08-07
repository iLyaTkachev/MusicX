//
//  ChartTableViewCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/31/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    func setup(with track: Track) {
        trackNameLabel.text = track.name
        artistNameLabel.text = track.artist?.name
    }
    
}
