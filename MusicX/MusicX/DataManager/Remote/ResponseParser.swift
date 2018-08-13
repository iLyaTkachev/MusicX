//
//  ResponseConverter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/9/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol MediaParser {
    func parseMedia(type: MediaType, dictionary: [String : Any]) -> [BaseMediaObject]?
}

class ResponseParser: MediaParser {
    func parseMedia(type: MediaType, dictionary: [String : Any]) -> [BaseMediaObject]? {
        switch type {
        case .track:
            if let array: [Track] = parse(dictionary: dictionary) {
                return array }
        case .artist:
            if let array: [Artist] = parse(dictionary: dictionary) {
                return array }
        case .tag:
            return nil
        }
        
        return nil
    }
    
    
    private func parse<T: BaseMediaObject>(dictionary: [String : Any]) -> [T]? {
        
        guard let dict = dictionary[T.type.chartArray()] as? [String : Any] ,
            let array = dict[T.type.rawValue] as? [Any] else {
            print("Dictionary does not contain track key\n")
            return nil
        }
        
        var result: [T] = []
        
        for mediaDictionary in array {
            if let mediaDictionary = mediaDictionary as? [String : Any],
                let media = T(with: mediaDictionary) {
                result.append(media)
                //print(media.name + " " + track.listeners)
            } else {
                print("Problem parsing trackDictionary\n")
                
                return nil
            }
        }
        
        return result
    }
}
