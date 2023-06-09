//
//  IngredientsViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 18/04/2023.
//

import UIKit

class IngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedRecipe: MealDb.Meals? = nil
    var ingredientsList = [String]()
    var measurementList = [String]()
    
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let measurement1 = selectedRecipe?.strMeasure1 ?? "none"
        let measurement2 = selectedRecipe?.strMeasure2 ?? "none"
        let measurement3 = selectedRecipe?.strMeasure3 ?? "none"
        let measurement4 = selectedRecipe?.strMeasure4 ?? "none"
        let measurement5 = selectedRecipe?.strMeasure5 ?? "none"
        let measurement6 = selectedRecipe?.strMeasure6 ?? "none"
        let measurement7 = selectedRecipe?.strMeasure7 ?? "none"
        let measurement8 = selectedRecipe?.strMeasure8 ?? "none"
        let measurement9 = selectedRecipe?.strMeasure9 ?? "none"
        let measurement10 = selectedRecipe?.strMeasure10 ?? "none"
        let measurement11 = selectedRecipe?.strMeasure11 ?? "none"
        let measurement12 = selectedRecipe?.strMeasure12 ?? "none"
        let measurement13 = selectedRecipe?.strMeasure13 ?? "none"
        let measurement14 = selectedRecipe?.strMeasure14 ?? "none"
        let measurement15 = selectedRecipe?.strMeasure15 ?? "none"
        let measurement16 = selectedRecipe?.strMeasure16 ?? "none"
        let measurement17 = selectedRecipe?.strMeasure17 ?? "none"
        let measurement18 = selectedRecipe?.strMeasure18 ?? "none"
        let measurement19 = selectedRecipe?.strMeasure19 ?? "none"
        let measurement20 = selectedRecipe?.strMeasure20 ?? "none"
        let tempMeasurements = [measurement1,measurement2,measurement3,measurement4,measurement5,measurement6,measurement7,measurement8,measurement9,measurement10,measurement11,measurement12,measurement13,measurement14,measurement15,measurement16,measurement17,measurement18,measurement19
        ,measurement20]
        ingredientsList = selectedRecipe?.getIngredients() ?? [""]
        measurementList = filterNils(list: tempMeasurements)
        
        
        // Do any additional setup after loading the view.
    }
    

    func filterNils(list: [String]) -> [String]{
        var newList = [String]()
        for x in list {
            if x == "none" || x == ""{
            } else {
                newList.append(String(x))
            }
        }
        return newList
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = measurementList[indexPath.row] as String + " " + ingredientsList[indexPath.row] as String
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    @IBAction func addToBasketButton(_ sender: Any) {
        var basket = UserDefaults.standard.array(forKey: "basket") ?? []
        for x in ingredientsList{
                basket.append(x)
        }
        UserDefaults.standard.set(basket, forKey: "basket")
        
        notificationImage.image = UIImage(systemName: "basket.fill")
        notificationImage.tintColor = UIColor.green
        notificationText.text = "Added to Basket"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.notificationText.text = ""
            self.notificationImage.image = nil
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
