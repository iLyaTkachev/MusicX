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
    static let storyboardId = "ChartStoryboard"
    
    var output: ChartViewOutput!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChartViewController : ChartViewInput {
    func updateList(with array: [Track]) {
        
    }
    
    func setupInitialState() {
        
    }
}
