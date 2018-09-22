import UIKit
import CoreData

class MusicLocalDataSource: MusicDataSource {

    private let coreDataManager: BaseCoreDataManager
    private let managedObjectParser: ManagedObjectParser
    
    init(coreDataManager: BaseCoreDataManager) {
        self.coreDataManager = coreDataManager
        self.managedObjectParser = ManagedObjectParser()
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (ChartResponse?, CustomError?)->Void) {
        completionHandler(nil, nil)
    }
    
    func searchMedia(type: MediaType, name: String, page: Int, completionHandler: @escaping (SearchResponse?, CustomError?) -> Void) {
        
    }
    
    func getPlaylist(playlistName: String, completionHandler: @escaping (Playlist?, CustomError?) -> Void) {
        let managedContext = coreDataManager.managedObjectContext
        managedContext.perform { [weak self] () in
            let fetchRequest = NSFetchRequest<Playlists>(entityName: "Playlists")
            let predicate = NSPredicate(format: "name == %@", playlistName)
            fetchRequest.predicate = predicate
            print("Data requested")
            do {
                let array = try managedContext.fetch(fetchRequest)
                if !array.isEmpty {
                    let fromStorage = array[0]
                    let playlist = self?.managedObjectParser.playlistParser(managedObject: fromStorage)

                    completionHandler(playlist, nil)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                completionHandler(nil, CustomError.localDataError)
            }
        }
    }
    
    func deleteTrack(download: Download, completionHandler: @escaping (CustomError?) -> Void) {
        
    }
    
    func downloadTrack(download: Download, completionHandler: @escaping (CustomError?) -> Void) {
        coreDataManager.managedObjectContext.perform { [weak self] () in
            guard let managedContext = self?.coreDataManager.managedObjectContext else {
                return
            }
            
            let track = download.track
            let artist = track.artist
            let artistToSave = Artists(context: managedContext)
            let trackToSave = Tracks(context: managedContext)
            let downloadToSave = Downloads(context: managedContext)
            let playlistToSave = Playlists(context: managedContext)
            
            trackToSave.id = track.id
            trackToSave.name = track.name
            artistToSave.id = artist.id
            artistToSave.name = artist.name
            artistToSave.addToTracks(trackToSave)
            downloadToSave.track = trackToSave
            downloadToSave.fileUrl = download.downloadUrl
            downloadToSave.duration = download.duration
            downloadToSave.bitrate = download.bitrate
            playlistToSave.name = "Downloads"
            downloadToSave.addToPlaylists(playlistToSave)
            
            do {
                try managedContext.save()
                self?.coreDataManager.saveChanges()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
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
