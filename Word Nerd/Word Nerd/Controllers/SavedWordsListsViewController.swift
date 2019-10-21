//
//  SavedWordsListsViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/20/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit

class SavedWordsListsViewController: UIViewController, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Global Variables
    var wordToSave:String?
    var definitionToSave:String?
    var savedWords = ["Hello", "Mom", "Dad"]
    var savedDefintions = ["A greeting", "Female parent", "Male parent"]
    var savedLists:[String] = [] // This needs to be filled in based on the fetch request that was made
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make a fetch call and see if there are any existing lists. If there are, populate the fields with them, if not, pop the add list alert (?)
        
        //Add an instructions label (?) If there is a wordToSave/defintion: "Tap on a list to save the word and defintion" else "Tap on a list to see saved words
    }
    
    // MARK: Button Functions
    @IBAction func addList(_ sender: Any) {
        print("Add pressed")
        presentAddListAlert()
    }
    
    // MARK: Add List Functions
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
    
    // Adds a new notebook to the end of the `notebooks` array
    func addList(name: String) {
        self.savedLists.append(name)
        self.tableView.reloadData()
       //  let notebook = Notebook(context: dataController.viewContext)
       //  notebook.name = name
        // notebook.creationDate = Date()
        // try? dataController.viewContext.save()
    }
    
    // MARK: Helper Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let savedWordsVC = segue.destination as! SavedWordsViewController
        if (wordToSave != nil) && (definitionToSave != nil) {
            savedWordsVC.savedWords.append(wordToSave!)
            savedWordsVC.savedDefintions.append(definitionToSave!)
        }
    }
    
    // MARK: Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return savedWords.count
        return savedLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsListsCell")!
        
        cell.textLabel?.text = savedLists[indexPath.row]
       // cell.detailTextLabel?.text = savedDefintions[indexPath.row] // This should be the number of saved words assoicated with this list (?)
        
        return cell
    }
}
