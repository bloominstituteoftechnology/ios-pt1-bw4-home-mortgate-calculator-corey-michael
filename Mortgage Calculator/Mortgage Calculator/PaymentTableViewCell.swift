//
//  PaymentTableViewCell.swift
//  Mortgage Calculator
//
//  Created by Michael Stoffer on 12/21/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var principalLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    
    var payment: MortgagePayment? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let payment = payment else { return }
        paymentLabel.text = String(format: "%.2f", payment.monthlyPayment)
        interestLabel.text = String(format: "%.2f", payment.monthlyPayment * payment.interestRate)
        principalLabel.text = String(format: "%.0f", payment.principalAmount)
    }

}
