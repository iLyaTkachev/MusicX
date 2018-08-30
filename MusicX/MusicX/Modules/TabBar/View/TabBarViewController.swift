//
//  ViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    static let vcId = "TabBarViewController"
    static let storyboardName = "TabBar"
    
    var output: TabBarViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//Mark: - TabBarViewInput

extension TabBarViewController : TabBarViewInput {
    func setupInitialState() {
        
    }
}
