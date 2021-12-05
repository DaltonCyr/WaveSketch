//
//  ImportDrawTextFeild.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 11/16/21.
//

import Foundation
import UIKit
extension ImportSketchViewController: UITextFieldDelegate {
    
    
    
    //Allows User to touch outside of key pad to dismiss the key pad
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        FileName.resignFirstResponder()
    }
    //Just in case there is a return button, allows the user to exit the keypad
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
        currentTextFeildTag = textField.tag
    }
    
    
    
    
    
}
