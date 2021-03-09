//
//  GameTableViewCell.swift
//  TableViewYoutubeRnd
//
//  Created by 정정이 on 2021/03/02.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNumGame: UILabel!
    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var labelChanelGame: UILabel!
    @IBOutlet weak var labelSubGame: UILabel!
    @IBOutlet weak var labelViewsGame: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
