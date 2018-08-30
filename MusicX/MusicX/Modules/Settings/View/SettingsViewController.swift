//
//  SettingsViewController.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/29/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    static let vcId = "SettingsViewController"
    static let storyboardName = "Settings"
    
    var output: SettingsViewOutput!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageMemoryProgress: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        output.viewIsReady()
        
        guard let dict = UserDefaults.standard.object(forKey: "dict") as? [String], !dict.isEmpty else {
            registerSettingsBundle()
            NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.setValuesFromDict), name: UserDefaults.didChangeNotification, object: nil)
            setValuesFromDict()
            
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.setValuesFromDict), name: UserDefaults.didChangeNotification, object: nil)
        
        setValuesFromDict()
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        var dict = UserDefaults.standard.object(forKey: "dict") as! [String : Any]
        dict["Name"]=dict["Name"] as! String + "1"
        UserDefaults.standard.set(dict, forKey: "dict")
    }
    
    @IBAction func clearButtonClick(_ sender: UIButton) {
        imageMemoryProgress.setProgress(1, animated: true)
    }
    
    func registerSettingsBundle(){
        let appDefaults: [String:Any] = ["Name": "Paul", "Country": "UK"]
        UserDefaults.standard.set(appDefaults, forKey: "dict")
    }
    @objc func setValuesFromDict(){
        let dict = UserDefaults.standard.object(forKey: "dict") as! [String : Any]
        guard let text = dict["Name"] as? String else {
            return
        }
        label.text = text
        
    }
}

extension SettingsViewController : SettingsViewInput {
    func setupInitialState() {
        
    }
}
