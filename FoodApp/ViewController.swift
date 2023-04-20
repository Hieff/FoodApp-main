//
//  ViewController.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 06/03/2023.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var searchBarField: UITextField!
    
    @IBOutlet weak var recentImage: UIImageView!
    @IBOutlet weak var recentText: UILabel!
    
    
    
    
    let mealManager: FetchedMealManager = FetchedMealManager()
    let fatSecretManager: FatSecretManager = FatSecretManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBarField.addTarget(self, action: #selector(onSearch), for: .editingDidEndOnExit)

        
      
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let imageToShow = UserDefaults.standard.string(forKey: "recentImage") ?? ""
        let imageName = UserDefaults.standard.string(forKey: "recentName") ?? ""
        if(imageName != ""){
            recentText.text = imageName
            if imageToShow != ""  {
                print("finding")
                ImageFinder().fetch(imageToShow) { img in
                    DispatchQueue.main.async {
                        self.recentImage.image = img;
                    }
                }
            }
        }
    }
    
    @objc func onSearch() {
        performSegue(withIdentifier: "SearchScene", sender: self);
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        weak var pvc = self.presentingViewController
        let title = item.title!
        switch(title) {
            case "Search":
                let vc = storyboard!.instantiateViewController(withIdentifier: "SearchController")
                vc.modalPresentationStyle = .fullScreen
                let controller = vc as! SearchTableViewController
                controller.mealManager = mealManager
                controller.searchInput = ""
                controller.searchType = .recipe
                controller.homeController = self
                self.present(vc, animated: true)
            
            case "Calendar":
                let vc = storyboard!.instantiateViewController(withIdentifier: "CalenderController")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            
            case "Basket":
                let vc = storyboard!.instantiateViewController(withIdentifier: "BasketController")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            
            default: break;
        }
    }
    
    @IBAction func toIngredientSearchFunction(_ sender: Any) {
        performSegue(withIdentifier: "toIngredientSearch", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchScene" {
            let sceneSearchView = segue.destination as? SearchTableViewController
            sceneSearchView?.searchInput = searchBarField.text!
            sceneSearchView?.mealManager = self.mealManager
            sceneSearchView?.homeController = self
            sceneSearchView?.searchType = .recipe
        }
        
        if segue.identifier == "toIngredientSearch"{
            let ingredientSearchController = segue.destination as? IngredientSearchViewController
            ingredientSearchController?.mealManager = self.mealManager
        }
    }
}

