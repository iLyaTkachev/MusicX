//
//  ChartTableViewCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/31/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartTrackCell: UITableViewCell, BaseTableCell {
    static var identifier: String = "ChartTrackCell"
    var imageURL: String?
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
}
