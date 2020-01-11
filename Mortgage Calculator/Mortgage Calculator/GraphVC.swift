//
//  GraphVC.swift
//  Mortgage Calculator
//
//  Created by Seschwan on 1/10/20.
//  Copyright © 2020 Michael Stoffer. All rights reserved.
//

import UIKit

class GraphVC: UIViewController {
    
    @IBOutlet weak var currentPaymentLabel: UILabel!
    @IBOutlet weak var interestPaidLabel: UILabel!
    @IBOutlet weak var principalLabel: UILabel!
    
    var morgageController: MorgageController?
    var payment: MorgagePayment? {
        didSet {
            self.updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    func formatCurrencyValue(value: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter.string(from: NSNumber(value: value))!
    }
    
    private func updateViews() {
        guard let payment = self.payment, isViewLoaded else { return }
        
        currentPaymentLabel.text = self.formatCurrencyValue(value: payment.monthlyPayment)
        interestPaidLabel.text = self.formatCurrencyValue(value: payment.interestRate)
        principalLabel.text = self.formatCurrencyValue(value: payment.principalAmount)
    }
}
