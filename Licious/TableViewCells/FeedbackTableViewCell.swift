//
//  FeedbackTableViewCell.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
import Cosmos
class FeedbackTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var optionsStackView: UIStackView!
    
    @IBOutlet weak var cosmosView: CosmosView! {
        didSet{
            cosmosView.didFinishTouchingCosmos = { rating in
                self.data?.updatedRating = Int(rating)
                self.delegate?.updateCell()
            }
        }
    }
    
    var data: FeedbackItems? {
    didSet {
        titleLabel.text = data?.classQuestion
        subTitleLabel.isHidden = data?.question?.levelRateQuestion.first?.subClassQuestion == nil
        subTitleLabel.text = data?.question?.levelRateQuestion.first?.subClassQuestion
        let subviews = optionsStackView.arrangedSubviews
        for item in subviews {
            item.removeFromSuperview()
        }
        if let attributes = data?.question?.levelRateQuestion.first?.attributes {
            let views = SelectionButton.buttonLayout(forAtttributes: attributes)
            for item in views {
                optionsStackView.addArrangedSubview(item)
            }
            optionsStackView.isHidden = false
        } else {
            optionsStackView.isHidden = true
        }
        }
    }
    weak var delegate : Rating?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
