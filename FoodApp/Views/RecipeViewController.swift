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
    var currentRating = "0"
    
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
            self.changeReview(newReview: action.discoverabilityTitle!)
            
            
        }
        
        ratingButton.menu = UIMenu(children: [
            UIAction(title: "0 Stars", image: UIImage(named: "star0"), discoverabilityTitle: "0", handler: optionClosure),
            UIAction(title: "1 Stars", image: UIImage(named: "star1"), discoverabilityTitle: "1", handler: optionClosure),
            UIAction(title: "2 Stars", image: UIImage(named: "star2"), discoverabilityTitle: "2", handler: optionClosure),
            UIAction(title: "3 Stars", image: UIImage(named: "star3"), discoverabilityTitle: "3", handler: optionClosure),
            UIAction(title: "4 Stars", image: UIImage(named: "star4"), discoverabilityTitle: "4", handler: optionClosure),
            UIAction(title: "5 Stars", image: UIImage(named: "star5"), discoverabilityTitle: "5", handler: optionClosure)])
        ratingButton.showsMenuAsPrimaryAction = true
        ratingButton.changesSelectionAsPrimaryAction = true
        
        currentRating = "0"
        var counter = 0
        
        while (counter < reviews.count){
            let checking = reviews[counter] as! String
            if checking == selectedRecipe?.strMeal{
                currentRating = reviewRatings[counter] as! String
            }
            counter += 1
        }
        ratingButton.setTitle(String(currentRating), for: ratingButton.state)
        print("star" + currentRating)
        ratingButton.setImage(UIImage(named: ("star" + currentRating)), for: .normal)
        ratingButton.contentMode = .scaleAspectFill
        ratingButton.imageView?.isHidden = false
        
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
        currentRating = newReview
        ratingButton.setImage(UIImage(named: ("star" + currentRating)), for: .normal)
        ratingButton.contentMode = .scaleAspectFill
        reviews.append(selectedRecipe?.strMeal ?? "")
        reviewRatings.append(newReview)
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
