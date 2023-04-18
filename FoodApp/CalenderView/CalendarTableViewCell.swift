//
//  CalendarTableViewCell.swift
//  FoodApp
//
//  Created by Hough, Dylan on 18/04/2023.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var informationText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
