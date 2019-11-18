//
//  Model.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation


class ReviewRating: Codable {
    var data: ReviewRatingData
}

class ReviewRatingData: Codable {
    var shipment_id: String
    var noOfReviews: Int
    var order_date: String
    var basic_info : BasicInfo
    var feedbackItems : [FeedbackItems]
}

class BasicInfo: Codable{
    var delivered_date : String
    var formattedDeliveredDate : String?{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let deliveredDate = dateFormatter.date(from: delivered_date)!

            dateFormatter.dateFormat = "dd-MMM-YYYY"
            let formattedDate = dateFormatter.string(from: deliveredDate)
            return "Delivered:" + formattedDate
        }
    }
    var items_message : String
    var item_images: [String]
    
    var itemImageUrl: URL? {
        guard let urlString = item_images.first else {return nil}
        return URL(string: urlString)
    }
}

class FeedbackItems: Codable{
    var classQuestion : String
    var feedbackType : Feedback
    var rateLevel : [RateLevel]?
    var updatedRating : Int?
    var question : RateLevel? {
        guard let rateLevel = rateLevel,
            let updatedRating = updatedRating else {return nil}
        return rateLevel[updatedRating-1]
    }
    var selectedIndex : Int?
    var product_data : [ProductData]?
    
    enum Feedback : String, Codable{
        case question_with_text
        case dynamic
    }
}

class ProductData: Codable {
    var pr_name: String
    var textQuestion : String
    var updatedRating : Int?
    var rateLevel : [RateLevel]?
    var question : RateLevel? {
        guard let rateLevel = rateLevel,
            let updatedRating = updatedRating else {return nil}
        return rateLevel[updatedRating-1]
    }
}

class RateLevel : Codable{
    var level : Int
    var levelRateQuestion : [LevelRateQuestion]
}

class LevelRateQuestion : Codable {
    let subClassQuestion : String
    let attributes : [Attributes]
}

class Attributes: Codable {
    let option : String
    let subClass : String
}

