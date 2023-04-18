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
        print(selectedRecipe?.strMealThumb ?? "none")
    
        if let imgSource = selectedRecipe?.strMealThumb {
            print("Image: \(imgSource)")
            ImageFinder().fetch(imgSource) { img in
                DispatchQueue.main.async {
                    self.recipeImage.image = img;
                }
            }
        }
        var time = cookingTime()
        if(time <= 0){
            time = 60
        }
        let updateByFourtyPercent = Double(cookingTime()) * 1.4
        let rounded = updateByFourtyPercent - (updateByFourtyPercent.truncatingRemainder(dividingBy: 1.0))
        timeText.text = "Time: ~" + String(rounded) + " minutes"
    }

    
    // Calculating time it takes to cook the recipe
    func cookingTime() -> Int{
        let instructionsArray = instructionText.text.components(separatedBy: " ")
        var timeCounter = 0
        var x = 0
        while x < instructionsArray.count{
            if(instructionsArray[x].lowercased().contains("minutes") || instructionsArray[x].lowercased().contains("min")){
                print(instructionsArray[x-1])
                if(instructionsArray[x-1].contains("-")){
                    timeCounter += removingDash(input: instructionsArray[x-1])
                } else {
                    timeCounter += Int(instructionsArray[x-1]) ?? 0
                }
            }
            if(instructionsArray[x].lowercased().contains("seconds") || instructionsArray[x].lowercased().contains("sec")){
                print(instructionsArray[x-1])
                if(instructionsArray[x-1].contains("-")){
                    timeCounter += removingDash(input: instructionsArray[x-1])
                } else {
                    timeCounter += (Int(instructionsArray[x-1]) ?? 0) / 60
                }
                
            }
            if(instructionsArray[x].lowercased().contains("hours") || instructionsArray[x].lowercased().contains("hr")){
                print(instructionsArray[x-1])
                if(instructionsArray[x-1].contains("-")){
                    timeCounter += removingDash(input: instructionsArray[x-1])
                } else {
                    timeCounter += (Int(instructionsArray[x-1]) ?? 0) * 60
                }
            }
            x = x + 1
        }
        return timeCounter
    }
    
    func removingDash(input:String) -> Int {
        let number = input.firstIndex(of: "-")!
        var changedString = input[number...]
        changedString.remove(at: changedString.firstIndex(of: "-")!)
        let integer = Int(changedString) ?? 0
        print(integer)
        return integer
        
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
