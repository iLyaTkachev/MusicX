//
//  ChartArtistCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/25/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartArtistCell: UITableViewCell, BaseTableCell {
    static var identifier = "ChartArtistCell"
    var imageURL: String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var listeners: UILabel!
    @IBOutlet weak var playCount: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
}
