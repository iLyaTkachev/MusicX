//
//  ApplicationConfigurator.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/2/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ApplicationConfgurator: BaseConfigurator {
    
    func configure() {
        
        if CoreX.shared.isSignedIn() {
            //TabBarModule.create().present()
            let vc = Utils.getViewController(storyboardName: "TestViewController", vcId: "TestViewController") as! TestViewController
            AppDelegate.currentWindow.rootViewController = vc
        }
    }
}
