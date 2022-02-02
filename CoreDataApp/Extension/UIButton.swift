//
//  UIButton.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit

class Button: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
    }
    init(title: String, fontSize: CGFloat, weight: UIFont.Weight, titleColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: weight)
        self.setTitleColor(titleColor, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


