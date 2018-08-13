//
//  Error.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/13/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case mediaParsing
    case requestError
    
    func errorDesctiption() -> String {
        switch self {
        case .mediaParsing:
            return "Problems with Media response content"
        case .requestError:
            return "Problems during network request"
        }
    }
}
