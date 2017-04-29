//
//  TextFieldSet.swift
//  Meme
//
//  Created by Chase on 29/04/2017.
//  Copyright © 2017 s0w4. All rights reserved.
//

import UIKit


func textFieldSet (text: String, textfield: inout UITextField!, _ delegate: UITextFieldDelegate? = nil){
    textfield.defaultTextAttributes = memeTextAttributes
    textfield.text = text
    textfield.textAlignment = .center
    if delegate != nil {
       textfield.delegate = delegate
    }
    
}
