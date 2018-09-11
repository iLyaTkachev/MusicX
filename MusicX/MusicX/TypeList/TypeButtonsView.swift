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
    func getView() -> UIView
    func setType(type: MediaType)
    func setOutput(output: TypeButtonsViewOutput)
}

protocol TypeButtonsViewOutput: class {
    func typeSelected(type: MediaType)
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
        setButtonsHeight()
        addSubview(contentView)
    }
    
    private func setViewHeight(value: Int) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.heightConstraint.constant = CGFloat(value)
            self.heightConstraint.isActive = true
            self.contentView.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setButtonsHeight() {
        selectButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight))
        buttonsList.forEach {
            $0.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight))
        }
    }
    
    @IBAction func selectButtonClick(_ sender: UIButton) {
        let height = Int(heightConstraint.constant) == buttonHeight ? buttonHeight * (buttonsList.count + 1) : buttonHeight
        setViewHeight(value: height)
    }
    
    @IBAction func buttonFromListClick(_ sender: UIButton) {
        if let title = sender.currentTitle,
            selectButton.currentTitle != sender.currentTitle,
            let accessibilityLabel = sender.accessibilityLabel,
            let type = MediaType(rawValue: accessibilityLabel) {
            selectButton.setTitle(title, for: .normal)
            output.typeSelected(type: type)
        }
        setViewHeight(value: buttonHeight)
    }
}

extension TypeButtonsView: TypeButtonsViewInput {
    func setOutput(output: TypeButtonsViewOutput) {
        self.output = output
    }
    
    func setType(type: MediaType) {
        for button in buttonsList where button.accessibilityLabel == type.rawValue {
            selectButton.setTitle(button.currentTitle, for: .normal)
            break
        }
    }
    
    func getView() -> UIView {
        return self.contentView
    }
    
    func moduleVisibility(isVisible: Bool) {
        setViewHeight(value: isVisible ? buttonHeight : 0)
    }
    
    func listVisibility(isVisible: Bool) {
        setViewHeight(value: isVisible ? buttonHeight * (buttonsList.count + 1) : buttonHeight)
    }
}
