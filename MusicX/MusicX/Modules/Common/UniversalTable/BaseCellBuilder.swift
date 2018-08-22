//
//  BaseCellBuilder.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/22/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol BaseCellBuilder {
    func build<T>(withData: T) -> UITableViewCell?
}
