//
//  UIViewController+Helpers.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrapToNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        
        return navigationController
    }

    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

protocol ActivityIndicator {
    var activityIndicator: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicator where Self: UIViewController {
    
    func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

