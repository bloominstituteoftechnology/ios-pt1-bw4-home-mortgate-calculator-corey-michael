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
    @IBOutlet weak var homePriceTxtField:    UITextField!
    @IBOutlet weak var downPaymentTxtField:  UITextField!
    @IBOutlet weak var interestRateTxtField: UITextField!
    @IBOutlet weak var loanTermTxtField:     UITextField!
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
        self.homePriceTxtField.delegate = self
        self.downPaymentTxtField.delegate = self
        self.interestRateTxtField.delegate = self
        self.loanTermTxtField.delegate = self
//        navigationController?.navigationBar.isHidden = true
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
        guard let principal = self.homePriceTxtField.text, !principal.isEmpty else { return self.presentEmptyHomePriceTextField() }
        guard let downPayment = self.downPaymentTxtField.text, !downPayment.isEmpty else { return self.presentEmptyDownPaymentTextField() }
        guard let interestRate = self.interestRateTxtField.text, !interestRate.isEmpty else { return self.presentEmptyInterestRateTextField() }
        guard let termLength = self.loanTermTxtField.text, !termLength.isEmpty else { return self.presentEmptyLoanTermTextField() }

        self.view.endEditing(true)
        self.monthlyPayment = mortgageController.calculateMortgagePayments(principalAmount: self.principalAmount, downPayment: self.downPayment, interestRate: self.interestRate, termLength: self.termLength)
        self.updateViews()
    }

    @IBAction func clearBtnPressed(_ sender: UIButton) {
        clearTextFields()
    }

    @IBAction func showAmortizationSchedule(_ sender: UIButton) {
        if self.principalAmount > 0 && self.downPayment >= 0 && self.interestRate > 0 && self.termLength > 0 {
            let interestRatePercentage = self.interestRate / (12 * 100)
            let totalPaymentsCount = self.termLength * 12
            var adjustedPrice = self.principalAmount - self.downPayment

            let firstStep = interestRatePercentage * pow(1 + interestRatePercentage, totalPaymentsCount)
            let secondStep = pow(1 + interestRatePercentage, totalPaymentsCount) - 1
            let result = firstStep / secondStep

            let monthlyPayment = adjustedPrice * result
            var interest = adjustedPrice * interestRatePercentage
            var principal = monthlyPayment - interest
            self.mortgageController.payments = [];

            for _ in 1...Int(totalPaymentsCount) {
                adjustedPrice = adjustedPrice - principal
                self.mortgageController.payments.append(MortgagePayment(principalAmount: abs(adjustedPrice), downPayment: downPayment, interestRate: interest, termLength: termLength, monthlyPayment: monthlyPayment))
    
                interest = adjustedPrice * interestRatePercentage
                principal = monthlyPayment - interest
            }
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let paymentViewController = storyBoard.instantiateViewController(withIdentifier: "AmortizationSchedule") as! PaymentScheduleTableViewController
            paymentViewController.mortgageController = self.mortgageController
            self.navigationController?.pushViewController(paymentViewController, animated: true)
        }
    }

    func presentEmptyHomePriceTextField() {
        let alert = UIAlertController(title: "Empty Home Price!", message: "The Home Price text field is empty!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
    }

    func presentEmptyDownPaymentTextField() {
        let alert = UIAlertController(title: "Empty Down Payment!", message: "The Down Payment text field is empty!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)

        alert.addAction(okayAction)

        present(alert, animated: true, completion: nil)
    }

    func presentEmptyInterestRateTextField() {
        let alert = UIAlertController(title: "Empty Interest Rate!", message: "The Interest Rate text field is empty!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)

        alert.addAction(okayAction)

        present(alert, animated: true, completion: nil)
    }

    func presentEmptyLoanTermTextField() {
        let alert = UIAlertController(title: "Empty Loan Term!", message: "The Loan Term text field is empty!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)

        alert.addAction(okayAction)

        present(alert, animated: true, completion: nil)
    }

    func clearTextFields() {
        homePriceTxtField.text = nil
        downPaymentTxtField.text = nil
        interestRateTxtField.text = nil
        loanTermTxtField.text = nil
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
        if textField == homePriceTxtField {
            textField.resignFirstResponder()
            downPaymentTxtField.becomeFirstResponder()
        } else if textField == downPaymentTxtField {
            textField.resignFirstResponder()
            interestRateTxtField.becomeFirstResponder()
        } else if textField == interestRateTxtField {
            textField.resignFirstResponder()
            loanTermTxtField.becomeFirstResponder()
        } else if textField == loanTermTxtField {
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

        if textField == homePriceTxtField {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.principalAmount = doubleVal
            textField.text = formatCurrencyValue(value: doubleVal)
        } else if textField == downPaymentTxtField {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.downPayment = doubleVal
            let percentage = Int((self.downPayment / self.principalAmount) * 100)
            downPmtPercentageLbl.text = "(\(percentage)%)"
            textField.text = formatCurrencyValue(value: doubleVal)
        } else if textField == interestRateTxtField {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.interestRate = doubleVal
            textField.text = formatPercentageValue(value: doubleVal)
        } else if textField == loanTermTxtField {
            guard let value = textField.text, !value.isEmpty else { return }
            let doubleVal = (value as NSString).doubleValue
            self.termLength = doubleVal
            textField.text = formatTermValue(value: doubleVal)
        }
    }

}
