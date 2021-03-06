//
//  UITextField.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit

class TextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 10
        return textRect
    }

}
