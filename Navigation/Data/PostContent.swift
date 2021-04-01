//
//  PostContent.swift
//  Navigation
//
//  Created by  Ivan Kamenev on 08.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct PostContent {
    
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
    
}

let posts = [
    PostContent(author: "Ivan Kamenev", description: "Australian Shepherd.Despite their name, the Australian Shepherd dog breed originated in the western United States, not Australia, around the time of the Gold Rush in the 1840s. Originally bred to herd livestock, they remain a working dog at heart. You can find these dogs in shelters and rescues, so opt to adopt if you can! The Aussie, as they’re nicknamed, are happiest when they have a job to do. They can be wonderful family companions if their intelligence and energy are channeled into dog sports or activities.DogTime recommends to your medium-sized Australian Shepherd. You should also to help burn off your pup’s high energy! See below for complete list of dog breed traits and facts about Australian Shepherds!", image: "australian shepherd", likes: 456, views: 789),
    PostContent(author: "Ivan Ivanov", description: "Virabhadra’s Pose is also known as the Warrior Pose", image: "warrior", likes: 234, views: 567),
    PostContent(author: "Tom Tomson", description: "Samurai (侍, /ˈsæmʊraɪ/) were the hereditary military nobility and officer caste of medieval and early-modern Japan from the 12th century to their abolition in the 1870s. They were the well-paid retainers of the daimyo (the great feudal landholders). They had high prestige and special privileges such as wearing two swords. They cultivated the bushido codes of martial virtues, indifference to pain, and unflinching loyalty, engaging in many local battles. During the peaceful Edo era (1603 to 1868) they became the stewards and chamberlains of the daimyo estates, gaining managerial experience and education. In the 1870s samurai families comprised 5% of the population. The Meiji Revolution ended their feudal roles, and they moved into professional and entrepreneurial roles. Their memory and weaponry remain prominent in Japanese popular culture.", image: "samurai", likes: 345, views: 567),
    PostContent(author: "Jack Sparrow", description: "Captain Jack Sparrow is a fictional character and the main protagonist of the Pirates of the Caribbean film series. The character was created by screenwriters Ted Elliott and Terry Rossio and is portrayed by Johnny Depp. The characterization of Sparrow is based on a combination of The Rolling Stones' guitarist Keith Richards and Looney Tunes cartoon character Pepé Le Pew. ", image: "jacksparrow", likes: 890, views: 1098)
]
