//
//  SearchViewController.swift
//  Word Nerd
//
//  Created by Mahreen Azam on 10/24/19.
//  Copyright © 2019 Mahreen Azam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets:
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchButton.isEnabled = false
        searchButton.setTitleColor(UIColor.darkGray, for: UIControl.State.disabled)
    }
    
    // MARK: Button Functions:
    @IBAction func tapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSearchButton(_ sender: Any) {
        print("search tapped")
        if let searchEntry = searchField.text {
            WordnikClient.searchForDefinition(word: searchEntry, completion: self.handleSearchResponse(success:error:))
        }
    }
    
    // MARK: Response Handlers
    func handleSearchResponse(success: [Search]?, error: Error?) {
        DispatchQueue.main.async {
            
            if success != nil {
                print("Found word")
//                self.currentWord = self.newWord
//                self.currentDefintion = success![0].shortdef[0]
//                self.updateUI()
            } else {
                self.showFailure(title: "Failed to find Defintion for Searched Word", message: "Sorry, the Merriam-Webster dictionary does not have the defintion for: " + self.searchField.text!)
            }
        }
    }
    
    // MARK: Helper Functions:
    func showFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    
    // MARK: Text Delegate Functions:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.searchField.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as! NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty{
            searchButton.isEnabled = false
            searchButton.setTitleColor(UIColor.darkGray, for: UIControl.State.disabled)
        } else {
            searchButton.isEnabled = true
            searchButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        return true
    }

}


// Call search endpoint and either dismiss and update UI or, show an alert. Need to pass new word and def to daily word vc. 
