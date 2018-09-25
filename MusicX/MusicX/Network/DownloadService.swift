import Foundation

class DownloadService {
    
    var downloadsSession = URLSession(configuration: .background(withIdentifier: "DownloadSession"))
    var activeDownloads: [URL: Download] = [:]
    
    // MARK: - Download methods called by TrackCell delegate methods
    
    func startDownload(download: Download) {
        
        if let url = URL(string: download.downloadUrl) {
            download.task = downloadsSession.downloadTask(with: url)
            download.task!.resume()
            download.isDownloading = true
            activeDownloads[url] = download
        }
    }
    
    /*func pauseDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
            })
            download.isDownloading = false
        }
    }
    
    func cancelDownload(_ track: Track) {
        if let download = activeDownloads[track.previewURL] {
            download.task?.cancel()
            activeDownloads[track.previewURL] = nil
        }
    }
    
    func resumeDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        } else {
            download.task = downloadsSession.downloadTask(with: download.track.previewURL)
        }
        download.task!.resume()
        download.isDownloading = true
    }*/
}
