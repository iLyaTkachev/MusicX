//
//  TestCellView.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/16/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class TestCellView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var typeButtons: [UIButton]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        */
        
        Bundle.main.loadNibNamed("testCell", owner: self, options: nil)
        contentView.frame = frame
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init decoder called")
    }

    @IBAction func selectButtonClicked(_ sender: UIButton) {
        typeButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.layoutIfNeeded()
            })
        }
    }
}
