//
//  TabBarContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/2/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol TabBarViewInput : BaseViewInput {
    var viewControllers: [UIViewController]? { get set }
}

protocol TabBarViewOutput : BaseViewOutput {

}

protocol TabBarInteractorInput : BaseInteractorInput {
    
}

protocol TabBarInteractorOutput : BaseInteractorOutput {

}

protocol TabBarRouterInput : BaseRouterInput {

}
