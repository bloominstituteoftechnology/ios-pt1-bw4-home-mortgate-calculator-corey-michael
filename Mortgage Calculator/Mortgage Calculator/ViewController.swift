//
//  ViewController.swift
//  Mortgage Calculator
//
//  Created by Michael Stoffer on 12/17/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homePriceTxtFeild:    UITextField!
    @IBOutlet weak var downPaymentTxtFeild:  UITextField!
    @IBOutlet weak var interestRateTxtFeild: UITextField!
    @IBOutlet weak var loanTermTxtFeild:     UITextField!
    @IBOutlet weak var downPmtPercentageLbl: UILabel!
    @IBOutlet weak var paymentResultLbl: UILabel!
    @IBOutlet weak var termLengthLbl:    UILabel!
    @IBOutlet weak var showAmortizationScheduleButton: UIButton!

    // MARK: - Controllers
    let mortgageController = MortgageController()

    // MARK: - Variables
    var principalAmount: Double = 0.0
    var downPayment: Double = 0.0
    var interestRate: Double = 0.0
    var termLength: Double = 0.0
    var monthlyPayment: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.homePriceTxtFeild.delegate = self
        self.downPaymentTxtFeild.delegate = self
        self.interestRateTxtFeild.delegate = self
        self.loanTermTxtFeild.delegate = self
        self.setupTextFields()
    }

    func setupTextFields() {
        homePriceTxtFeild.layer.borderWidth = 1.0
        homePriceTxtFeild.layer.borderColor = UIColor.systemGray.cgColor
        homePriceTxtFeild.layer.cornerRadius = 5
        downPaymentTxtFeild.layer.borderWidth = 1.0
        downPaymentTxtFeild.layer.borderColor = UIColor.systemGray.cgColor
        downPaymentTxtFeild.layer.cornerRadius = 5
        interestRateTxtFeild.layer.borderWidth = 1.0
        interestRateTxtFeild.layer.borderColor = UIColor.systemGray.cgColor
        interestRateTxtFeild.layer.cornerRadius = 5
        loanTermTxtFeild.layer.borderWidth = 1.0
        loanTermTxtFeild.layer.borderColor = UIColor.systemGray.cgColor
        loanTermTxtFeild.layer.cornerRadius = 5
    }

    // MARK: - Formatters
    func formatCurrencyValue(value: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter.string(from: NSNumber(value: value))!
    }

    func formatPercentageValue(value: Double) -> String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.multiplier = 1.00
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 1
        return percentFormatter.string(from: NSNumber(value: value))!
    }

    func formatTermValue(value: Double) -> String {
        return "\(value) (Yrs)"
    }

    // MARK: - Actions
    @IBAction func calculateBtnPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.monthlyPayment = mortgageController.calculateMortgagePayments(principalAmount: self.principalAmount, downPayment: self.downPayment, interestRate: self.interestRate, termLength: self.termLength)
        self.updateViews()
    }

    @IBAction func clearBtnPressed(_ sender: UIButton) {
        clearTextFields()
    }

    func clearTextFields() {
        homePriceTxtFeild.text = nil
        downPaymentTxtFeild.text = nil
        interestRateTxtFeild.text = nil
        loanTermTxtFeild.text = nil
        downPmtPercentageLbl.text = "(0%)"
        paymentResultLbl.text = "$0.00"
        termLengthLbl.text = nil
        showAmortizationScheduleButton.setTitle("", for: .normal)
    }

    func updateViews() {
        paymentResultLbl.text = formatCurrencyValue(value: self.monthlyPayment)
        termLengthLbl.text = "\(Int(self.termLength))-Year Fixed Loan Term"
        showAmortizationScheduleButton.setTitle("Show Amortization Schedule", for: .normal)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPaymentSchedule" {
            guard let paymentScheduleTBC = segue.destination as? PaymentScheduleTableViewController else { return }
            
            paymentScheduleTBC.mortgageController = self.mortgageController
        }
    }

}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == homePriceTxtFeild {
            textField.resignFirstResponder()
            downPaymentTxtFeild.becomeFirstResponder()
        } else if textField == downPaymentTxtFeild {
            textField.resignFirstResponder()
            interestRateTxtFeild.becomeFirstResponder()
        } else if textField == interestRateTxtFeild {
            textField.resignFirstResponder()
            loanTermTxtFeild.becomeFirstResponder()
        } else if textField == loanTermTxtFeild {
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.layer.cornerRadius = 5
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 5

        if textField == homePriceTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.principalAmount = doubleVal
            textField.text = formatCurrencyValue(value: doubleVal)
        } else if textField == downPaymentTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.downPayment = doubleVal
            let percentage = Int((self.downPayment / self.principalAmount) * 100)
            downPmtPercentageLbl.text = "(\(percentage)%)"
            textField.text = formatCurrencyValue(value: doubleVal)
        } else if textField == interestRateTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.interestRate = doubleVal
            textField.text = formatPercentageValue(value: doubleVal)
        } else if textField == loanTermTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.termLength = doubleVal
            textField.text = formatTermValue(value: doubleVal)
        }
    }

}
