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
        
        calculateBtn.layer.cornerRadius = 5
        doneBarBtn()
        
        
    }

    
    //TODO: - update the downpayment percentage based on the value.
    
    func updateViews() {
        paymentResultLbl.text = "$ \(mortage.monthlyPayment)"
        termLengthLbl.text = "\(mortage.termLength) Year Fixed Loan Term"
        let percentage = ((mortage.downPayment / mortage.principalAmount) * 100)
        downPmtPercentageLbl.text = "\(round(percentage))" + "%"
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
    
    func doneBarBtn() {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
        toolBar.sizeToFit()
        toolBar.barTintColor = .systemGreen
        doneButton.tintColor = .white
        homePriceTxtFeild.inputAccessoryView = toolBar
        downPaymentTxtFeild.inputAccessoryView  = toolBar
        interestRateTxtFeild.inputAccessoryView = toolBar
        loanTermTxtFeild.inputAccessoryView  = toolBar
    }
    
    @objc func doneClicked() {
           view.endEditing(true)
       }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

