//
//  RegisterViewController.swift
//  CarLoanCalculator
//
//  Created by Chaturon Itthiprapakul on 14/10/17.
//  Copyright © 2017 Toyota Lampang. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //Pre-linked IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var lineIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                //error
                print(error!)
                
            }
            else{
                //success
                print("Registeration Successful")
                
                self.performSegue(withIdentifier: "goToCalculator", sender: self)
            }
        }
    }
    

}
