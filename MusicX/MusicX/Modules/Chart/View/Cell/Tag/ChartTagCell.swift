//
//  ChartTagCell.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/29/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartTagCell: UITableViewCell, BaseTableCell {
    static var identifier = "ChartTagCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reach: UILabel!
    @IBOutlet weak var taggings: UILabel!
}
