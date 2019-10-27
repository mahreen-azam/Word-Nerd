//
//  DailyWordViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/16/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit
import CoreData

class DailyWordViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Global Variables
    var currentWord:String?
    var currentDefintion: String?
    var newWord: String?
    var dataController: DataController!
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.isHidden = false
        WordnikClient.getWordOfTheDay(completion: handleWordOfDayResponse(success:error:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let hasStoredWord = UserDefaults.standard.value(forKey: "HasSavedWord") { // need to update current word and def because of search response
            if hasStoredWord as! Bool {
                self.wordLabel.text = UserDefaults.standard.value(forKey: "StoredWord") as! String
                self.definitionLabel.text = UserDefaults.standard.value(forKey: "StoredDefinition") as! String
                self.currentWord = UserDefaults.standard.value(forKey: "StoredWord") as! String
                self.currentDefintion = UserDefaults.standard.value(forKey: "StoredDefinition") as! String
            }
        }
    }
    
    @IBAction func newWordTapped(_ sender: Any) {
        loadingIndicator.isHidden = false
        WordnikClient.getRandomWord(completion: handleRandomWordResponse(success:error:))
    }
    
    // MARK: Response Handlers
    func handleWordOfDayResponse(success: WordOfTheDay?, error: Error?) {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
            
            if success != nil {
                self.currentWord = success!.word + ":"
                self.currentDefintion = success!.definitions[0].text
                self.updateUI()
            } else {
                self.showFailure(title: "Failed to get Word of the Day", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func handleRandomWordResponse(success: RandomWord?, error: Error?) {
        DispatchQueue.main.async {
            if success != nil {
                self.newWord = success!.word
                WordnikClient.searchForDefinition(word: success!.word, completion: self.handleSearchResponse(success:error:))
            } else {
                self.loadingIndicator.isHidden = true
                self.showFailure(title: "Failed to get New Word", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func handleSearchResponse(success: [Search]?, error: Error?) {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
            
            if (success != nil) && (success!.count > 0) && (success![0].shortdef.count > 0) {
                self.currentWord = self.newWord! + ":"
                self.currentDefintion = success![0].shortdef[0]
                self.updateUI()
            } else {
                self.showFailure(title: "Failed to find Defintion for New Word", message: "Sorry, the Merriam-Webster dictionary does not have the defintion for: " + self.newWord!)
            }
        }
    }
    
    // MARK: Helper Functions
    func updateUI() {
        UserDefaults.standard.setValue(true, forKey: "HasSavedWord")
        
        self.wordLabel.text = self.currentWord
        UserDefaults.standard.setValue(self.currentWord, forKey: "StoredWord")
        
        self.definitionLabel.text = self.currentDefintion
        UserDefaults.standard.setValue(self.currentDefintion, forKey: "StoredDefinition")
    }
    
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search"{
            print("Navigated to search")
        } else {
            let savedWordsListsVC = segue.destination as! SavedWordsListsViewController
            savedWordsListsVC.dataController = self.dataController
            
            if segue.identifier == "saveToSavedWordsLists" {
                if (currentWord != nil) && (currentDefintion != nil) {
                    savedWordsListsVC.wordToSave = currentWord!
                    savedWordsListsVC.definitionToSave = currentDefintion!
                }
            }
        }
    }
}
