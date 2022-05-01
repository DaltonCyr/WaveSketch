//
//  FreeSketchTextFields.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit
extension GuidedSketchViewController: UITextFieldDelegate {
    
    
    
    //Allows User to touch outside of key pad to dismiss the key pad
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        MaxVoltage.resignFirstResponder()
        MinVoltage.resignFirstResponder()
        Frequency.resignFirstResponder()
        
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
