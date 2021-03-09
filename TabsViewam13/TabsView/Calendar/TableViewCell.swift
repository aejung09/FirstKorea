//
//  TableViewCell.swift
//  TabsView
//
//  Created by Derrick on 2021/03/04.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var beforeTime: UILabel!
    
    @IBOutlet weak var afterTime: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var hiddenSno: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
