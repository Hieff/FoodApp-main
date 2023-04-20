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
    
    @IBOutlet weak var suggestionOne: UIImageView!
    
    @IBOutlet weak var suggestionTwo: UIImageView!
    
    
    let mealManager: FetchedMealManager = FetchedMealManager()
    let fatSecretManager: FatSecretManager = FatSecretManager()
    var sendingRecipe: MealDb.Meals? = nil
    var suggestions = [MealDb.Meals]()

    
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
        if(mealManager.listOfMeals.count != 0){
            getSuggestions()
        }
       
    }
    
    @objc func onSearch() {
        performSegue(withIdentifier: "SearchScene", sender: self);
    }
    
    @objc func sendOne(){
        sendingRecipe = suggestions[0]
        print("working")
        performSegue(withIdentifier: "mainToRecipe", sender: nil)
    }
    
    @objc func sendTwo(){
        sendingRecipe = suggestions[1]
        performSegue(withIdentifier: "mainToRecipe", sender: nil)
    }
    
    
    func getSuggestions(){
        let reviewedRecipes = (UserDefaults.standard.array(forKey: "reviews") ?? [""]) as! [String]
        let recipeRatings = (UserDefaults.standard.array(forKey: "ratings") ?? [""]) as! [String]
        print(reviewedRecipes)
        print(recipeRatings)
        suggestions = [MealDb.Meals]()
        let alphabet = "qwertyuioplkjhgfdsazxcvbnm"
        if reviewedRecipes[0] == "" {
            let letter = "\(String(describing: alphabet.randomElement()!))"
            let randomSearch = mealManager.getMealsBySearch(name: letter)
            if randomSearch.count != 0 {
                suggestions.append(randomSearch.randomElement()!)
                suggestions.append(randomSearch.randomElement()!)
            }
        } else {
            var counter = 0
            var biggestRating = 0
            var location = 0
            for x in recipeRatings {
                if Int(x) ?? 0 >= biggestRating {
                    location = counter
                }
                counter += 1
            }
            var category = ""
            for (_, meal) in (mealManager.listOfMeals) {
                if meal.strMeal == reviewedRecipes[location] {
                    category = meal.strArea
                }
            }
            
            for (_, meal) in (mealManager.listOfMeals){
                if meal.strArea == category{
                    suggestions.append(meal)
                }
            }
            
            var randomSuggestions = [MealDb.Meals]()
            randomSuggestions.append(suggestions.randomElement()!)
            randomSuggestions.append(suggestions.randomElement()!)
            suggestions = randomSuggestions
            
        }
        
        if suggestions.count != 0 {
            ImageFinder().fetch(suggestions[0].strMealThumb!) { img in
                DispatchQueue.main.async {
                    self.suggestionOne.image = img;
                }
            }
            ImageFinder().fetch(suggestions[1].strMealThumb!) { img in
                DispatchQueue.main.async {
                    self.suggestionTwo.image = img;
                }
            }
        }
            
        suggestionOne.isUserInteractionEnabled = true
        suggestionTwo.isUserInteractionEnabled = true
        suggestionOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendOne)))
        suggestionTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendTwo)))
    }
    
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    
    
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
        
        if segue.identifier == "mainToRecipe"{
            let recipeSearchController = segue.destination as? RecipeViewController
            recipeSearchController?.selectedRecipe = sendingRecipe
        }
    }
}

