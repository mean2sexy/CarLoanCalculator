//
//  ResultViewController.swift
//  CarLoanCalculator
//
//  Created by Chaturon Itthiprapakul on 1/10/17.
//  Copyright © 2017 Toyota Lampang. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var downPaymentAmountLabel: UILabel!
    @IBOutlet weak var financingAmountLabel: UILabel!
    @IBOutlet weak var installmentLabel: UILabel!
    
    var textPassedOver : String?
    var result : Car?
    
    let numberformatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //resultLabel.text = textPassedOver
        
        //result!.calculatePaymentPerMonth()
        //result!.calculateSabuyDPaymentPerMonth()
        //print("\(result!.paymentPerMonth)")
        
        
        numberformatter.numberStyle = NumberFormatter.Style.decimal
        
        
        //resultLabel.text = String(format: "%.0f",result!.paymentPerMonth)
        resultLabel.text = numberformatter.string(from: NSNumber(value: ceil(result!.paymentPerMonth)))
        
        carPriceLabel.text = numberformatter.string(from: NSNumber(value:result!.carPrice))
        downPaymentAmountLabel.text = numberformatter.string(from: NSNumber(value:result!.downPaymentAmount))
        financingAmountLabel.text = numberformatter.string(from: NSNumber(value:result!.financingAmount))
        installmentLabel.text = "\(result!.installment * 12)"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
