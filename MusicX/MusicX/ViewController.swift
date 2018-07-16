//
//  ViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/16/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=\(SecretConstants.apiKey)&format=json")
        
        let apiService = MusicAPIService()
        apiService.executeWebRequest(urlToExecute: url!) { (responseDict, error) in
            print(responseDict)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

