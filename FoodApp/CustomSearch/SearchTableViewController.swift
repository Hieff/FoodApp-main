//
//  SceneTableViewController.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 28/03/2023.
//

import UIKit


class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate{
    
    var searchInput: String = ""
    var mealManager: FetchedMealManager? = nil
    var selectedMeal: MealDb.Meals? = nil
    
    @IBOutlet weak var searchBarField: UITextField!
    
    @IBOutlet weak var searchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarField.addTarget(self, action: #selector(onSearch), for: .editingDidEndOnExit)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register custom table cell
        searchTable.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func onSearch() {
        searchInput = searchBarField.text!
        searchTable.reloadData()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let title = item.title
        if(title == "Home"){
            let vc = storyboard!.instantiateViewController(withIdentifier: "HomeController")
            vc.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false)
            self.present(vc, animated: true)
        }
        if(title == "Calendar"){
            let vc = storyboard!.instantiateViewController(withIdentifier: "CalenderController")
            vc.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false)
            self.present(vc, animated: true)
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
        return mealManager!.getMealsBySearch(name: searchInput).count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        let meal = mealManager!.getMealsBySearch(name: searchInput)[indexPath.row]
        
        cell.titleLabel.text = meal.strMeal
        cell.timeLabel.text = "Time: ~" + String(meal.cookingTime()) + " minutes"
        if let imgSource = meal.strMealThumb {
            ImageFinder().fetch(imgSource) { img in
                DispatchQueue.main.async {
                    cell.imgView.image = img
                }
            }
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeal = mealManager!.searchedMeals[indexPath.row]
        performSegue(withIdentifier: "toRecipeDisplay", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRecipeDisplay"){
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedMeal
        }
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    
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
