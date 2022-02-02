//
//  UILabel.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit

class Label: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
    }
    init(text: String, textColor: UIColor, fontSize: CGFloat = 30, weight: UIFont.Weight = .regular, style: String) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.font = .systemFont(ofSize: fontSize, weight: weight)
        self.font = UIFont(name: style, size: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






