//
//  ChartRouter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/31/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation
import UIKit

class ChartRouter: ChartBaseRouter {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        return UIViewController()
    }
    
    
}
