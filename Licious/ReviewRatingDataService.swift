//
//  ReviewRatingDataService.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class ReviewRatingDataService: NSObject {
    
    
    lazy var path: URL? = {
        return Bundle.main.url(forResource: "FeedbackPayload", withExtension: "json")
    }()
    
    lazy var data: Data? = {
        guard let path = self.path else {return nil}
        return try? Data(contentsOf: path)
    }()
    
    func fetchData(onCompletion: @escaping (ReviewRating? ,Bool)->Void) {
        guard let data = self.data else {
            onCompletion(nil, false)
            return
        }
        
        let decoder = JSONDecoder()
        if let response = try? decoder.decode(ReviewRating.self, from: data) {
            onCompletion(response, true)
        } else {
            onCompletion(nil, false)
        }
        
    }

}
