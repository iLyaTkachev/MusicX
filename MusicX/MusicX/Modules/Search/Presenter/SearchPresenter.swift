//
//  SearchPresenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SearchPresenter {
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!
    
    var isLoading = false
    var currentPage = 0
    var currentMediaType: MediaType!
    
    private var items: [BaseMediaObject] = []
    private var searchName = ""
}

extension SearchPresenter: SearchInteractorOutput {
    func didFetchWithSuccess(response: SearchResponse) {
        guard response.type == currentMediaType, response.searchName == self.searchName else {
            return
        }
        
        items = response.items
        view.updateList()
        view.hideActivityIndicator()
        
        if items.isEmpty {
            view.onError(message: "No results")
        }
    }
    
    func didFetchWithFailure(error: CustomError) {
        view.hideActivityIndicator()
        view.onError(message: error.errorDesctiption())
    }
    
}

extension SearchPresenter: SearchViewOutput {
    
    var mediaType: MediaType {
        return currentMediaType
    }
    
    var mediaCount: Int {
        return items.count
    }
    
    var cellIdentifier: String {
        return SearchTrackCell.identifier
    }
    
    func getMediaObject(forIndex: Int) -> BaseMediaObject? {
        guard forIndex < items.count else {
            return nil
        }
        
        return items[forIndex]
    }
    
    func cellClicked(index: Int) {
        print("cell clicked")
    }
    
    func search(with name: String) {
        view.showActivityIndicator()
        searchName = name
        
        DispatchQueue.main.async {
            self.items.removeAll()
            self.view.updateList()
        }
        
        interactor.searchMedia(type: currentMediaType, name: name, page: 1)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func downloadTrackTapped(index: Int) {
        print("\(index) tapped")
        
        save(name: items[index].name)
        fetch(name: "Tracks")
    }
    
    func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tracks", in: managedContext) else {
            return
        }
        
        let track = NSManagedObject(entity: entity, insertInto: managedContext)
        
        track.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext = appDelegate.persistentContainer.newBackgroundContext()
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
            
            do {
                let array = try managedContext.fetch(fetchRequest)
                array.forEach { (object) in
                    print("\(object.value(forKey: "name"))")
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }

        
    }
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.newBackgroundContext()
    }
}
