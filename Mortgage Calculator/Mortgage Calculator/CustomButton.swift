//
//  CustomButton.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 12/20/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 5
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 10
        layer.shadowRadius = 5.0
    }
    
}
