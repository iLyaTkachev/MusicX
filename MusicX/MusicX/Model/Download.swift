import Foundation

struct Download : BaseMediaObject {
    var name: String
    var track: Track
    var downloadUrl: String
    var duration: String
    var bitrate: String
    
    init(track: Track, downloadUrl: String, duration: String, bitrate: String) {
        self.track = track
        self.name = track.name
        self.downloadUrl = downloadUrl
        self.duration = duration
        self.bitrate = bitrate
    }
    
    // Download service sets these values:
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    var progress: Float = 0
    
}
