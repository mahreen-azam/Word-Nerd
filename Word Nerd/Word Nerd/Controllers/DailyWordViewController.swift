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
    @IBOutlet weak var saveWordButton: UIButton!
    @IBOutlet weak var viewSavedWordsButton: UIButton!
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Global Variables
    var currentWord:String?
    var currentDefintion: String?
    
    // Data Model Variables:
    var dataController: DataController!
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.isHidden = false
        WordnikClient.getWordOfTheDay(completion: handleWordOfDayResponse(success:error:))
    }
    
   // MARK: Button Functions
    @IBAction func saveWordTapped(_ sender: Any) {
        print("save word tapped")

    }
    
    @IBAction func newWordTapped(_ sender: Any) {
        print("new word tapped")
        // Call "randomWord" endpoint. Save word. Call "Search" endpoint for that randomWord. Update UI for word and definition IF a success is returned. Else, show error and do not update UI.
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("search tapped")
        // Show an alert (?) that allows the user to enter the word that they want to search.
        //  Call "Search" endpoint for the user's endpoint. Update UI for word and definition IF a success is returned. Else, show error and do not update UI.
    }
    
    // MARK: Response Handlers
    func handleWordOfDayResponse(success: WordOfTheDay?, error: Error?) {
        
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
            if success != nil {
                self.wordLabel.text = success!.word + ":"
                self.currentWord = success!.word + ":" + "filler"
                self.definitionLabel.text = success!.definitions[0].text
                self.currentDefintion = success!.definitions[0].text + "some filler text to make def longer"
                // Add the word to core data so that it displays old word while loading
                // Maybe this should be in the quick data 
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
            // let savedWordsListsVC = segue.destination as! SavedWordsListsViewController
            if (currentWord != nil) && (currentDefintion != nil) {
                savedWordsListsVC.wordToSave = currentWord!
                savedWordsListsVC.definitionToSave = currentDefintion! 
            }
        }
    }
    
}

// Things to do:
//- Add core data for:
// --- Word of the Day: if a word has been called previously, the app should display that while loading new word
// --- Saved Words Lists: The app should store all lists created. Make a model that associates saved words with lists.
//  If a list is deleted, so are its saved words (pop an alert for this (?))
// --- Saved Words: The app should store saved words.

// Need to make two types of data to store: Lists and Words. Lists have a name. (Possibly a total words count as well, but that might be intuitive) Words have a word and a definition.
//Lists are saved when a user creates one. they are deleted when a user deletes
//Words are saved AFTER a user saves it to a list. They are associated with that list. They are deleted when a user deletes them from their list OR when the list is deleted.
//Need to make fetch requests that creates arrays with the stored data. This data is what the tables use to display data. Remember to refresh table views after something is added or deleted.  



// - Add functionality for: new word, search, quiz me (?)., for new word: have an option difficulty (?),
// Make buttons and text pretty :)






// Get someone to look at your table constraints (?)
