//
//  AnythingElseTableViewCell.swift
//  Licious
//
//  Created by Koushik Dutta on 18/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class AnythingElseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AnythingElseTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
