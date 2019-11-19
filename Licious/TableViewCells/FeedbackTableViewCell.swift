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
    
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadBadImageView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var productsCollectionView: UICollectionView!{
        didSet{
            productsCollectionView.register(UINib.init(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
              productsCollectionView.dataSource = self
              productsCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var optionsStackView: UIStackView!
    
    @IBOutlet weak var cosmosView: CosmosView! {
        didSet{
            cosmosView.didFinishTouchingCosmos = { rating in
                switch self.data?.feedbackType {
                case .question_with_text:
                    self.data?.updatedRating = Int(rating)
                case .dynamic:
                    self.data?.product_data?[self.data?.selectedIndex ?? 0].updatedRating = Int(rating)
                case .none:
                    break                    
                }
                self.delegate?.updateCell()
            }
        }
    }
    
    var data: FeedbackItems? {
        didSet {
            titleLabel.text = data?.classQuestion
            let subviews = optionsStackView.arrangedSubviews
            for item in subviews {
                item.removeFromSuperview()
            }
            if let feedbackType = data?.feedbackType{
                switch feedbackType {
                case .question_with_text:
                    subTitleLabel.isHidden = data?.question?.levelRateQuestion.first?.subClassQuestion == nil
                    subTitleLabel.text = data?.question?.levelRateQuestion.first?.subClassQuestion
                    
                    if let attributes = data?.question?.levelRateQuestion.first?.attributes {
                        let views = SelectionButton.buttonLayout(forAtttributes: attributes)
                        for item in views {
                            optionsStackView.addArrangedSubview(item)
                        }
                        optionsStackView.isHidden = false
                    } else {
                        optionsStackView.isHidden = true
                    }
                    productsCollectionView.isHidden = true
                    cosmosView.rating = Double(data?.updatedRating ?? 0)
                    
                case .dynamic:
                    subTitleLabel.isHidden = data?.product_data?[self.data?.selectedIndex ?? 0].question?.levelRateQuestion.first?.subClassQuestion == nil
                    subTitleLabel.text = data?.product_data?[self.data?.selectedIndex ?? 0].question?.levelRateQuestion.first?.subClassQuestion
                    
                    if let attributes = data?.product_data?[self.data?.selectedIndex ?? 0].question?.levelRateQuestion.first?.attributes {
                        let views = SelectionButton.buttonLayout(forAtttributes: attributes)
                        for item in views {
                            optionsStackView.addArrangedSubview(item)
                        }
                        optionsStackView.isHidden = false
                    } else {
                        optionsStackView.isHidden = true
                    }
                    productsCollectionView.isHidden = false
                    productsCollectionView.selectItem(at: IndexPath(row: data?.selectedIndex ?? 0, section: 0), animated: false, scrollPosition: [])
                    cosmosView.rating = Double(data?.product_data?[self.data?.selectedIndex ?? 0].updatedRating ?? 0)
                    
                    if (self.data?.product_data?[self.data?.selectedIndex ?? 0].updatedRating) ?? 0  > 2 || (self.data?.product_data?[self.data?.selectedIndex ?? 0].updatedRating) ?? 0 < 1{
                        self.uploadBadImageView.isHidden = true
                        self.stackViewBottomConstraint.constant = 16
                    }else{
                        self.uploadBadImageView.isHidden = false
                        self.stackViewBottomConstraint.constant = 0
                    }
                }
            }
        }
    }
    weak var delegate : RatingProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


extension FeedbackTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.product_data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.data = data?.product_data?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        data?.selectedIndex = indexPath.row
        optionsStackView.isHidden = true
        subTitleLabel.isHidden = true
        self.delegate?.updateCell()
    }
    
}

