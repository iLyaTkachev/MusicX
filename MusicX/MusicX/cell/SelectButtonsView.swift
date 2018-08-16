//
//  SelectButtonsView.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/15/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol SelectButtonsViewInput {
    func moduleVisibility(isVisible: Bool)
    func listVisibility(isVisible: Bool)
}

protocol SelectButtonsViewOutput {
    
}

class SelectButtonsView: UIView {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var buttonsList: [UIButton]!

    @IBOutlet var contentView: UIView!
    
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
        Bundle.main.loadNibNamed("SelectButtonsView", owner: self, options: nil)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    @IBAction func selectButtonClick(_ sender: UIButton) {
        guard buttonsList.isEmpty else {
            listVisibility(isVisible: !buttonsList[0].isHidden)
            return
        }
    }
    
    @IBAction func buttonFromListClick(_ sender: UIButton) {
        if let title = sender.currentTitle {
            selectButton.setTitle(title, for: .normal)
        }
        
        listVisibility(isVisible: false)
    }
}

extension SelectButtonsView : SelectButtonsViewInput {
    func moduleVisibility(isVisible: Bool) {
        listVisibility(isVisible: isVisible)
        setVisibility(button: selectButton, isVisible: false)
    }
    
    func listVisibility(isVisible: Bool) {
        listVisibility(list: buttonsList, isVisible: isVisible)
    }
    
    private func listVisibility(list: [UIButton], isVisible: Bool) {
        list.forEach { (button) in
            setVisibility(button: button, isVisible: isVisible)
        }
    }
    
    private func setVisibility(button: UIButton, isVisible: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            button.isHidden = !isVisible
            self.layoutIfNeeded()
        })
    }
}

extension SelectButtonsView : SelectButtonsViewOutput {
    
}
