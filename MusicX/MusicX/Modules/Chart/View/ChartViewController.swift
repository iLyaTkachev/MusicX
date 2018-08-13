//
//  ChartViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/31/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    static let id = "ChartViewController"
    static let storyboardId = "Chart"
    
    var output: ChartViewOutput!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        //Chart<Track>(with: ["abc":"abc"])
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Mark: - ChartViewInput

extension ChartViewController : ChartViewInput {
    func onError() {
        print("Error")
    }
    
    func updateList(with array: [BaseMediaObject]) {
        print(array[0])
    }
    
    func setupInitialState() {
        //start progress
    }
}
