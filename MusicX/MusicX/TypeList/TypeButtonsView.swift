//
//  SelectButtonsView.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/15/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol TypeButtonsViewInput {
    func moduleVisibility(isVisible: Bool)
    func listVisibility(isVisible: Bool)
}

protocol TypeButtonsViewOutput {
    
}

class TypeButtonsView: UIView {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var buttonsList: [UIButton]!
    @IBOutlet var contentView: UIView!
    
    weak var output: TypeButtonsViewOutput!
    
    let buttonHeight = 50
    lazy var heightConstraint: NSLayoutConstraint = self.contentView.heightAnchor.constraint(equalToConstant: CGFloat(self.buttonHeight))
    
    //for using in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //for using in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TypeButtonsView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        addSubview(contentView)
    }
    
    private func setViewHeight(value: Int) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.heightConstraint.constant = CGFloat(value)
            self.heightConstraint.isActive = true
            self.contentView.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func selectButtonClick(_ sender: UIButton) {
        let height = Int(heightConstraint.constant) == buttonHeight ? buttonHeight * (buttonsList.count + 1) : buttonHeight
        setViewHeight(value: height)
    }
    
    @IBAction func buttonFromListClick(_ sender: UIButton) {
        if let title = sender.currentTitle {
            selectButton.setTitle(title, for: .normal)
        }
        
        setViewHeight(value: buttonHeight)
    }
}

extension TypeButtonsView : TypeButtonsViewInput {
    func moduleVisibility(isVisible: Bool) {
        setViewHeight(value: isVisible ? buttonHeight : 0)
    }
    
    func listVisibility(isVisible: Bool) {
        setViewHeight(value: isVisible ? buttonHeight * (buttonsList.count + 1) : buttonHeight)
    }
}
