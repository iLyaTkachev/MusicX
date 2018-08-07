//
//  ApplicationConfigurator.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/2/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ApplicationConfgurator: BaseConfigurator {
    
    private var isSignedIn = true
    
    func configure() {
        
        if isSignedIn {
            TabBarModule.create().present()
        }
    }
}
