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
    
    // MARK: Global Variables
    var savedWords = ["Hello", "Mom", "Dad"]
    var savedDefintions = ["A greeting", "Female parent", "Male parent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsListCell")!
        
        cell.textLabel?.text = savedWords[indexPath.row]
        cell.detailTextLabel?.text = savedDefintions[indexPath.row]
        
        return cell
    }
}
