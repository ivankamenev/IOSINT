//
//  Checker.swift
//  Navigation
//
//  Created by Ivan Kamenev on 06.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct Checker {
    static let shared = Checker()
    let login = "Ivan"
    let password = "Kamenev"
    
    private init() {
        
    }
    
    func check(userLogin: String?, userPass: String?) -> Bool {
        if userLogin == login || userPass == password {
            return true
        }
        return false
    }
}
