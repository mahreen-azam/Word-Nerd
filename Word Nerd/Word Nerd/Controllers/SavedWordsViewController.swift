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
    @IBOutlet weak var tableView: UITableView!   // Make these fields large enough to display defintion. If not, when you tap on it it should show you the whole definition. I perfer it all be on one vc. 
    
    // MARK: Global Variables
    var savedWords = ["Hello", "Mom"] // There needs to be a fetch call made to get all the words for a list. The words passed from the last vc can only be appended after this fetch has been made. We'll probably have to update the code to add them 
    var savedDefintions = ["A greeting", "Female parent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    //MARK: Delete Saved Words Functions
    func deleteSavedWords(at indexPath: IndexPath) {
        self.savedWords.remove(at: indexPath.row)
        self.savedDefintions.remove(at: indexPath.row)
        self.tableView.reloadData()
        //        let notebookToDelete = fetchedResultsController.object(at: indexPath)
        //        dataController.viewContext.delete(notebookToDelete)
        //        try? dataController.viewContext.save()
    }
    
    // Make the table not tappable. (Remove the arrow too) Add functionality for Quiz me. Update quize me button. Make the words be based off of the tapped list. Add core data and persistance. 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsCell")!
        
 //       cell.textLabel?.text = savedWords[indexPath.row]
//        cell.detailTextLabel?.text = savedDefintions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsCell2", for: indexPath) as! SavedWordsTableViewCell
        cell.wordLabel.text = savedWords[indexPath.row]
        cell.definitionLabel.text = savedDefintions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteSavedWords(at: indexPath)
        default: ()
        }
    }
}

//Bonus Feature: add an "Add" button that allows the user to manually save a word and defintion to the list 
