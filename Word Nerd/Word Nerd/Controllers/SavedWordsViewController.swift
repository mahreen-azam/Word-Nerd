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
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Global Variables
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<Word>!
    var list:List!
    
    // MARK: Core Data Fetch Request function
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Word> = Word.fetchRequest()
        fetchRequest.sortDescriptors = []
        let predicate: NSPredicate = NSPredicate(format: "list == %@", list)
        fetchRequest.predicate = predicate
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "")
        do {
            try fetchedResultsController.performFetch()
        } catch {
            self.showFailure(title: "Failed to get saved lists", message: error.localizedDescription)
        }
    }
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchedResultsController()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

    //MARK: Delete Saved Words Functions
    func deleteSavedWords(at indexPath: IndexPath) {
        let wordToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(wordToDelete)
        try? dataController.viewContext.save()
        
        setupFetchedResultsController()
        self.tableView.reloadData()
    }
    
    //MARK: Helper Functions
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    //MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsCell", for: indexPath) as! SavedWordsTableViewCell
        let word = fetchedResultsController.object(at: indexPath)

        cell.wordLabel.text = word.name
        cell.definitionLabel.text = word.definition
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteSavedWords(at: indexPath)
        default: ()
        }
    }
}

