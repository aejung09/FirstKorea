//
//  TableViewCell.swift
//  TableViewYoutubeRnd
//
//  Created by 정정이 on 2021/03/01.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelNum: UILabel!
    @IBOutlet weak var labelChanel: UILabel!
    
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var labelSub: UILabel!
    @IBOutlet weak var labelViews: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
