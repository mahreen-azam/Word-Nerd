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
    
    // MARK: Outlets    // Delete unused outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel! 
    @IBOutlet weak var saveWordButton: UIButton!
    @IBOutlet weak var viewSavedWordsButton: UIButton!
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Global Variables
    var currentWord:String?
    var currentDefintion: String?
    var dataController: DataController!
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let hasStoredWord = UserDefaults.standard.value(forKey: "HasSavedWord") {
            if hasStoredWord as! Bool {
                self.wordLabel.text = UserDefaults.standard.value(forKey: "StoredWord") as! String
                self.definitionLabel.text = UserDefaults.standard.value(forKey: "StoredDefinition") as! String
            }
        }
        
        loadingIndicator.isHidden = false
        WordnikClient.getWordOfTheDay(completion: handleWordOfDayResponse(success:error:))
    }
    
   // MARK: Button Functions
    @IBAction func saveWordTapped(_ sender: Any) {
        print("save word tapped") // You can probably delete this function

    }
    
    @IBAction func newWordTapped(_ sender: Any) {
        print("new word tapped")  
        // Call "randomWord" endpoint. Save word. Call "Search" endpoint for that randomWord. Update UI for word and definition IF a success is returned. Else, show error and do not update UI.
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("search tapped")
        // Show an alert (?) modal presentation (?) that allows the user to enter the word that they want to search.
        //  Call "Search" endpoint for the user's endpoint. Update UI for word and definition IF a success is returned. Else, show error and do not update UI. Alert: sorry we could not find a defintion for that word
    }
    
    // MARK: Response Handlers
    func handleWordOfDayResponse(success: WordOfTheDay?, error: Error?) {
        
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
            
            if success != nil {
                UserDefaults.standard.setValue(true, forKey: "HasSavedWord")
                
                self.currentWord = success!.word + ":"
                self.wordLabel.text = self.currentWord
                UserDefaults.standard.setValue(self.currentWord, forKey: "StoredWord")
                
                self.currentDefintion = success!.definitions[0].text
                self.definitionLabel.text = self.currentDefintion
                UserDefaults.standard.setValue(self.currentDefintion, forKey: "StoredDefinition")
                
            } else {
                self.showFailure(title: "Failed to get Word of the Day", message: error?.localizedDescription ?? "")
            }
        }
    }
   
    //MARK: Helper Functions
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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

// Things to do:
// - Add functionality for: new word, search, quiz me (?)., for new word: have an option difficulty (?),
// Make buttons and text pretty :)


// Get someone to look at your table constraints (?)
