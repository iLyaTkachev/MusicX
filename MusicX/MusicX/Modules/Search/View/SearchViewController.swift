//
//  SearchViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    static let vcId = "SearchViewController"
    static let storyboardName = "Search"
    
    var output: SearchViewOutput!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewHolder: UITableView!
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()

    var cellBuider: BaseCellBuilder!
    var tableVC: UniversalTableViewController!
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
    }

    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupTableView() {
        tableVC.delegateAndDataSource = self
        
        view.addSubview(tableVC.view)
        
        tableVC.registerCells(identifiers: [SearchTrackCell.identifier])
        
        tableVC.tableView.rowHeight = UITableViewAutomaticDimension
        tableVC.tableView.estimatedRowHeight = 100
        Utils.setConstraints(from: tableViewHolder, to: tableVC.view)
    }
}

extension SearchViewController : SearchViewInput {
    func updateList() {
        DispatchQueue.main.async {
            self.tableVC.reloadData()
        }
    }
    
    func onError(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    
    func setupInitialState() {
        setupSearchBar()
        setupTableView()
    }
}

extension SearchViewController : UISearchBarDelegate {
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        output.search(with: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}

extension SearchViewController : TableViewDataSourceAndRowsCount {
    func getCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: output.cellIdentifier, for: indexPath)
        let media = output.getMediaObject(forIndex: indexPath.row)
        let cellData = SearchCellBuilder.SearchCellData(type: output.mediaType, media: media!)
        cellBuider.build(cell: cell, data: cellData)
        
        return cell
    }
    
    func getNumberOfRows(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.mediaCount
    }
    
    func cellClicked(index: Int) {
        print("Cell clicked")
    }
}
