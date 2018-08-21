import UIKit

class ViewController: UIViewController {

    static var id = "ViewController"
    static var storyboardID = "Main"
    
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
        let url = ApiRequestBuilder.LastFmBuilder().buildJsonRequest(withMethod: ApiConstants.ApiComponents.Chart.chart + "." + ApiConstants.ApiComponents.Chart.getTopTracks, withPage: nil)
        
        let apiService: BaseNetworkService
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
        self.selectButton.isHidden = !self.selectButton.isHidden
        //makeRequest()
        /*let chartStoryboard = UIStoryboard(name: "ChartStoryboard", bundle: Bundle.main)

        guard let vc = chartStoryboard.instantiateViewController(withIdentifier: "ChartViewController") as? ChartViewController else {
            return
        }
        
        present(vc, animated: true, completion: nil)*/
    }
    
    func concurrentTypes() {
        DispatchQueue.main.async {
            
        }
        
        DispatchQueue.global().async {
            
        }
        
    }
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func handleSelection(_ sender: UIButton) {
        buttons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                //UIView.animateKeyframes
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        
        selectButton.setTitle(title, for: .normal)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                //self.navigationController?.setNavigationBarHidden(true, animated: true)
                //self.view.layoutIfNeeded()
                self.selectButton.isHidden = true
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                //self.navigationController?.setNavigationBarHidden(false, animated: true)
                //self.view.layoutIfNeeded()
                self.selectButton.isHidden = false
                print("Unhide")
            }, completion: nil)
        }
    }
    
}
