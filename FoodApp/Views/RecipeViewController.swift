//
//  RecipeViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 17/04/2023.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var selectedRecipe: MealDb.Meals? = nil
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var calorieText: UILabel!
    @IBOutlet weak var instructionText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
