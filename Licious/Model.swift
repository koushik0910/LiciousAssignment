//
//  Model.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation


class ReviewRating: Codable {
    let data: ReviewRatingData
}

class ReviewRatingData: Codable {
    let shipment_id: String
    let noOfReviews: Int
    let order_date: String
    let basic_info : BasicInfo
    let feedbackItems : [FeedbackItems]
}

class BasicInfo: Codable{
    let delivered_date : String
    let items_message : String
    let item_images: [String]
    
    var itemImageUrl: URL? {
        guard let urlString = item_images.first else {return nil}
        return URL(string: urlString)
    }
}

class FeedbackItems: Codable{
    let classQuestion : String
    let feedbackType : Feedback
    let rateLevel : [RateLevel]?
    var updatedRating : Int?
    var question : RateLevel? {
        guard let rateLevel = rateLevel,
            let updatedRating = updatedRating else {return nil}
        return rateLevel[updatedRating-1]
    }
    enum Feedback : String, Codable{
        case question_with_text
        case dynamic
    }
}

class RateLevel : Codable{
    let level : Int
    let levelRateQuestion : [LevelRateQuestion]
}

class LevelRateQuestion : Codable {
    let subClassQuestion : String
    let attributes : [Attributes]
}

class Attributes: Codable {
    let option : String
    let subClass : String
}
