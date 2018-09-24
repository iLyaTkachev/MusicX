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
    
    var managedObjectContext: NSManagedObjectContext {
        return self.privateChildManagedObjectContext()
    }
    
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
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        return persistentStoreCoordinator
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {

        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        managedObjectContext.parent = self.privateManagedObjectContext
        
        return managedObjectContext
    }()
    
    func privateChildManagedObjectContext() -> NSManagedObjectContext {

        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        managedObjectContext.parent = mainManagedObjectContext
        
        return managedObjectContext
    }
    
    init(modelName: String) {
        self.modelName = modelName
        setupCoreDataStack()
    }
    
    private func setupCoreDataStack() {
        self.addPersistentStore()
    }
    
    private func addPersistentStore() {
        guard let persistentStoreCoordinator = persistentStoreCoordinator else { fatalError("Unable to Initialize Persistent Store Coordinator") }
        
        let persistentStoreURL = self.persistentStoreURL
        
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
            
        } catch {
            let addPersistentStoreError = error as NSError
            
            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }
    }
    
    public func saveChanges() {
        mainManagedObjectContext.performAndWait({
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Main Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        })
        
        privateManagedObjectContext.perform({
            do {
                if self.privateManagedObjectContext.hasChanges {
                    try self.privateManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Private Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        })
    }
}
