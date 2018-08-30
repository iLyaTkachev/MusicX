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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
    }

}

extension SearchViewController : SearchViewInput {
    func setupInitialState() {
        
    }
    
}
