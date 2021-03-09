//
//  MovieTableViewCell.swift
//  TableViewYoutubeRnd
//
//  Created by 정정이 on 2021/03/02.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNumMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var labelChanelMovie: UILabel!
    @IBOutlet weak var labelSubMovie: UILabel!
    @IBOutlet weak var labelViewsMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
