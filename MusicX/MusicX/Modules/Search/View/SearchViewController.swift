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
}

extension SearchViewController : SearchViewInput {
    func updateList() {
        
    }
    
    func onError(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    
    func setupInitialState() {
        setupSearchBar()
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
