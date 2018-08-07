//
//  ViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    static let id = "TabBarViewController"
    static let storyboardId = "TabBarStoryboard"
    
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

extension TabBarViewController : TabBarViewInput {
    func setupInitialState() {
        
    }
}
