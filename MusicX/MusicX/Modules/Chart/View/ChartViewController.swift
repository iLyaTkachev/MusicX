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
    
    var cellBuider: BaseCellBuilder!
    
    var tableVC: UniversalTableViewController!
    var typeListView: TypeButtonsViewInput!
    
    var output: ChartViewOutput!
    var activityIndicator = UIActivityIndicatorView()
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var typeListHolder: UIView!
    @IBOutlet weak var tableViewHolder: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
    }
    
    func setupTableView() {
        tableVC.output = self
        tableVC.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(tableVC.view)
        
        tableVC.registerCell(identifier: ChartTrackCell.identifier)
        tableVC.registerCell(identifier: ChartArtistCell.identifier)
        
        tableVC.tableView.rowHeight = UITableViewAutomaticDimension
        tableVC.tableView.estimatedRowHeight = 100
        Utils.setConstraints(from: tableViewHolder, to: tableVC.view)
    }
    
    func setupTypeList() {
        typeListView = TypeButtonsView(frame: typeListHolder.frame)
        typeListView.setOutput(output: self)
        typeListView.setType(type: output.mediaType)
        view.addSubview(typeListView.getView())
        Utils.setConstraints(from: typeListHolder, to: typeListView.getView())
    }
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableVC.tableView.refreshControl = refreshControl
        } else {
            tableVC.tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    }
    
    @objc func refresh() {
        output.loadMedia(isReloading: true)
    }
}

//Mark: - ChartViewInput

extension ChartViewController : ChartViewInput {
    func setType(type: MediaType) {
        typeListView.setType(type: type)
    }
    
    func onError(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func updateList() {
        DispatchQueue.main.async {
            self.tableVC.tableView.reloadData()
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func setupInitialState() {
        setupTableView()
        setupRefreshControl()
        setupTypeList()
    }
}

//Mark: - UniversalTableViewOutput

extension ChartViewController : UniversalTableViewOutput {
    func cellClicked(index: Int) {
        output.cellClicked(index: index)
    }
    
    func getCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: output.cellIdentifier, for: indexPath)
        
        let media = output.getMediaObject(forIndex: indexPath.row)
        
        let cellData = ChartCellBuilder.ChartCellData(type: output.mediaType, media: media!)
        cellBuider.build(cell: cell, data: cellData)
        
        return cell
    }
    
    func getNumberOfRows(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.mediaCount
    }
    
    func willDisplay(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = output.mediaCount - 10
        
        if indexPath.row >= lastItem {
            output.loadMedia(isReloading: false)
        }
    }
    
    func scrollDown() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.typeListView.moduleVisibility(isVisible: false)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func scrollUp() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.typeListView.moduleVisibility(isVisible: true)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

//Mark: - TypeButtonsViewOutput

extension ChartViewController : TypeButtonsViewOutput {
    func typeSelected(type: MediaType) {
        
        //tableVC.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        //self.showActivityIndicator()
        self.output.changeType(type: type)
        
        
    }
}
