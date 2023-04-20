//
//  SceneTableViewController.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 28/03/2023.
//

import UIKit


class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    var mealManager: FetchedMealManager? = nil
    var homeController: UIViewController?
    
    var selectedMeal: MealDb.Meals? = nil
    var searchInput: String = ""
    var searchType: SearchType = SearchType.recipe
    var searchedMeals = [MealDb.Meals]()
    
    @IBOutlet weak var searchBarField: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var homeItem: UITabBarItem!
    @IBOutlet weak var noSearchResultImg: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        searchBarField.addTarget(self, action: #selector(onSearch), for: .editingDidEndOnExit)
        // Register custom table cell
        searchTable.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func onSearch() {
        searchType = .recipe
        searchInput = searchBarField.text ?? ""
        DispatchQueue.main.async {
            self.searchTable.reloadData()
            self.searchTable.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        }
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchType == .recipe {
            let empty = mealManager!.getMealsBySearch(name: searchInput).count == 0
            if empty {
                noSearchResultImg.isHidden = false
                tableView.isHidden = true
                return 0
            }
            noSearchResultImg.isHidden = true
            tableView.isHidden = false
            return mealManager!.getMealsBySearch(name: searchInput).count
        }
        if searchType == .ingredient {
            if searchedMeals.count == 0 {
                noSearchResultImg.isHidden = false
                tableView.isHidden = true
                return 0
            }
            noSearchResultImg.isHidden = true
            tableView.isHidden = false
            return (searchedMeals.count)
        }
        return 0
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        var meal: MealDb.Meals? = nil
        if searchType == .recipe {
            meal = mealManager!.getMealsBySearch(name: searchInput)[indexPath.row]
        } else {
            meal = searchedMeals[indexPath.row]
        }
        
        cell.titleLabel.text = meal?.strMeal ?? "no meal"
        cell.timeLabel.text = "Time: ~" + String(meal?.cookingTime() ?? 0) + " minutes"
        if let imgSource = meal?.strMealThumb {
            ImageFinder().fetch(imgSource) { img in
                DispatchQueue.main.async {
                    cell.imgView.image = img
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEmpty() {
            return
        }
        if(searchedMeals.count == 0){
            selectedMeal = mealManager!.searchedMeals[indexPath.row]
        } else {
            selectedMeal = searchedMeals[indexPath.row]
        }
        
        performSegue(withIdentifier: "toRecipeDisplay", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRecipeDisplay"){
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedMeal
        }
    }
    
    func isEmpty() -> Bool {
        if searchType == .recipe {
            if let meal = mealManager {
                return meal.getMealsBySearch(name: searchInput).count == 0
            }
        } else {
            return searchedMeals.count == 0
        }
        return false
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        weak var pvc = self.presentingViewController
        let title = item.title!
        switch(title) {
            case "Home":
                self.dismiss(animated: true)
            
            case "Calendar":
                self.dismiss(animated: false, completion: {
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "CalenderController")
                    vc.modalPresentationStyle = .fullScreen
                    pvc?.present(vc, animated: true)
                })

                
            case "Basket":
            self.dismiss(animated: false, completion: {
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "BasketController")
                vc.modalPresentationStyle = .fullScreen
                pvc?.present(vc, animated: true)
            })

            default: break;
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
