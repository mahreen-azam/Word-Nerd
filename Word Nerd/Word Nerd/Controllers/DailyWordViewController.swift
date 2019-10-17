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
        
        // Call randomWord endpoint and update labels to be today's word and definiton. If no word is returned, show an error message
    }
    
   // MARK: Button Functions
    @IBAction func saveWordTapped(_ sender: Any) {
        // Need to pass current word and definition to the next view controller. User should be allowed to select a list. If no lists exist, let them create a new list and afterwards they should be able to save that word into that list if they tap on it. (have global variable that hold the word and definition variables. Once they are succesffully saved into a notebook, clear the variables to be nil.
    }
    
    @IBAction func newWordTapped(_ sender: Any) {
        // Call "randomWord" endpoint. Save word. Call "Search" endpoint for that randomWord. Update UI for word and definition IF a success is returned. Else, show error and do not update UI.
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        // Show an alera (?) that allows the user to enter the word that they want to search.
        //  Call "Search" endpoint for the user's endpoint. Update UI for word and definition IF a success is returned. Else, show error and do not update UI.
    }
    
}



