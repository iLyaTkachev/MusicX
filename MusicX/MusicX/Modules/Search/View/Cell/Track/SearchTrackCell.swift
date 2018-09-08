//
//  SearchTrackCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class SearchTrackCell: UITableViewCell, BaseTableCell {
    static var identifier = "SearchTrackCell"
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
}
