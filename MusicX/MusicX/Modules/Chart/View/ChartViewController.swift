//
//  ChartViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/31/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    let imageService = ImageService(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024)
    
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
        output.loadMedia(isReloading: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                //self.navigationController?.setNavigationBarHidden(true, animated: true)
                //self.view.layoutIfNeeded()
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                //self.navigationController?.setNavigationBarHidden(false, animated: true)
                //self.view.layoutIfNeeded()
                print("Unhide")
            }, completion: nil)
        }
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
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
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
        cell.artistImageView.image = nil
        cell.spinner.startAnimating()
        
        imageService.getImage(withUrl: item.imageUrl) { (image, error) in
            DispatchQueue.main.async {
                if image != nil && cell.imageURL == item.imageUrl {
                    cell.artistImageView.image = image
                }
                
                cell.spinner.stopAnimating()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = output.mediaCount - 10
        
        if indexPath.row >= lastItem {
            output.loadMedia(isReloading: false)
        }
    }
}
