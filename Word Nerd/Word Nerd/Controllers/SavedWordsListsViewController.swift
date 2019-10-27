//
//  SavedWordsListsViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/20/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit
import CoreData

class SavedWordsListsViewController: UIViewController, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var instructions: UILabel!
    
    // MARK: Global Variables
    var wordToSave:String?
    var definitionToSave:String?
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<List>!
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<List> = List.fetchRequest()
        fetchRequest.sortDescriptors = []
        
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
        
        if (wordToSave != nil) && (definitionToSave != nil) {
            self.instructions.text = "   Instructions: Tap on a list to save the word."
        } else {
            self.instructions.text = "   Instructions: Tap on a list to see it's saved words."
        }
        
        if fetchedResultsController.fetchedObjects?.count == 0 {
            presentAddListAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFetchedResultsController()
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wordToSave = nil
        definitionToSave = nil
    }
    
    // MARK: Button Functions
    @IBAction func addList(_ sender: Any) {
        print("Add pressed")
        presentAddListAlert()
    }
    
    // MARK: Add and Delete List Functions
    func presentAddListAlert() {
        let alert = UIAlertController(title: "Add a List", message: "Enter a name for this list", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let name = alert.textFields?.first?.text {
                self?.addList(name: name)
            }
        }
        saveAction.isEnabled = false
        
        // Enables save button after text field has text
        alert.addTextField { textField in
            textField.placeholder = "New List Name"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    func addList(name: String) {
        let list = List(context: dataController.viewContext)
        list.title = name
        try? dataController.viewContext.save()
        
        setupFetchedResultsController()
        self.tableView.reloadData()
    }
    
    func deleteList(at indexPath: IndexPath) {
        let listToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(listToDelete)
        try? dataController.viewContext.save()
        
        setupFetchedResultsController()
        self.tableView.reloadData()
    }
    
    // MARK: Helper Functions
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let savedWordsVC = segue.destination as! SavedWordsViewController
       
        if let indexPath = tableView.indexPathForSelectedRow {
            savedWordsVC.dataController = self.dataController
            
            let listToAddWord = fetchedResultsController.object(at: indexPath)
            savedWordsVC.list = listToAddWord
            
            if (wordToSave != nil) && (definitionToSave != nil) {
                let wordToAdd = Word(context: dataController.viewContext)
                wordToAdd.name = wordToSave!
                wordToAdd.definition = definitionToSave!
                wordToAdd.list = listToAddWord
                try? dataController.viewContext.save()
            }
        }
    }
    
    // MARK: Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsListsCell")!
        let list = fetchedResultsController.object(at: indexPath)

        cell.textLabel?.text = list.title
        if list.words!.count == 1 {
            cell.detailTextLabel?.text =  String(list.words!.count) + " word"
        } else {
            cell.detailTextLabel?.text =  String(list.words!.count) + " words"
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteList(at: indexPath)
        default: ()
        }
    }
}
