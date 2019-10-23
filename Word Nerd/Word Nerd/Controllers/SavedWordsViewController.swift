//
//  SavedWordsViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/20/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit
import CoreData

class SavedWordsViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Global Variables
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<Word>!
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! 
    
    // MARK: Global Variables
    var savedWords = ["Hello", "Mom"] // There needs to be a fetch call made to get all the words for a list. The words passed from the last vc can only be appended after this fetch has been made. We'll probably have to update the code to add them 
    var savedDefintions = ["A greeting", "Female parent"]
    
    // var savedWords2: String! // In our last VC, could we have updated the list to have a word associated with it?
    
    
    fileprivate func setupFetchedResultsController() { // Update this to be all the words associated with this list!
        let fetchRequest:NSFetchRequest<Word> = Word.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "")
        do {
            try fetchedResultsController.performFetch()
            print("yay")
        } catch {
            self.showFailure(title: "Failed to get saved lists", message: error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchedResultsController()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    func addSavedWords() {
        let word = Word(context: dataController.viewContext)
        word.name = "name"
        word.definition = "def" // current word from before
        try? dataController.viewContext.save()
        
        setupFetchedResultsController()
        self.tableView.reloadData()
    }
    
    //MARK: Delete Saved Words Functions
    func deleteSavedWords(at indexPath: IndexPath) {
        self.savedWords.remove(at: indexPath.row)
        self.savedDefintions.remove(at: indexPath.row)
        self.tableView.reloadData()
        
        
        let wordToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(wordToDelete)
        try? dataController.viewContext.save()
        
        setupFetchedResultsController()
        self.tableView.reloadData()
    }
    
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    // Make the table not tappable. (Remove the arrow too) Add functionality for Quiz me. Update quize me button. Make the words be based off of the tapped list. Add core data and persistance. 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsCell", for: indexPath) as! SavedWordsTableViewCell
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
