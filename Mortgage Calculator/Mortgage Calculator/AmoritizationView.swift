//
//  AmoritizationView.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 1/10/20.
//  Copyright © 2020 Michael Stoffer. All rights reserved.
//

import UIKit

class AmoritizationView: UIView {
    
    var payments = [MortgagePayment]()
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        
        path.move(to: CGPoint(x: 0, y: 20))
        path.addLine(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 150))
        path.addLine(to: CGPoint(x: 150, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 100))
        
        UIColor.systemGreen.set()
        path.stroke()
    }
    

    
    
}
