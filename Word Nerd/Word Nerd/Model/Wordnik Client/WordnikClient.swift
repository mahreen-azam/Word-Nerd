//
//  File.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/16/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import Foundation

class WordnikClient {
    
    //MARK: Global Variables
    static let apiKey = ""  // Update this to have api key!!!!
    
    enum Endpoints {
        static let base = "https://api.wordnik.com/"
        
        case wordOfTheDay
        case randomWord
        case search
        
        var stringValue: String {  
            switch self {
            case .wordOfTheDay: return Endpoints.base + "v4/words.json/wordOfTheDay?api_key=" + apiKey
            case .randomWord: return Endpoints.base + "v4/words.json/randomWord?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1&api_key=" + apiKey
            case .search: return Endpoints.base + "v4/words.json/search/" + "*** ADD QUERIED WORD HERE ***" + "?allowRegex=false&caseSensitive=true&minCorpusCount=5&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=1&maxLength=-1&limit=10&api_key=" + apiKey   // This one isn't working right now, try the merriam webster one if it stays broken for long
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}
