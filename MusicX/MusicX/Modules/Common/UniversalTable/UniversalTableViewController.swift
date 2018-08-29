//
//  UniversalTableViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/22/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol UniversalTableViewOutput : class {
    func getCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func getNumberOfRows(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func willDisplay(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func scrollDown()
    func scrollUp()
    func cellClicked(index: Int)
}

protocol UniversalTableViewInput {
    func reloadData()
    func registerCells(identifiers: [String])
}

class UniversalTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var output: UniversalTableViewOutput!
    
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
            output.scrollDown()
        } else {
            output.scrollUp()
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
        return output.getCell(tableView: tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.willDisplay(tableView: tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.cellClicked(index: indexPath.row)
    }
}

extension UniversalTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getNumberOfRows(tableView: tableView, numberOfRowsInSection: section)
    }
}
