//
//  CalendarViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 18/04/2023.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var calendarTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        calendarTable.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "calendarCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as! CalendarTableViewCell
        let time = indexPath.row * 30
        let hour = time / 60
        let minute = time % 60
        cell.timeText.text = String(hour) + ":" + String(minute)
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
