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

    @IBOutlet weak var productsCollectionView: UICollectionView!
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
        
        if let feedbackType = data?.feedbackType{
            switch feedbackType {
            case .question_with_text:
                productsCollectionView.isHidden = true
            case .dynamic:
                productsCollectionView.isHidden = false
            }
        }
        }
    }
    weak var delegate : RatingProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.productsCollectionView.register(UINib.init(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FeedbackTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return data?.product_data?.count ?? 0
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
        }
    
}

