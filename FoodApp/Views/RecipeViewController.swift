//
//  RecipeViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 17/04/2023.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var selectedRecipe: MealDb.Meals? = nil
    var reviews = UserDefaults.standard.array(forKey: "reviews") ?? []
    var reviewRatings = UserDefaults.standard.array(forKey: "ratings") ?? []
    
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var calorieText: UILabel!
    @IBOutlet weak var instructionText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reviews = UserDefaults.standard.array(forKey: "reviews") ?? []
        reviewRatings = UserDefaults.standard.array(forKey: "ratings") ?? []
        print(reviews); print(reviewRatings)
        
        buidReviewButton()
        titleText.text = selectedRecipe?.strMeal ?? "no title"
        instructionText.text = selectedRecipe?.strInstructions ?? "no instruction"

        if let imgSource = selectedRecipe?.strMealThumb {
            ImageFinder().fetch(imgSource) { img in
                DispatchQueue.main.async {
                    self.recipeImage.image = img;
                }
            }
        }
        timeText.text = "Time: ~" + String(selectedRecipe?.cookingTime() ?? 0) + " minutes"
    }

    func buidReviewButton(){
        
        let optionClosure = {(action: UIAction) in
            self.changeReview(newReview: action.title)
            print(action.title)}
        
        ratingButton.menu = UIMenu(children: [
            UIAction(title: "0", handler: optionClosure),
            UIAction(title: "1", handler: optionClosure),
            UIAction(title: "2", handler: optionClosure),
            UIAction(title: "3", handler: optionClosure),
            UIAction(title: "4", handler: optionClosure),
            UIAction(title: "5", handler: optionClosure)])
        
        ratingButton.showsMenuAsPrimaryAction = true
        ratingButton.changesSelectionAsPrimaryAction = true
        
        var currentRating = "0"
        var counter = 0
        
        while (counter < reviews.count){
            let checking = reviews[counter] as! String
            if checking == selectedRecipe?.strMeal{
                currentRating = reviewRatings[counter] as! String
            }
            counter += 1
        }
        ratingButton.setTitle(String(currentRating), for: ratingButton.state)
        
    }
    
    func changeReview(newReview: String){
        var counter = 0
        
        while (counter < reviews.count){
            let checking = reviews[counter] as! String
            if checking == selectedRecipe?.strMeal{
                reviews.remove(at: counter)
                reviewRatings.remove(at: counter)
            }
            counter += 1
        }
        reviews.append(selectedRecipe?.strMeal ?? "")
        reviewRatings.append(newReview)
        print(reviews); print(reviewRatings)
        UserDefaults.standard.set(reviews, forKey: "reviews")
        UserDefaults.standard.set(reviewRatings, forKey: "ratings")
                                  
    }
    
    
    
    @IBAction func addToCalendarButton(_ sender: Any) {
        performSegue(withIdentifier: "toDate", sender: nil)
    }
    
    @IBAction func showIngredientsButton(_ sender: Any) {
        performSegue(withIdentifier: "toIngredients", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toIngredients"){
            let ingredientViewController = segue.destination as! IngredientsViewController
            ingredientViewController.selectedRecipe = selectedRecipe
        }
        if (segue.identifier == "toDate"){
            let dateViewController = segue.destination as! DatePickerViewController
            dateViewController.selectedMeal = selectedRecipe
        }
    }
    

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
