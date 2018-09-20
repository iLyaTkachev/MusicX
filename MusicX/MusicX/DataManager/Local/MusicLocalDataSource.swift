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
            let fetchRequest = NSFetchRequest<Tracks>(entityName: "Tracks")
            
            print("Data requested")
            do {
                let array = try managedContext.fetch(fetchRequest)
                array.forEach { (object) in
                    print("\(object.id)")
                    print("\(object.name)")
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
    
    func downloadTrack(download: Download) {
        coreDataManager.managedObjectContext.perform {
            let managedContext = self.coreDataManager.managedObjectContext

            let track = download.track
            let artist = track.artist
            let artistToSave = Artists(context: managedContext)
            let trackToSave = Tracks(context: managedContext)
            
            trackToSave.id = track.id
            trackToSave.name = track.name
            trackToSave.fileUrl = download.downloadUrl
            trackToSave.duration = download.duration
            trackToSave.bitrate = download.bitrate
            
            artistToSave.id = artist.id
            artistToSave.name = artist.name
            artistToSave.addToTracks(trackToSave)
            
            do {
                try managedContext.save()
                self.coreDataManager.saveChanges()
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
