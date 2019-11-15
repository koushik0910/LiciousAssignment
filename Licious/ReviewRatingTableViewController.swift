//
//  ReviewRatingTableViewController.swift
//  Licious
//
//  Created by Koushik Dutta on 14/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class ReviewRatingTableViewController: UITableViewController {
    
    
    @IBOutlet weak var submitButton: UIButton!
    enum Section: Int {
        case OrderDetails = 0
        case Feedback
        case AnythingElse
        
        func reuseIdentifier() -> String {
            switch self {
                case .OrderDetails: return "ItemDetailsTableViewCell"
                case .Feedback: return "FeedbackTableViewCell"
                case .AnythingElse: return "ItemDetailsTableViewCell"
            }
        }
    }

    @IBOutlet var viewModel: ReviewRatingViewModel!
    
    @IBOutlet var submitButtonView: UIView!
    
    
    override var inputAccessoryView: UIView? {
        return submitButtonView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.red.cgColor
        
        self.viewModel.fetchData {
            self.tableView.reloadData()
            self.becomeFirstResponder()
        }
        
        registerCells()
    }
    
    
    private func registerCells() {
        self.tableView.register(UINib.init(nibName: "ItemDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemDetailsTableViewCell")
        self.tableView.register(UINib.init(nibName: "FeedbackTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedbackTableViewCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let section = Section(rawValue: section) else {return 0}
        return self.viewModel.numberOfRows(forSection: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: section.reuseIdentifier(), for: indexPath)

        switch section {
        case .OrderDetails:
            guard let cell = cell as? ItemDetailsTableViewCell else {return UITableViewCell()}
            cell.data = self.viewModel.response?.data.basic_info
        case .Feedback:
            guard let cell = cell as? FeedbackTableViewCell else {return UITableViewCell()}
            cell.data = self.viewModel.response?.data.feedbackItems[indexPath.row]
            cell.delegate = self
        default: return UITableViewCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = Section(rawValue: section) else {return CGFloat.leastNormalMagnitude}
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}


extension ReviewRatingTableViewController : RatingProtocol{
    func updateCell() {
        tableView.reloadData()
    }
    
}
