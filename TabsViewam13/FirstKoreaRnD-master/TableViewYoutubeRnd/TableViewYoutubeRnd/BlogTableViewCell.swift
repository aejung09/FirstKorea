//
//  BlogTableViewCell.swift
//  TableViewYoutubeRnd
//
//  Created by 정정이 on 2021/03/02.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    @IBOutlet weak var labelBolgNum: UILabel!
    @IBOutlet weak var imgBlog: UIImageView!
    @IBOutlet weak var labelChanelBlog: UILabel!
    @IBOutlet weak var labelSubBlog: UILabel!
    @IBOutlet weak var labelViewsBlog: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
