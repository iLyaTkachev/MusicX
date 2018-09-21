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
    
    func getPlaylist(playlistName: String, completionHandler: @escaping (Playlist?, CustomError?) -> Void) {
        let managedContext = coreDataManager.managedObjectContext
        managedContext.perform {
            let fetchRequest = NSFetchRequest<Playlists>(entityName: "Playlists")
            let predicate = NSPredicate(format: "name == %@", playlistName)
            fetchRequest.predicate = predicate
            print("Data requested")
            do {
                let array = try managedContext.fetch(fetchRequest)
                if !array.isEmpty {
                    let fromStorage = array[0]
                    let playlist = self.playlistConverter(fromCoreData: fromStorage)

                    completionHandler(playlist, nil)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                completionHandler(nil, CustomError.localDataError)
            }
        }
    }
    
    func playlistConverter(fromCoreData: Playlists) -> Playlist {
        var downloads: [Download] = []
        
        if let tracksFromCoreData = fromCoreData.tracks?.array as? [Tracks], !tracksFromCoreData.isEmpty {
            
            tracksFromCoreData.forEach({ (item) in
                let download = downloadConverter(fromCoreData: item)
                downloads.append(download)
            })
        }
        
        let playlist = Playlist(name: fromCoreData.name, downloads: downloads)
        
        return playlist
    }
    
    func artistConverter(fromCoreData: Artists) -> Artist {
        let artist = Artist(name: fromCoreData.name, id: fromCoreData.id)
    }
    
    func trackConverter(fromCoreData: Tracks) -> Track {
        let track = Track(name: fromCoreData.name, id: fromCoreData.id, artist: artistConverter(fromCoreData: fromCoreData.artist))
        
        return track
    }
    
    func downloadConverter(fromCoreData: Tracks) -> Download {
        let track = trackConverter(fromCoreData: fromCoreData)
        let download = Download(track: track, downloadUrl: fromCoreData.fileUrl, duration: fromCoreData.duration, bitrate: fromCoreData.bitrate)
        
        return download
    }
    
    func deleteTrack(download: Download, completionHandler: @escaping (CustomError?) -> Void) {
        
    }
    
    func downloadTrack(download: Download, completionHandler: @escaping (CustomError?) -> Void) {
        coreDataManager.managedObjectContext.perform {
            let managedContext = self.coreDataManager.managedObjectContext
            
            let track = download.track
            let artist = track.artist
            let artistToSave = Artists(context: managedContext)
            let trackToSave = Tracks(context: managedContext)
            let playlistToSave = Playlists(context: managedContext)
            
            trackToSave.id = track.id
            trackToSave.name = track.name
            trackToSave.fileUrl = download.downloadUrl
            trackToSave.duration = download.duration
            trackToSave.bitrate = download.bitrate
            
            artistToSave.id = artist.id
            artistToSave.name = artist.name
            artistToSave.addToTracks(trackToSave)
            playlistToSave.name = "Downloads"
            playlistToSave.addToTracks(trackToSave)
            
            do {
                try managedContext.save()
                self.coreDataManager.saveChanges()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            self.getPlaylist(playlistName: "Downloads", completionHandler: { (playlist, error) in
                
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
