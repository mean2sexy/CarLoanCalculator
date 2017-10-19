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
    
    let FIREBASE_DB_URL = "https://carloancalculator-3094f.firebaseio.com"
    
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
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let firstname = firstNameTextField.text, let nickname = nickNameTextField.text, let lastname = lastNameTextField.text, let telephone = telephoneTextField.text, let lineid = lineIdTextField.text else {
                print("Form is not valid")
                return
        }
            
        
        //Create user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                //error
                print(error!)
                
            }
            else{
                
                //Obtain UID from Firebase Database
                guard let uid = user?.uid else{
                    return
                }
                
                print("Registeration Successful")
                
                //Database reference
                let ref = Database.database().reference(fromURL: self.FIREBASE_DB_URL)
                
                //Declare Dictionary Values for insert in to Firebase Database
                let values = ["firstname": firstname ,"nickname": nickname, "lastname": lastname, "email": email, "telephone" : telephone, "lineid": lineid ]
                    
                //Update user information eg. firsname lastname telephone into Firebase Database
                ref.child("users").child(uid).setValue(values,withCompletionBlock: { (err,ref) in
                    
                    //If error occur
                    if err != nil{
                        print(err?.localizedDescription)
                    }
                    print("Saved user successfully in Firebase DB")
                })
                
                //Go to Calculator View Controller
                self.performSegue(withIdentifier: "goToCalculator", sender: self)
            }
        }
    }
    

}
