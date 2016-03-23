//
//  TextEditDelegate.swift
//  MemeApp
//
//  Created by Antonio Sejas on 22/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit

class TextEditDelegate: NSObject, UITextFieldDelegate {
    struct strings {
        let top =  "TOP"
        let bottom =  "BOTTOM"
    }
    var stringConstants = strings()
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if( stringConstants.top == textField.text
         || stringConstants.bottom == textField.text ){
            textField.text = ""
        }
        print("textFieldDidBeginEditing    ",textField)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing    ",textField)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
}
