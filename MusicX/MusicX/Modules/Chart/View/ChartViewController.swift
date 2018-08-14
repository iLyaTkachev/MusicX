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
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: ChartTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ChartTableViewCell.identifier)
    }
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    }
    
    @objc func refresh() {
        print("Refreshing")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
}

//Mark: - ChartViewInput

extension ChartViewController : ChartViewInput {
    func onError(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func updateList(with array: [BaseMediaObject]) {
        let tracks = array as! [Track]
        print(tracks[0].name)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupInitialState() {
        setupTableView()
        setupRefreshControl()
    }
}

//Mark: - UITableViewDelegate & UITableViewDataSource

extension ChartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.mediaCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.identifier, for: indexPath) as! ChartTableViewCell
        let item = output.getMediaObject(forIndex: indexPath.row) as! Track
        cell.setup(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = output.mediaCount - 10
        
        if indexPath.row >= lastItem {
            output.loadMedia()
        }
    }
}
