//
//  WordOfTheDay.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/16/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import Foundation

struct WordOfTheDay: Codable {
    let word: String
    let definitions: [Definitions]
}

struct Definitions: Codable {
    let text: String
}

