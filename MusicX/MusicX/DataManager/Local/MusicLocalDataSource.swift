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
    
    func showAllCoreData() {
        let managedContext = coreDataManager.managedObjectContext
        managedContext.perform { [weak self] () in
            let playlistFetchRequest = NSFetchRequest<Playlists>(entityName: "Playlists")
            let downloadsFetchRequest = NSFetchRequest<Downloads>(entityName: "Downloads")
            let tracksFetchRequest = NSFetchRequest<Tracks>(entityName: "Tracks")
            let artistsFetchRequest = NSFetchRequest<Artists>(entityName: "Artists")
            
            do {
                let pArray = try managedContext.fetch(playlistFetchRequest)
                let dArray = try managedContext.fetch(downloadsFetchRequest)
                let tArray = try managedContext.fetch(tracksFetchRequest)
                let aArray = try managedContext.fetch(artistsFetchRequest)
                
                pArray.forEach({ (item) in
                    let playlist = self?.managedObjectParser.playlistParser(managedObject: item)
                    print("\(playlist?.name)")
                })
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
        }
    }
    
    private func getPlaylist(name: String, managedContext: NSManagedObjectContext) -> Playlists? {
        var result: Playlists?
        
        managedContext.performAndWait { [weak self] () in
            
            let fetchRequest = NSFetchRequest<Playlists>(entityName: "Playlists")
            let predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.predicate = predicate
            
            guard let response = try? managedContext.fetch(fetchRequest),
                !response.isEmpty else {
                    result = nil
                    return
            }
            
            result = response[0]
        }
        
        return result
    }
    
    private func createPlaylist(name: String, managedContext: NSManagedObjectContext) -> Playlists? {
        var result: Playlists?
        
        managedContext.performAndWait { [weak self] () in
            
            let playlistToSave = Playlists(context: managedContext)
            playlistToSave.name = name
            
            do {
                try managedContext.save()
                self?.coreDataManager.saveChanges()
                result = playlistToSave
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        return result
    }
    
    func downloadTrack(download: Download, completionHandler: @escaping (CustomError?) -> Void) {
        let managedContext = coreDataManager.managedObjectContext
        managedContext.perform { [weak self] () in
            
            let track = download.track
            let artist = track.artist
            let artistToSave = Artists(context: managedContext)
            let trackToSave = Tracks(context: managedContext)
            let downloadToSave = Downloads(context: managedContext)
            
            var playlistCD = self?.getPlaylist(name: "Downloads", managedContext: managedContext)
            
            if playlistCD == nil {
                playlistCD = Playlists(context: managedContext)
                playlistCD?.name = "Downloads"
                //playlistCD = self?.createPlaylist(name: "Downloads", managedContext: managedContext)
            }
            
            if let playlistToSave = playlistCD {
            trackToSave.id = track.id
            trackToSave.name = track.name
            artistToSave.id = artist.id
            artistToSave.name = artist.name
            artistToSave.addToTracks(trackToSave)
            downloadToSave.track = trackToSave
            downloadToSave.fileUrl = download.downloadUrl
            downloadToSave.duration = download.duration
            downloadToSave.bitrate = download.bitrate
            //playlistToSave.name = "Downloads"
            playlistToSave.addToDownloads(downloadToSave)
            
            do {
                try managedContext.save()
                self?.coreDataManager.saveChanges()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            print("Show all core data")
            self?.showAllCoreData()
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
