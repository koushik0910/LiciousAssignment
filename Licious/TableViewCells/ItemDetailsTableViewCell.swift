//
//  ItemDetailsTableViewCell.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
import SDWebImage

class ItemDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var deliveredDateLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    
    var data: BasicInfo? {
        didSet {
            if let data = data {
                self.itemNameLabel.text = data.items_message
                self.deliveredDateLabel.text = data.formattedDeliveredDate
                self.itemImageView.sd_setImage(with: data.itemImageUrl)
            } else {
                // handle empty
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
