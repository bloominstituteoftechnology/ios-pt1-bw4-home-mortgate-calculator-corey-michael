//
//  MorgagePayment.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 12/19/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

struct MortgagePayment {
    var principalAmount: Double
    var downPayment:     Double
    var interestRate:    Double
    var termLength:      Double
    var monthlyPayment:  Double
    
    init(principalAmount: Double, downPayment: Double, interestRate: Double, termLength: Double, monthlyPayment: Double = 0.0) {
        self.principalAmount = principalAmount
        self.downPayment     = downPayment
        self.interestRate    = interestRate
        self.termLength      = termLength
        self.monthlyPayment  = monthlyPayment
    }
}
