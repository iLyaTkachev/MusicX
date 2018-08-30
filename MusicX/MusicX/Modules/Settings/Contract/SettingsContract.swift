//
//  SettingsContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/29/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol SettingsViewInput : BaseViewInput {
    func setImageCacheSize(value: Int)
}

protocol SettingsViewOutput : BaseViewOutput {
    func viewWillAppear()
    func clearImageCache()
}

protocol SettingsInteractorInput : BaseInteractorInput {
    func clearImageCache()
    func getImageCacheSize() -> Int
}

protocol SettingsInteractorOutput : BaseInteractorOutput {

}

protocol SettingsRouterInput : BaseRouterInput {

}

