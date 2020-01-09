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
    @IBOutlet weak var paymentCountLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var principalLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    
    var payment: MortgagePayment? {
        didSet {
            updateViews()
        }
    }
    
    func formatCurrencyValue(value: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter.string(from: NSNumber(value: value))!
    }
    
    private func updateViews() {
        guard let payment = payment else { return }
        
//        paymentCountLabel.backgroundColor = .systemGreen
//        paymentLabel.backgroundColor = .systemYellow
//        interestLabel.backgroundColor = .systemBlue
//        principalLabel.backgroundColor = .systemRed

        paymentLabel.text = formatCurrencyValue(value: payment.monthlyPayment)
        interestLabel.text = formatCurrencyValue(value: payment.interestRate)
        principalLabel.text = formatCurrencyValue(value: payment.principalAmount)
    }

}
