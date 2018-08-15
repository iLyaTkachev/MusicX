//
//  SelectButtonsView.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/15/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class SelectButtonsView: UIView {
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var listButtons: [UIButton]!
}

/*extension SelectButtonsView : SelectButtonsViewInput {
    func hideAll() {
        setVisibility(isVisible: false)
    }
    
    func hideList() {
        setVisibility(isVisible: false)
        listButtons[0].isHidden = false
    }
    
    private func setVisibility(button: UIButton, isVisible: Bool) {
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !isVisible
                self.layoutIfNeeded()
        }
    }
    
}*/

extension SelectButtonsView : SelectButtonsViewOutput {
    
}

protocol SelectButtonsViewInput {
    func hideAll()
    func hideList()
}

protocol SelectButtonsViewOutput {
    
}
