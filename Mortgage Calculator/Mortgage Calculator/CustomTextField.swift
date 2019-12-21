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
        doneBarBtn()
        setupPlaceholderText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doneBarBtn()
        setupPlaceholderText()
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
    
    func doneBarBtn() {
           let toolBar = UIToolbar()
           let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
           toolBar.setItems([flexibleSpace,doneButton], animated: false)
           toolBar.sizeToFit()
           toolBar.barTintColor = .systemGreen
           doneButton.tintColor = .white
           inputAccessoryView = toolBar
          
       }
       
       @objc func doneClicked() {
              endEditing(true)
          }
    
}

