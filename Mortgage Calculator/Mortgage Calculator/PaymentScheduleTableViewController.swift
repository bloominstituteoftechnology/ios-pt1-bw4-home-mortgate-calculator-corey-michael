//
//  PaymentScheduleTableViewController.swift
//  Mortgage Calculator
//
//  Created by Michael Stoffer on 12/21/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class PaymentScheduleTableViewController: UITableViewController {
    
    var mortgageController: MortgageController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        
        let countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 17)
        countLabel.text = "Count"
//        countLabel.backgroundColor = .systemGreen
        countLabel.textAlignment = .center
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: NSLayoutConstraint.Axis.horizontal)

        let paymentLabel = UILabel()
        paymentLabel.font = UIFont.systemFont(ofSize: 17)
        paymentLabel.text = "Payment"
//        paymentLabel.backgroundColor = .systemYellow
        paymentLabel.textAlignment = .center
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: NSLayoutConstraint.Axis.horizontal)
        
        let interestLabel = UILabel()
        interestLabel.font = UIFont.systemFont(ofSize: 17)
        interestLabel.text = "Interest"
//        interestLabel.backgroundColor = .systemBlue
        interestLabel.textAlignment = .center
        interestLabel.translatesAutoresizingMaskIntoConstraints = false
        interestLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: NSLayoutConstraint.Axis.horizontal)
        
        let principalLabel = UILabel()
        principalLabel.font = UIFont.systemFont(ofSize: 17)
        principalLabel.text = "Principal"
//        principalLabel.backgroundColor = .systemRed
        principalLabel.textAlignment = .center
        principalLabel.translatesAutoresizingMaskIntoConstraints = false
        principalLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: NSLayoutConstraint.Axis.horizontal)
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 8.0
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(paymentLabel)
        stackView.addArrangedSubview(interestLabel)
        stackView.addArrangedSubview(principalLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(stackView)
        view.backgroundColor = .systemGray
        
        let guide = view.safeAreaLayoutGuide
        stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -45.0).isActive = true
        stackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0.0).isActive = true

        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mortgageController!.payments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentTableViewCell
        
        let payment = self.mortgageController!.payments[indexPath.row]
        cell.payment = payment
        cell.paymentCountLabel.text = String(indexPath.row + 1)

        return cell
    }

}
