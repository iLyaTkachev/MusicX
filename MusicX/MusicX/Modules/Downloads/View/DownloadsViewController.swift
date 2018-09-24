//
//  DownloadsViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class DownloadsViewController: UIViewController {

    static let vcId = "DownloadsViewController"
    static let storyboardName = "Downloads"
    
    var output: DownloadsViewOutput!
    
    var cellBuider: BaseCellBuilder!
    var tableVC: UniversalTableViewController!
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableViewHolder: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.reloadData()
    }
    
    func setupTableView() {
        cellBuider = SearchCellBuilder()
        tableVC = UniversalTableViewController()
        tableVC.delegateAndDataSource = self
        
        view.addSubview(tableVC.view)
        self.tableVC.view.isHidden = true
        
        tableVC.registerCells(identifiers: [SearchTrackCell.identifier])
        
        tableVC.tableView.rowHeight = UITableViewAutomaticDimension
        tableVC.tableView.estimatedRowHeight = 100
        Utils.setConstraints(from: tableViewHolder, to: tableVC.view)
    }
    
}

extension DownloadsViewController: DownloadsViewInput {
    func updateList() {
        DispatchQueue.main.async { [weak self] () in
            self?.tableVC.view.isHidden = false
            self?.tableVC.reloadData()
        }
    }
    
    func onError(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func setupInitialState() {
        setupTableView()
        setupActivityIndicator()
    }
}

extension DownloadsViewController: TableViewDataSourceAndRowsCount {
    func getCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: output.cellIdentifier, for: indexPath)
        let media = output.getMediaObject(forIndex: indexPath.row)
        let cellData = SearchCellBuilder.SearchCellData(type: .track, media: media!)
        cellBuider.build(cell: cell, data: cellData)
        
        if let trackCell = cell as? SearchTrackCell {
            trackCell.downloadButton.isHidden = true
        }
        
        return cell
    }
    
    func getNumberOfRows(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.mediaCount
    }
    
    func cellClicked(index: Int) {
        print("Cell clicked")
    }
}
