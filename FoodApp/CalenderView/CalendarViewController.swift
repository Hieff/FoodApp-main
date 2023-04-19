//
//  CalendarViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 18/04/2023.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var calendarTable: UITableView!
    var finishTimes = UserDefaults.standard.array(forKey: "finish") ?? []
    var recipeNames = UserDefaults.standard.array(forKey: "recipeName") ?? []
    var startTimes = UserDefaults.standard.array(forKey: "start") ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        calendarTable.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "calendarCell")
        finishTimes = UserDefaults.standard.array(forKey: "finish") ?? []
        recipeNames = UserDefaults.standard.array(forKey: "recipeName") ?? []
        startTimes = UserDefaults.standard.array(forKey: "start") ?? []
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as! CalendarTableViewCell
        let time = indexPath.row * 30
        let hour = time / 60
        let minute = time % 60
        var minuteString = "0"
        var hourString = "0"
        
        if(hour / 10 == 0){
             hourString = "0" + String(hour)
        } else {
             hourString = String(hour)
        }
        if(minute / 10 == 0){
             minuteString = "0" + String(minute)
        } else {
             minuteString = String(minute)
        }
        let cellTime = hourString + ":" + minuteString
        
        var x = 0
        while(x < finishTimes.count){
            if finishTimes[x] as! String == cellTime{
                cell.informationText.text! = recipeNames[x] as! String
            }
            x += 1
        }
        var y = 0
        
        while( y < startTimes.count){
            if startTimes[y] as! String == cellTime{
                cell.informationText.text! = " Start cooking " + (recipeNames[y] as! String)
            }
            y += 1
        }
        
        
        cell.timeText.text = cellTime
        return cell
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        weak var pvc = self.presentingViewController
        let title = item.title!
        switch(title) {
            case "Home":
                self.dismiss(animated: true)
            
            case "Search":
                self.dismiss(animated: false, completion: {
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchController")
                    let controller = vc as! SearchTableViewController
                    controller.mealManager = FetchedMealManager()
                    controller.searchInput = ""
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
