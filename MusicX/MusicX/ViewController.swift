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
        let url = ApiRequestBuilder.LastFmBuilder.init().buildJsonRequest(withMethod: Constants.ApiComponents.Chart.chart + "." + Constants.ApiComponents.Chart.getTopTracks)
        
        let apiService = MusicAPIService()
        apiService.executeWebRequest(urlToExecute: url!) { (responseDict, error) in
            
            DispatchQueue.main.async {
                if let unwrappedError = error {
                    self.textView.text = unwrappedError.localizedDescription
                } else {
                    self.textView.text = responseDict?.description
                }
            }
        }
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        makeRequest()
    }
    
}
