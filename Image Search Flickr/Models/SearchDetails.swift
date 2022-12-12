//
//  SearchDetails.swift
//  Image Search Flickr
//
//  Created by Haresh Ghatala on 2022/12/12.
//

public struct SearchDetails: Codable {
    
    public let photos: PhotoDetails?
    public let stat: String?
    
}

extension SearchDetails: Equatable {
    
    public static func ==(lhs: SearchDetails, rhs: SearchDetails) -> Bool {
        return lhs.photos == rhs.photos &&
        lhs.stat == rhs.stat
    }
    
}
