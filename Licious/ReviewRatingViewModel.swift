//
//  ReviewRatingViewModel.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class ReviewRatingViewModel: NSObject {

    @IBOutlet weak var service: ReviewRatingDataService!
    
    var response: ReviewRating?
    
    
    func fetchData(onCompletion: ()->Void) {
        self.service.fetchData { (response, success) in
            if let response = response, success {
                self.response = response
                onCompletion()
            }
        }
    }
    
    
    func numberOfRows(forSection section: ReviewRatingTableViewController.Section) -> Int {
        switch section {
        case .OrderDetails : return response == nil ? 0 : 1
        case .Feedback: return response == nil ? 0 : response?.data.feedbackItems.count ?? 0
        case .AnythingElse: return response == nil ? 0 : 1
        }
    }
    
}
