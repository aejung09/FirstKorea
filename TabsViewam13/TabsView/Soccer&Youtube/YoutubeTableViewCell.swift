//
//  YoutubeTableViewCell.swift
//  TabsView
//
//  Created by 정정이 on 2021/03/04.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblYoutubeNum: UILabel!
    @IBOutlet weak var imgYoutube: UIImageView!
    @IBOutlet weak var lblYoutubeSub: UILabel!
    @IBOutlet weak var lblYoutubeChanelName: UILabel!
    @IBOutlet weak var lblYoutubeViews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
