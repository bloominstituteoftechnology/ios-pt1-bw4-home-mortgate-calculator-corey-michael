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
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "      Payment               Interest            Principal"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mortgageController!.payments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentTableViewCell
        
        let payment = self.mortgageController!.payments[indexPath.row]
        cell.payment = payment

        return cell
    }

}
