//
//  ViewController.swift
//  MemeV1
//
//  Created by chase on 14/04/2017.
//  Copyright © 2017 s0w4. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    var textFieldId = Int()
    var memedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.isEnabled = false
        
        textFieldSet(text: "TOP", textfield: &topTextField, self)
        textFieldSet(text: "BOTTOM", textfield: &bottomTextField, self)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(_ notification:Notification) {
        if textFieldId == 1{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(_ notification:Notification) {
        if textFieldId == 1{
            view.frame.origin.y = 0
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        textFieldId = textField.tag
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
            shareButton.isEnabled = true
        }
    }
    
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
    
        imagePickerHelper(sourceType: .photoLibrary)
    }

    @IBAction func pickImageFromCamera(_ sender: Any) {
        imagePickerHelper(sourceType: .camera)
    }
    
    func imagePickerHelper(sourceType : UIImagePickerControllerSourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        memedImage = generateMemedImage()
        var activityViewController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            activity, completed, returned, error in
            
            if completed{
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        toolbar.isHidden = true
        navbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        toolbar.isHidden = false
        navbar.isHidden = false
        
        return memedImage
    }
    
    func save(){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func cancelEditor(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
}

