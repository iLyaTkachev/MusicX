//
//  TestViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/16/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var tableHolder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = TestTableViewController()
        view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        //vc.view.heightAnchor.constraint(equalTo: tableHolder.heightAnchor)
        //vc.view.widthAnchor.constraint(equalTo: tableHolder.widthAnchor)
        vc.view.leadingAnchor.constraint(equalTo: tableHolder.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: tableHolder.trailingAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: tableHolder.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: tableHolder.bottomAnchor).isActive = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func click(_ sender: UIButton) {
        print("Button clicked")
        let cell = TestCellView.init(frame: viewHolder.bounds)
        /*cell.addConstraints([
            NSLayoutConstraint(item: cell, attribute: .width, relatedBy: .equal, toItem: viewHolder, attribute: .width, multiplier: 1.0, constant: 0)
            ])*/
        
        
        viewHolder.addSubview(cell)
        
        //viewHolder.addSubview(cell)
        print("viewHolder bound: \(viewHolder.bounds)")
        print("viewHolder frame: \(viewHolder.frame)")
    }
    
}
