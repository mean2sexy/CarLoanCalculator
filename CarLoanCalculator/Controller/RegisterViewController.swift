//
//  RegisterViewController.swift
//  CarLoanCalculator
//
//  Created by Chaturon Itthiprapakul on 14/10/17.
//  Copyright © 2017 Toyota Lampang. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Pre-linked IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var lineIdTextField: UITextField!
    
    @IBOutlet weak var pictureProfileImageView: UIImageView!
    
    
    let FIREBASE_DB_URL = "https://carloancalculator-3094f.firebaseio.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer: )))
        pictureProfileImageView.isUserInteractionEnabled = true
        pictureProfileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true,completion: nil)
    }

    
    //Delegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage!
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel Picker")
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                        print(err!)
                    }
                    print("Saved user successfully in Firebase DB")
                })
                
                //Go to Calculator View Controller
                self.performSegue(withIdentifier: "goToCalculator", sender: self)
            }
        }
    }
    

}
