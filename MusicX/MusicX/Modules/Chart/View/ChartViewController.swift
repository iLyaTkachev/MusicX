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
    var typeListView: TypeButtonsView!
    
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
        
        let nib = UINib.init(nibName: ChartTrackCell.identifier, bundle: nil)
        tableVC.tableView.register(nib, forCellReuseIdentifier: ChartTrackCell.identifier)
        
        tableVC.tableView.rowHeight = UITableViewAutomaticDimension
        tableVC.tableView.estimatedRowHeight = 100
        Utils.setConstraints(from: tableViewHolder, to: tableVC.view)
    }
    
    func setupTypeList() {
        typeListView = TypeButtonsView(frame: typeListHolder.frame)
        view.addSubview(typeListView.contentView)
        Utils.setConstraints(from: typeListHolder, to: typeListView.contentView)
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
        cellBuider.build(cell: cell, data: ChartCellBuilder.ChartCellData(type: output.mediaType, media: output.getMediaObject(forIndex: indexPath.row)))
        
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
