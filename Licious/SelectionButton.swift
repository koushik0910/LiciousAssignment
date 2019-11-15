//
//  SelectionButton.swift
//  Licious
//
//  Created by Koushik Dutta on 15/11/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class SelectionButton: UIButton {
    
    static func buttonLayout(forAtttributes attributes: [Attributes]) -> [UIStackView]{
        var stackViews = [UIStackView]()
        for i in 0..<attributes.count {
            if i % 2 == 0 {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.spacing = 8.0
                stackView.distribution = .fillEqually
                stackViews.append(stackView)
            }
            guard let lastStackView = stackViews.last else {continue}
           
            let selectionButton = SelectionButton(title: attributes[i].option)
            lastStackView.addArrangedSubview(selectionButton)
        }
        return stackViews
    }
    
    
    init(title: String?) {
        super.init(frame: .zero)
        self.setTitleColor(.red, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor.red
                self.setTitleColor(.white, for: .selected)
            } else {
                self.backgroundColor = UIColor.clear
                self.setTitleColor(.red, for: .normal)
            }
        }
    }
}
