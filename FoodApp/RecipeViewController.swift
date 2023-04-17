//
//  RecipeViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 17/04/2023.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var selectedRecipe: MealDb.Meals? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleText.text = selectedRecipe?.strMeal ?? "no title"
        instructionText.text = selectedRecipe?.strInstructions ?? "no instruction"
        if(selectedRecipe?.strImageSource != nil){
            recipeImage.loadFrom(URLAddress: (selectedRecipe?.strImageSource)!)
        }
        timeText.text = "Time: " + String(cookingTime()) + " minutes"
    }
    
    func cookingTime() -> Int{
        let instructionsArray = instructionText.text.components(separatedBy: " ")
        print(instructionsArray)
        var timeCounter = 0
        var x = 0
        while x < instructionsArray.count{
            if(instructionsArray[x].lowercased().contains("minutes") || instructionsArray[x].lowercased().contains("mins")){
                print(instructionsArray[x-1])
                timeCounter += Int(instructionsArray[x-1]) ?? 0
            }
            if(instructionsArray[x].lowercased().contains("seconds")){
                print(instructionsArray[x-1])
                timeCounter += (Int(instructionsArray[x-1]) ?? 0) / 60
            }
            if(instructionsArray[x].lowercased().contains("hours")){
                timeCounter += (Int(instructionsArray[x-1]) ?? 0) * 60
            }
            x = x + 1
        }
        return timeCounter
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var calorieText: UILabel!
    @IBOutlet weak var instructionText: UITextView!
    
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIImageView {
    func loadFrom(URLAddress: String) {
        var pic = UIImage()
        if let url = URL(string: URLAddress) {
             let session = URLSession.shared
            session.dataTask(with: url) { (data, response, err) in
                
                do {
                    if let imageData = try? Data(contentsOf: url) {
                        if let loadedImage = UIImage(data: imageData) {
                            pic = loadedImage
                           
                        } else {return}
                    }
                } catch let err {
                    print("Error loading image", err)
                }
                DispatchQueue.main.async(){
                    self.image = pic
                }
                
            }.resume()
        
            
        }
    }
}
