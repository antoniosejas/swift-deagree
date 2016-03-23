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
    enum textFieldTag: Int {case Top = 1, Bottom}
    
    var stringConstants = strings()
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if( stringConstants.top == textField.text
         || stringConstants.bottom == textField.text ){
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if("" == textField.text){
            resetTextFromTextField(textField)
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }

    //Also is called from ViewController
    func resetTextFromTextField(textField: UITextField) {
        if(textField.tag == textFieldTag.Top.rawValue){
            textField.text = stringConstants.top
        }else{
            textField.text = stringConstants.bottom
        }
    }
}
