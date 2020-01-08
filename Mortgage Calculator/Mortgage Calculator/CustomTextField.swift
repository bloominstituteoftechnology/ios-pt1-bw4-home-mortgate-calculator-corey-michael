//
//  TextFieldPadding.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 12/19/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    let placeholderTextArray = ["Purchase Price", "Down Payment", "Interest Rate", "Loan Length"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlaceholderText()
        setupTextFields()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlaceholderText()
        setupTextFields()
    }
    
    func setupPlaceholderText() {
        for text in placeholderTextArray {
            attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen])
        }
        switch tag {
        case 0:
            placeholder = placeholderTextArray[0]
        case 1:
            placeholder = placeholderTextArray[1]
        case 2:
            placeholder = placeholderTextArray[2]
        case 3:
            placeholder = placeholderTextArray[3]
        default:
            placeholder = nil
        }
    }

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func setupTextFields() {
        let borderWidth: CGFloat = 1.0
        let borderColor = UIColor.systemGray.cgColor
        let cornerRadius: CGFloat = 5
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
    }
    
    
    
}
