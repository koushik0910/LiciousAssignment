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
        setTitleColor(.red, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
        addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = 4.0
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
                backgroundColor = UIColor.red
                setTitleColor(.white, for: .selected)
            } else {
                backgroundColor = UIColor.clear
                setTitleColor(.red, for: .normal)
            }
        }
    }
}
