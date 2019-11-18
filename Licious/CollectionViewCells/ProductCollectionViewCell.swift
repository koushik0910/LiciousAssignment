//
//  ProductCollectionViewCell.swift
//  Licious
//
//  Created by Koushik Dutta on 17/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productTitleLabel: UILabel!
    var data : ProductData?{
        didSet{
            if let data = data{
                 productTitleLabel.text = data.pr_name
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
