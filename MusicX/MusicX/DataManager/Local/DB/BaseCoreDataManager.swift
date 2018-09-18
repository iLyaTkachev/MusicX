//
//  BaseCoreDataManager.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/17/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseCoreDataManager {
    func select()
    func create()
    func update()
    func delete()
    func saveChanges()
}
