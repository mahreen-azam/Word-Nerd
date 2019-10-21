//
//  SavedWordsViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/20/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit

class SavedWordsViewController: UIViewController, UITableViewDataSource {
    
    //MARK: Outlets
    
    // MARK: Global Variables
    var savedWords = ["Hello", "Mom"] // There needs to be a fetch call made to get all the words for a list. The words passed from the last vc can only be appended after this fetch has been made. We'll probably have to update the code to add them 
    var savedDefintions = ["A greeting", "Female parent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Make the table not tappable. (Remove the arrow too) Add functionality for Quiz me. Update quize me button. Make the words be based off of the tapped list. Add core data and persistance. 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsCell")!
        
        cell.textLabel?.text = savedWords[indexPath.row]
        cell.detailTextLabel?.text = savedDefintions[indexPath.row]
        
        return cell
    }
}

//Bonus Feature: add an "Add" button that allows the user to manually save a word and defintion to the list 
