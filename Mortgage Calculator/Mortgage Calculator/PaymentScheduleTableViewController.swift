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
        countLabel.font = UIFont.systemFont(ofSize: 14)
        countLabel.text = "Count"
        countLabel.textAlignment = .center
        countLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 18.0).isActive = true

        let paymentLabel = UILabel()
        paymentLabel.font = UIFont.systemFont(ofSize: 14)
        paymentLabel.text = "Payment"
        paymentLabel.textAlignment = .center
        paymentLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true
        paymentLabel.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        
        let interestLabel = UILabel()
        interestLabel.font = UIFont.systemFont(ofSize: 14)
        interestLabel.text = "Interest"
        interestLabel.textAlignment = .center
        interestLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true
        interestLabel.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        
        let principalLabel = UILabel()
        principalLabel.font = UIFont.systemFont(ofSize: 14)
        principalLabel.text = "Principal"
        principalLabel.textAlignment = .center
        principalLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true
        principalLabel.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 8.0
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(paymentLabel)
        stackView.addArrangedSubview(interestLabel)
        stackView.addArrangedSubview(principalLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(stackView)
        view.backgroundColor = .systemYellow
        
        let guide = view.safeAreaLayoutGuide
        stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: -20.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0.0).isActive = true
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
