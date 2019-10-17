//
//  DailyWordViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/16/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit

class DailyWordViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var saveWordButton: UIButton!
    @IBOutlet weak var viewSavedWordsButton: UIButton!
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WordnikClient.getWordOfTheDay(completion: handleWordOfDayResponse(success:error:))
    }
    
   // MARK: Button Functions
    @IBAction func saveWordTapped(_ sender: Any) {
        print("save word tapped")
        // Need to pass current word and definition to the next view controller. User should be allowed to select a list. If no lists exist, let them create a new list and afterwards they should be able to save that word into that list if they tap on it. (have global variable that hold the word and definition variables. Once they are succesffully saved into a notebook, clear the variables to be nil.
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
            // self.setLoggingIn(false)
            if success != nil {
                self.wordLabel.text = success!.word
                self.definitionLabel.text = success!.definitions[0].text
                
            } else {
                self.showFailure(title: "Failed to get Word of the Day", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    // MARK: Error Handlers
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
}


// Extra things to come back to: Make buttons with rounded corners, set up new word button, setup search 



