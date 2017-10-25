//
//  ResultViewController.swift
//  CarLoanCalculator
//
//  Created by Chaturon Itthiprapakul on 1/10/17.
//  Copyright © 2017 Toyota Lampang. All rights reserved.
//

import UIKit
import Firebase

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var downPaymentAmountLabel: UILabel!
    @IBOutlet weak var financingAmountLabel: UILabel!
    @IBOutlet weak var installmentLabel: UILabel!
    @IBOutlet weak var rvLabel: UILabel!
    @IBOutlet weak var rvAmountLabel: UILabel!
    
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lineidLabel: UILabel!
    
    var result : Car?
    
    let numberformatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        displayResult()
        displaySalesman()
        
    }

    func displayResult(){
        
        //Initiate Formatter
        numberformatter.numberStyle = NumberFormatter.Style.decimal
        
        
        //resultLabel.text = String(format: "%.0f",result!.paymentPerMonth)
        resultLabel.text = numberformatter.string(from: NSNumber(value: ceil(result!.paymentPerMonth)))
        
        carPriceLabel.text = numberformatter.string(from: NSNumber(value:result!.carPrice))
        downPaymentAmountLabel.text = numberformatter.string(from: NSNumber(value:result!.downPaymentAmount))
        financingAmountLabel.text = numberformatter.string(from: NSNumber(value:result!.financingAmount))
        
        if result?.sabuydFlag == true {
        
            rvLabel.isHidden = false
            rvAmountLabel.text = numberformatter.string(from: NSNumber(value: result!.rvAmount ))
            installmentLabel.text = "\(result!.installment * 12 - 1)"
            
        }
        else {
            rvLabel.isHidden = true
            rvAmountLabel.isHidden = true
            installmentLabel.text = "\(result!.installment * 12)"
        }
    }
    
    func displaySalesman() {
        
        if Auth.auth().currentUser?.uid == nil {
            print("User is not login")
        }
        else{
            print("User is already login")
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.firstnameLabel.text = (dictionary["firstname"] as? String)! + " "
                    self.firstnameLabel.text?.append((dictionary["lastname"] as? String)! + " (")
                    self.firstnameLabel.text?.append((dictionary["nickname"] as? String)! + ")")
                    
                    self.telephoneLabel.text = dictionary["telephone"] as? String
                    self.emailLabel.text = dictionary["email"] as? String
                    self.lineidLabel.text = dictionary["lineid"] as? String
                    
                }
                
            }, withCancel: nil)
        }
        
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
