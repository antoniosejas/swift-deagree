//
//  TextEditDelegate.swift
//  MemeApp
//
//  Created by Antonio Sejas on 22/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit

class TextEditDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        print("textFieldDidBeginEditing    ",textField)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing    ",textField)
    }
    
}
