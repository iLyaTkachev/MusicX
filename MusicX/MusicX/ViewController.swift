import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func makeRequest() {
        let url = ApiRequestBuilder.LastFmBuilder().buildJsonRequest(withMethod: Constants.ApiComponents.Chart.chart + "." + Constants.ApiComponents.Chart.getTopTracks, withPage: nil)
        
        let apiService: NetworkService
        apiService = QueryService()
        
        apiService.executeRequest(urlToExecute: url!) { (responseDict, error) in
            
            DispatchQueue.main.async {
                if let unwrappedError = error {
                    self.textView.text = unwrappedError.localizedDescription
                } else {
                    guard let dict = responseDict?["tracks"] as? [String : Any] , let array = dict["track"] as? [Any] else {
                        print("Dictionary does not contain track key\n")
                        return
                    }
                    
                    for trackDictionary in array {
                        if let trackDictionary = trackDictionary as? [String : Any],
                            let track = Track(with: trackDictionary) {
                            print(track.name + " " + track.listeners)
                        } else {
                            print("Problem parsing trackDictionary\n")
                            break
                        }
                    }
                    
                }
            }
        }
        
       
    }

    var val1: Artist?
    var count = 0
    
    @IBAction func buttonClick(_ sender: UIButton) {
        //makeRequest()
        
        val1 = Artist(name: "Artist \(count)", mbid: "123")
        count+=1
    }
    
    func concurrentTypes() {
        DispatchQueue.main.async {
            
        }
        
        DispatchQueue.global().async {
            
        }
        
    }
    
}
