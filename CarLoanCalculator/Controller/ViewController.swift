//
//  ViewController.swift
//  CarLoanCalculator
//
//  Created by Chaturon Itthiprapakul on 9/27/17.
//  Copyright © 2017 Toyota Lampang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    //Create UITextField
    @IBOutlet weak var carPriceTextField: UITextField!
    @IBOutlet weak var downPaymentTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var rvTextField: UITextField!
    
    //Create PickerView
    @IBOutlet weak var periodPickerView: UIPickerView!
    @IBOutlet weak var rvLabel: UILabel!
    
    //Create UILabel
    @IBOutlet weak var downPaymentAmount: UILabel!
    
    //Create UI Switch Function
    @IBAction func sabuydSwitch(_ sender: UISwitch) {
        if (sender.isOn == true){
            rvTextField.isHidden = false
            rvLabel.isHidden = false
            sabuydFlag = true
            periods = [4,5]
            self.periodPickerView.reloadAllComponents()
            self.periodPickerView.selectRow(0, inComponent: 0, animated: true)
            car.installment = periods[0]
        }
        else {
            rvTextField.isHidden = true
            rvLabel.isHidden = true
            sabuydFlag = false
            periods = [1,2,3,4,5,6,7]
            self.periodPickerView.reloadAllComponents()
            self.periodPickerView.selectRow(0, inComponent: 0, animated: true)
            car.installment = periods[0]
        }
    }
    
    //Create variables
    //var payment: Double = 0
    
    var periods = [1,2,3,4,5,6,7]
    var car = Car()
    var sabuydFlag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Assign delegate to UILabel
        //downPaymentAmount.text = "0"
        
        //Assign delegate to UITextField
        carPriceTextField.delegate = self
        downPaymentTextField.delegate = self
        interestTextField.delegate = self
        
        //Assign delegate to UIPickerView
        periodPickerView.delegate = self
        
        rvTextField.isHidden = true
        rvLabel.isHidden = true
        
        car.installment = periods[0]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        carPriceTextField.resignFirstResponder()
        self.view.endEditing(true)
    }


    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        //reset UI
        carPriceTextField.text = ""
        downPaymentTextField.text = ""
        interestTextField.text = ""
        
        
        //Reset object
        car = Car()
        
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        
        //Receive inputs from text field using optional binding method
        if let cp = Double(carPriceTextField.text!) {
            
            //carPrice = cp
            car.carPrice = cp
            
        }
        else{
            print("This is not a number")
        }
        
        //Receive inputs from text field using optional binding method
        if let dp = Double(downPaymentTextField.text!) {
            
            car.downPaymentAmount = dp
        }
        else{
            print("This is not a number")
        }
        
        //Receive inputs from text field using optional binding method
        if let inter = Double(interestTextField.text!) {
            
            car.interestRate = inter
        }
        else{
            print("This is not a number")
        }
        
        //Receive inputs from text field using optional binding method
        if let rv = Double(rvTextField.text!){
            
            car.rv = rv
            
        }
        else{
            print("This is not a number")
        }
        
        if ( sabuydFlag == true ){
            car.calculateSabuyDPaymentPerMonth()
        }
        else{
            car.calculatePaymentPerMonth()
        }
        
        //print("\(car.paymentPerMonth)")
        
        performSegue(withIdentifier: "goToResultScreen", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultScreen" {
            
            let destinationVC = segue.destination as! ResultViewController
            
            //destinationVC.textPassedOver = "\(car.paymentPerMonth)"
            destinationVC.result = car
            
        }
    }
    
    //MARK: PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(periods[row])
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return periods.count
    
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        print(periods[row])
        car.installment = periods[row]
        
    }

}

