import Foundation

class Download: BaseMediaObject {
    var name: String
    var track: Track
    var fileUrl: String
    var duration: String
    var bitrate: String
    var downloaded = false
    
    lazy var downloadUrl: URL? = {
        return URL(string: fileUrl) ?? nil
    }()
    
    init(track: Track, downloadUrl: String, duration: String, bitrate: String) {
        self.track = track
        self.name = track.name
        self.fileUrl = downloadUrl
        self.duration = duration
        self.bitrate = bitrate
    }
    
    // Download service sets these values:
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    var progress: Float = 0
}
