//
//  CoreDataManager.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/17/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager: BaseCoreDataManager {
    
    private let modelName: String
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        
        guard let modelUrl = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }
        
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl)
        
        return managedObjectModel
    }()
    
    private var persistentStoreURL: URL {
        let storeName = "\(modelName).sqlite"
        let fileManager = FileManager.default
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        return documentsDirectoryURL.appendingPathComponent(storeName)
    }
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = self.managedObjectModel else {
            return nil
        }
        
        let persistentStoreURL = self.persistentStoreURL
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
            
        } catch {
            let addPersistentStoreError = error as NSError
            
            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }
        
        return persistentStoreCoordinator
    }()
    
    public private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    func fetch() {
        
    }
    
    func create() {
        
    }
    
    func update() {
        
    }
}
