//
//  SecondTableViewCell.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 29.06.22.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    

    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
}
