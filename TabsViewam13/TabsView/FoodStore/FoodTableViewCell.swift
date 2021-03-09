//
//  FoodTableViewCell.swift
//  TabsView
//
//  Created by TJ on 2021/03/04.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var ivStoreImage: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblStoreScore: UILabel!
    @IBOutlet weak var lblStoreCategory: UILabel!
    @IBOutlet weak var lblPriceRange: UILabel!
    @IBOutlet weak var lblStoreAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
