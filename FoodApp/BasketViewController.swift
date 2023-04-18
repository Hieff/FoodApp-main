//
//  BasketViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 18/04/2023.
//

import UIKit

class BasketViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var basket = UserDefaults.standard.array(forKey: "basket") ?? []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = (basket[indexPath.row] as! String)
        cell.contentConfiguration = content
        return cell
    }
    
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

                
            case "Search":
            self.dismiss(animated: false, completion: {
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchController")
                let controller = vc as! SearchTableViewController
                controller.mealManager = FetchedMealManager()
                controller.searchInput = ""
                vc.modalPresentationStyle = .fullScreen
                pvc?.present(vc, animated: true)
            })

            default: break;
        }
    }
    

    @IBOutlet weak var basketTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        basket = UserDefaults.standard.array(forKey: "basket") ?? []
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
