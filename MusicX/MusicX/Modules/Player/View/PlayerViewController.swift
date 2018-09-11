//
//  PlayerViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    static let vcId = "PlayerViewController"
    static let storyboardName = "Player"
    
    var output: PlayerViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
    }

}

extension PlayerViewController: PlayerViewInput {
    func setupInitialState() {
        
    }
}
