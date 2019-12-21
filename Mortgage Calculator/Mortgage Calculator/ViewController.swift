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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Formatter
    func formatCurrencyValue(value: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter.string(from: NSNumber(value: value))!
    }
    
    // MARK: - Keyboard Observers
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 4
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    func updateViews() {
        paymentResultLbl.text = formatValue(value: mortage.monthlyPayment)
        termLengthLbl.text = "\(Int(mortage.termLength))-Year Fixed Loan Term"
        
        let percentage = Int((mortage.downPayment / mortage.principalAmount) * 100)
        downPmtPercentageLbl.text = "(\(percentage))" + "%"
    }
    
    
    @IBAction func calculateBtnPressed(_ sender: UIButton) {
        guard let homePrice = homePriceTxtFeild.text, !homePrice.isEmpty,
            let downPayment = downPaymentTxtFeild.text, !downPayment.isEmpty,
            let interestRate = interestRateTxtFeild.text, !interestRate.isEmpty,
            let loanTerm = loanTermTxtFeild.text, !loanTerm.isEmpty else { return }
        
        mortage.principalAmount = (homePrice as NSString).doubleValue
        mortage.downPayment = (downPayment as NSString).doubleValue
        mortage.interestRate = (interestRate as NSString).doubleValue
        mortage.termLength = (loanTerm as NSString).doubleValue
        
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
    
}

