//
//  TaskTableViewCell.swift
//  Noted
//
//  Created by Odirile Kekana on 2021/09/08.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkBtnTapped(_ sender: Any) {
    }
    
}
