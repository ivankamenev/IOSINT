//
//  User.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 28.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var login: String
    var password: String
    
    init(id: String, login: String, password: String) {
        self.id = id
        self.login = login
        self.password = password
    }
}
