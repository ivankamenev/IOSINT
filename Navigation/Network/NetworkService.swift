//
//  NetworkService.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 02.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    private static let session = URLSession.shared
    
    static func dataTask(url: URL) {
        let task = session.dataTask(with: url) {data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            print("allHeadersFields: \(httpResponse.allHeaderFields as! [String: Any])")
            print("statusCode: \(httpResponse.statusCode)")
            print("data: \(String(data: data!, encoding: .utf8))")
        }
        
        task.resume()
    }
}
