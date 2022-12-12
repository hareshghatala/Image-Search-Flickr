//
//  URLSession+Handler.swift
//  Image Search Flickr
//
//  Created by Haresh Ghatala on 2022/12/12.
//

import Foundation

extension URLSession {
    
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        })
    }
}
