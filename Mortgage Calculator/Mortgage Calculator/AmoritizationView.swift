//
//  AmoritizationView.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 1/10/20.
//  Copyright © 2020 Michael Stoffer. All rights reserved.
//

import UIKit

class AmoritizationView: UIView {
    
    var payments = [MorgagePayment]()
    
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
    
//    private func point(for morgagePayment: MorgagePayment) -> CGPoint {
//        
//        let calendar = Calendar.current
//        
//        guard let minDate = morgagePayment.first?.date,
//            let maxDate = morgagePayment.last?.date,
//            let minRate = morgagePayment.min(by: { $0.rate < $1.rate })?.rate,
//            let maxRate = morgagePayment.max(by: { $0.rate < $1.rate })?.rate,
//            let numDays = calendar.dateComponents([.day], from: minDate, to: maxDate).day,
//            maxDate != minDate,
//            minRate != maxRate else {
//                return .zero
//        }
//        
//        let rateRange = maxRate - minRate
//        let rateStep = bounds.height / CGFloat(rateRange)
//        let dayStep = bounds.width / CGFloat(numDays)
//        
//        let yPosition = bounds.maxY - rateStep * CGFloat(morgagePayment.rate - minRate)
//        guard let daysSinceBeginning = calendar.dateComponents([.day], from: minDate, to: morgagePayment.date).day else { return .zero }
//        let xPosition = bounds.minX + CGFloat(daysSinceBeginning) * dayStep
//        return CGPoint(x: xPosition, y: yPosition)
//    }
    
    
}
