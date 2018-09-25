import Foundation

class DownloadService {
    
    var downloadsSession = URLSession(configuration: .background(withIdentifier: "DownloadSession"))
    var activeDownloads: [URL: Download] = [:]
    
    // MARK: - Download methods called by TrackCell delegate methods
    
    func startDownload(download: Download) {
        
        guard let url = download.downloadUrl else {
            return
        }

            download.task = downloadsSession.downloadTask(with: url)
            download.task!.resume()
            download.isDownloading = true
            activeDownloads[url] = download
    }
    
    func pauseDownload(download: Download) {
        guard let url = download.downloadUrl, let download = activeDownloads[url] else {
            return
        }
        
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
            })
            download.isDownloading = false
        }
    }
    
    func cancelDownload(download: Download) {
        if let url = download.downloadUrl, let download = activeDownloads[url] {
            download.task?.cancel()
            activeDownloads[url] = nil
        }
    }
    
    func resumeDownload(download: Download) {
        guard let url = download.downloadUrl, let download = activeDownloads[url] else {
            return
        }
        
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        } else {
            download.task = downloadsSession.downloadTask(with: url)
        }
        
        download.task!.resume()
        download.isDownloading = true
    }
}
