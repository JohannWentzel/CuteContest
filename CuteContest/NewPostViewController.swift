//
//  NewPostViewController.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-12-23.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    var selectedImage: UIImage?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.cornerRadius = 5
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(validate), for: .editingChanged)
        
        imagePicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapImage(_ sender: UITapGestureRecognizer) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            promptLabel.isHidden = true
            photoImageView.isHidden = false
            selectedImage = pickedImage
            photoImageView.image = pickedImage
        }
        validate()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func validate(){
        if (nameTextField.text != "" && selectedImage != nil){
            postButton.isEnabled = true
        }
        else {
            postButton.isEnabled = false
        }
    }
    
    
}
