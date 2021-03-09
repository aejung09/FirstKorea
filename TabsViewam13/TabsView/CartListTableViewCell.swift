
import UIKit

class CartListTableViewCell: UITableViewCell {
    

    @IBOutlet weak var cartImage: UILabel!
    
    @IBOutlet weak var cartHowmuch: UILabel!
    
    @IBOutlet weak var cartWon: UILabel!
    
    @IBOutlet weak var CartWhat: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
