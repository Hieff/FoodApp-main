//
//  ViewController.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 06/03/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBarField: UITextField!
    
    let mealManager: FetchedMealManager = FetchedMealManager()
    let fatSecretManager: FatSecretManager = FatSecretManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBarField.addTarget(self, action: #selector(onSearch), for: .editingDidEndOnExit)
    }
    
    @objc func onSearch() {
        performSegue(withIdentifier: "SearchScene", sender: self);
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchScene" {
            let sceneSearchView = segue.destination as? SearchTableViewController
            sceneSearchView?.searchInput = searchBarField.text!
            sceneSearchView?.mealManager = self.mealManager
        }
    }
}

