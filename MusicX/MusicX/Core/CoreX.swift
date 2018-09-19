//
//  CoreX.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class CoreX {
    static let shared = CoreX()
    
    let repository: MusicDataSource
    
    let dataModelName = "DataModel"
    let coreDataManager: BaseCoreDataManager
    
    
    private init() {

        self.coreDataManager = CoreDataManager(modelName: dataModelName)
        self.repository = MusicRepository(coreDataManager: self.coreDataManager)
    }
    
    func isSignedIn() -> Bool {
        return true
    }
    
    func saveContext() {
        coreDataManager.saveChanges()
    }
}
