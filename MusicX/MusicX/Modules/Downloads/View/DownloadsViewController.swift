//
//  DownloadsViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class DownloadsViewController: UIViewController {

    static let vcId = "DownloadsViewController"
    static let storyboardName = "Downloads"
    
    var output: DownloadsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
    }

}

extension DownloadsViewController: DownloadsViewInput {
    func setupInitialState() {
        
    }
    
    
}
