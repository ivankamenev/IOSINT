//
//  AppConfiguration.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 02.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

enum AppConfiguration {
    case people(people: URL)
    case starships(starsip: URL)
    case planets(planet: URL)
    
    static func random(people: URL, starships: URL, planet: URL) -> AppConfiguration {
        let all: [AppConfiguration] = [.people(people: people),
                                       .starships(starsip: starships),
                                       .planets(planet: planet)]
        let randomIndex = Int(arc4random()) % all.count
        return all[randomIndex]
    }
}
