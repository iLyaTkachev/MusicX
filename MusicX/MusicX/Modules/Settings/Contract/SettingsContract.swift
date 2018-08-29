//
//  SettingsContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/29/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol SettingsViewInput : BaseViewInput {
    
}

protocol SettingsViewOutput : BaseViewOutput {
    func clearImageCache()
}

protocol SettingsInteractorInput : BaseInteractorInput {
    
}

protocol SettingsInteractorOutput : BaseInteractorOutput {

}

protocol SettingsRouterInput : BaseRouterInput {

}

