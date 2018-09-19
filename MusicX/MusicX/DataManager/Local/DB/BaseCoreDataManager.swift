//
//  BaseCoreDataManager.swift
//  MusicX
//
//  Created by Ilya Tkachou on 9/17/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation
import CoreData

protocol BaseCoreDataManager {
    var managedObjectContext: NSManagedObjectContext { get }
    func saveChanges()
}
