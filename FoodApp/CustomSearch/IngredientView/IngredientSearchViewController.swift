//
//  IngredientSearchViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 19/04/2023.
//

import UIKit

class IngredientSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var ingredientSearchTable: UITableView!
    var inputtedIngredients = [String]()
    var mealManager: FetchedMealManager? = nil
    var sendSearch = [MealDb.Meals]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inputtedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientSearchTable.dequeueReusableCell(withIdentifier: "ingredientSearchCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = inputtedIngredients[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        inputtedIngredients.remove(at: indexPath.row)
        ingredientSearchTable.reloadData()
    }
    
    @objc func addItem(){
        let inputtedText = inputField.text ?? ""
        if(inputtedText != ""){
            inputtedIngredients.append(inputtedText)
            ingredientSearchTable.reloadData()
        }
    }
    
    
    func findMatches() -> [(MealDb.Meals, Int)]{
        var mealMatches = [(MealDb.Meals, Int)]()
        for (_, meal) in (mealManager?.listOfMeals ?? [:]) {
            let mealIngredients = meal.getIngredients()
            var matchCounter = 0
            for x in mealIngredients{
                if inputtedIngredients.contains(x){
                    matchCounter += 1
                }
            }
            if matchCounter > 0 {
                mealMatches.append((meal, matchCounter))
            }
        }
        
        return mealMatches
    }
    
    
    func filterMatches(input: [(MealDb.Meals, Int)]) -> [MealDb.Meals]{
        var meals = [MealDb.Meals]()
        let sortedTuples = input.sorted(by: {$0.1 > $1.1})
        for (meal,_) in sortedTuples{
            meals.append(meal)
        }
        return meals
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        inputField.addTarget(self, action:#selector(addItem) , for: .editingDidEndOnExit)
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        inputtedIngredients = []
        ingredientSearchTable.reloadData()
    }
    
    
    @IBAction func searchFunction(_ sender: Any) {
        let matches = findMatches()
        let ordered = filterMatches(input: matches)
        sendSearch = ordered
        if sendSearch.count != 0 {
            performSegue(withIdentifier: "ingredientSearchToSearch", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        weak var pvc = self.presentingViewController
        if segue.identifier == "ingredientSearchToSearch"{
            let searchViewController = segue.destination as! SearchTableViewController
            searchViewController.mealManager = FetchedMealManager()
            searchViewController.searchType = .ingredient
            searchViewController.searchedMeals = sendSearch
            searchViewController.searchInput = ""
            
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
