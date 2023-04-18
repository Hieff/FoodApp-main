//
//  ViewController.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 06/03/2023.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate {

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
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let title = item.title!
        switch(title) {
            case "Home":
                let vc = storyboard!.instantiateViewController(withIdentifier: "HomeController")
                vc.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true)
                self.present(vc, animated: true)
            
            case "Search":
                let vc = storyboard!.instantiateViewController(withIdentifier: "SearchController")
                vc.modalPresentationStyle = .fullScreen
                let controller = vc as! SearchTableViewController
                controller.mealManager = mealManager
                controller.searchInput = ""
                self.dismiss(animated: true)
                self.present(vc, animated: true)
            
            case "Calendar":
                let vc = storyboard!.instantiateViewController(withIdentifier: "CalendarController")
                vc.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true)
                self.present(vc, animated: true)
            case "Basket":
                let vc = storyboard!.instantiateViewController(withIdentifier: "BasketController")
                vc.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true)
                self.present(vc, animated: true)
            
            default: break;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchScene" {
            let sceneSearchView = segue.destination as? SearchTableViewController
            sceneSearchView?.searchInput = searchBarField.text!
            sceneSearchView?.mealManager = self.mealManager
            sceneSearchView?.homeController = self
        }
    }
}

