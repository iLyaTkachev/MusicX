//
//  TestCellView.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/16/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class TestCellView: UIView {

    @IBOutlet weak var button: UIButton!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        */
        
        Bundle.main.loadNibNamed("testCell", owner: self, options: nil)
        print("frame: \(self.frame)")
        print("bounds: \(bounds)")
        contentView.frame = frame
        //contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        print("frame: \(self.frame)")
        print("bounds: \(bounds)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init decoder called")
    }

}
