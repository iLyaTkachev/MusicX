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
    var activityIndicator = UIActivityIndicatorView()
    
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

//Mark: - ChartViewInput

extension ChartViewController : ChartViewInput {
    func onError(message: String) {
        showAlert(title: "Error", message: message)
        //print("Error")
    }
    
    func updateList(with array: [BaseMediaObject]) {
        let tracks = array as! [Track]
        print(tracks[0].name)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupInitialState() {
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: ChartTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ChartTableViewCell.identifier)
    }
}

extension ChartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.mediaCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.identifier, for: indexPath) as! ChartTableViewCell
        let item = output.getMedia(forIndex: indexPath.row) as! Track
        cell.setup(with: item)
        
        return cell
    }
}
