//
//  DatePickerViewController.swift
//  FoodApp
//
//  Created by Hough, Dylan on 19/04/2023.
//

import UIKit

class DatePickerViewController: UIViewController {

    
    @IBOutlet weak var timePicked: UIDatePicker!
    @IBOutlet weak var guideText: UILabel!
    var selectedMeal: MealDb.Meals? = nil
    var finishTimes = UserDefaults.standard.array(forKey: "finish") ?? []
    var recipeNames = UserDefaults.standard.array(forKey: "recipeName") ?? []
    var startTimes = UserDefaults.standard.array(forKey: "start") ?? []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        finishTimes = UserDefaults.standard.array(forKey: "finish") ?? []
        recipeNames = UserDefaults.standard.array(forKey: "recipeName") ?? []
        startTimes = UserDefaults.standard.array(forKey: "start") ?? []
        
    }
    
    
    
    @IBAction func confirmButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let minuteFormatter = DateFormatter()
        minuteFormatter.dateFormat = "mm"
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH"
        
        let time = timePicked.date
        let cookingTime = selectedMeal?.cookingTime() ?? 0
        let startTime = time.addingTimeInterval((cookingTime * -60))
        print(startTime)
        
        var newStartTime = minuteFormatter.string(from: startTime)
        let roundingCheck = (Int(newStartTime) ?? 0) / 30
        
        print(newStartTime)
        print(roundingCheck)
        if(roundingCheck >= 1){
            newStartTime = "30"
        } else {
            newStartTime = "00"
        }
        let updatedStartTime = hourFormatter.string(from: startTime) + ":" + newStartTime
        
        finishTimes.append(dateFormatter.string(from: time))
        recipeNames.append(selectedMeal?.strMeal ?? "no name")
        startTimes.append(updatedStartTime)
        
        UserDefaults.standard.set(finishTimes, forKey: "finish")
        UserDefaults.standard.set(recipeNames, forKey: "recipeName")
        UserDefaults.standard.set(startTimes, forKey: "start")
        guideText.text = "Time picked"
        
        
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
