import UIKit
import CoreData

class MusicLocalDataSource: MusicDataSource {
    
    private let coreDataManager: BaseCoreDataManager
    
    init(coreDataManager: BaseCoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (ChartResponse?, CustomError?)->Void) {
        completionHandler(nil, nil)
    }
    
    func searchMedia(type: MediaType, name: String, page: Int, completionHandler: @escaping (SearchResponse?, CustomError?) -> Void) {
        
    }
    
    func createPlaylist(name: String) {
        
    }
    
    func getPlaylists(completionHandler: @escaping (PlaylistsResponse?, CustomError?) -> Void) {
        let managedContext = coreDataManager.managedObjectContext
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tracks")
            
            do {
                let array = try managedContext.fetch(fetchRequest)
                array.forEach { (object) in
                    print("\(object.value(forKey: "name"))")
                    print("\(object.value(forKey: "id"))")
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func addTrackToPlaylist(track: Track, playlist: Playlist) {
        
    }
    
    func deleteTrackFromPlaylist(track: Track, playlist: Playlist) {
        
    }
    
    func downloadTrack(track: Track) {
        coreDataManager.managedObjectContext.perform {
            let managedContext = self.coreDataManager.managedObjectContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Tracks", in: managedContext) else {
                return
            }
            
            let trackToSave = NSManagedObject(entity: entity, insertInto: managedContext)
            
            trackToSave.setValue(track.name, forKeyPath: "name")
            trackToSave.setValue(track.id, forKeyPath: "id")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            self.getPlaylists(completionHandler: { (resp, error) in
                
            })
        }
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
    }
    
    func getImageDirectorySize() -> Int {
        return 0
    }
    
    func clearImageDirectory() {
        
    }
}
