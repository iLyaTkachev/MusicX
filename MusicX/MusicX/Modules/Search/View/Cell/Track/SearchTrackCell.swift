//
//  SearchTrackCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol SearchTrackCellDelegate : class{
    func pauseTapped(_ cell: SearchTrackCell)
    func resumeTapped(_ cell: SearchTrackCell)
    func cancelTapped(_ cell: SearchTrackCell)
    func downloadTapped(_ cell: SearchTrackCell)
}

class SearchTrackCell: UITableViewCell, BaseTableCell {
    static var identifier = "SearchTrackCell"
    
    weak var delegate: SearchTrackCellDelegate?
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var bitrate: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func pauseOrResumeTapped(_ sender: AnyObject) {
        if(pauseButton.titleLabel!.text == "Pause") {
            delegate?.pauseTapped(self)
        } else {
            delegate?.resumeTapped(self)
        }
    }
    
    @IBAction func cancelTapped(_ sender: AnyObject) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
}
