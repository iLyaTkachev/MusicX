//
//  UniversalTableViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/22/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol TableViewDataSourceAndRowsCount: class {
    func getCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func getNumberOfRows(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func cellClicked(index: Int)
}

protocol TableViewPagination: class {
    func willDisplay(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

protocol TableViewScrolling: class {
    func scrollDown()
    func scrollUp()
}

protocol UniversalTableViewInput {
    func reloadData()
    func registerCells(identifiers: [String])
}

class UniversalTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegateAndDataSource: TableViewDataSourceAndRowsCount?
    weak var paginationDelegate: TableViewPagination?
    weak var scrollingDelegate: TableViewScrolling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            scrollingDelegate?.scrollDown()
        } else {
            scrollingDelegate?.scrollUp()
        }
    }

}

extension UniversalTableViewController: UniversalTableViewInput {
    func registerCells(identifiers: [String]) {
        identifiers.forEach { (identifier) in
            let nib = UINib.init(nibName: identifier, bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension UniversalTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegateAndDataSource?.getCell(tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        paginationDelegate?.willDisplay(tableView: tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateAndDataSource?.cellClicked(index: indexPath.row)
    }
}

extension UniversalTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegateAndDataSource?.getNumberOfRows(tableView: tableView, numberOfRowsInSection: section) ?? 0
    }
}
