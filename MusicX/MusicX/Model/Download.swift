import Foundation

struct Download : BaseMediaObject {
    var name: String
    var track: Track
    var downloadUrl: String
    
    init(track: Track, downloadUrl: String) {
        self.track = track
        self.name = track.name
        self.downloadUrl = downloadUrl
    }
    
    // Download service sets these values:
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    var progress: Float = 0
    
}
