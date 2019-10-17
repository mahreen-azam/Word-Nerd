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
    static var searchWord = ""
    
    enum Endpoints {
        static let base = "https://api.wordnik.com/"
        
        case wordOfTheDay
        case randomWord
        case search
        
        var stringValue: String {
            switch self {
            case .wordOfTheDay: return Endpoints.base + "v4/words.json/wordOfTheDay?api_key=" + apiKey
            case .randomWord: return Endpoints.base + "v4/words.json/randomWord?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1&api_key=" + apiKey
            case .search: return Endpoints.base + "v4/words.json/search/" + searchWord + "?allowRegex=false&caseSensitive=true&minCorpusCount=5&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=1&maxLength=-1&limit=10&api_key=" + apiKey   // This one isn't working right now, try the merriam webster one if it stays broken for long
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        
        return task
    }
    
    class func getWordOfTheDay(completion: @escaping (WordOfTheDay?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.wordOfTheDay.url, responseType: WordOfTheDay.self){ response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getRandomWord(completion: @escaping (RandomWord?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.randomWord.url, responseType: RandomWord.self){ response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func searchForDefinition(word:String, completion: @escaping (Search?, Error?) -> Void) {
        searchWord.self = word
        taskForGETRequest(url: Endpoints.search.url, responseType: Search.self){ response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
}
