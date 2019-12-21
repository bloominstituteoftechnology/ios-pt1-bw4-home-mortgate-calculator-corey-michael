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
    @IBOutlet weak var downPmtPercentageLbl: UILabel!
    @IBOutlet weak var interestRateTxtFeild: UITextField!
    @IBOutlet weak var loanTermTxtFeild:     UITextField!
    @IBOutlet weak var calculateBtn:     UIButton!
    @IBOutlet weak var paymentResultLbl: UILabel!
    @IBOutlet weak var termLengthLbl:    UILabel!
    
    // MARK: - Controllers
    let mortgageController = MortgageController()

    // MARK: - Variables
    var mortage = Mortgage(principalAmount: 0.0, downPayment: 0.0, interestRate: 0.0, termLength: 0.0, monthlyPayment: 0.0) {
        didSet {
            updateViews()
        }
    }

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
        mortage.monthlyPayment = mortgageController.calculateMortgagePayments(principalAmount: mortage.principalAmount, downPayment: mortage.downPayment, interestRate: mortage.interestRate, termLength: mortage.termLength)
    }

    @IBAction func clearBtnPressed(_ sender: UIButton) {
        clearTextFields()
    }

    func clearTextFields() {
        homePriceTxtFeild.text = nil
        downPaymentTxtFeild.text = nil
        interestRateTxtFeild.text = nil
        loanTermTxtFeild.text = nil
        downPmtPercentageLbl.text = "(0)%"
        paymentResultLbl.text = "$0.00"
        termLengthLbl.text = nil
    }

    func updateViews() {
        paymentResultLbl.text = formatCurrencyValue(value: mortage.monthlyPayment)
        termLengthLbl.text = "\(Int(mortage.termLength))-Year Fixed Loan Term"
        
        let percentage = Int((mortage.downPayment / mortage.principalAmount) * 100)
        downPmtPercentageLbl.text = "(\(percentage))" + "%"
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
            mortage.principalAmount = doubleVal
            textField.text = formatCurrencyValue(value: doubleVal)
        } else if textField == downPaymentTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            mortage.downPayment = doubleVal
            textField.text = formatCurrencyValue(value: doubleVal)
        } else if textField == interestRateTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            mortage.interestRate = doubleVal
            textField.text = formatPercentageValue(value: doubleVal)
        } else if textField == loanTermTxtFeild {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            mortage.termLength = doubleVal
            textField.text = formatTermValue(value: doubleVal)
        }
    }

}
