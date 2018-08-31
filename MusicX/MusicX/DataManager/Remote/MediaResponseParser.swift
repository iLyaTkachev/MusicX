//
//  ResponseConverter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseMediaResponseParser {
    func parseMedia(type: MediaType, data: Data) -> [BaseMediaObject]?
}

class MediaResponseParser: BaseMediaResponseParser {
    
    private let mediaBuilder: BaseMediaBuilder = MediaBuilder()
    
    func parseMedia(type: MediaType, data: Data) -> [BaseMediaObject]? {
        return parse(type: type, data: data)
    }
    
    
    private func parse(type: MediaType, data: Data) -> [BaseMediaObject]? {
        
        guard let dict = dictionary[type.chartArray()] as? [String : Any] ,
            let array = dict[type.rawValue] as? [Any] else {
            print("Dictionary does not contain \(type.rawValue) key\n")
            return nil
        }
        
        var result: [BaseMediaObject] = []
        
        for mediaDictionary in array {
            if let mediaDictionary = mediaDictionary as? [String : Any],
                let media = mediaBuilder.build(type: type, from: mediaDictionary) {
                result.append(media)
            } else {
                print("Problem parsing \(type.rawValue) dictionary\n")
            }
        }
        
        return result
    }
}
