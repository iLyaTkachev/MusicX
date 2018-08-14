//
//  ChartTableViewCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/31/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell, BaseTableCell {
    static var identifier: String = "ChartTableViewCell"
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func setup<T: BaseMediaObject>(with media: T) {
        if T.type == MediaType.track, let track = media as? Track {
            trackNameLabel.text = track.name
            artistNameLabel.text = track.artist?.name
            imageURL = URL(string: track.imageUrl)
        }
    }
    
    var imageURL: URL? {
        didSet {
            artistImageView?.image = nil
            updateUI()
        }
    }
    
    private func updateUI() {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.artistImageView?.image = UIImage(data: imageData)
                        }
                        self.spinner?.stopAnimating()
                    }
                }
            }
        }
    }
    
}
