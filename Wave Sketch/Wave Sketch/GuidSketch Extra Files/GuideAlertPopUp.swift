//
//  AlertPopUp.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit

extension GuidedSketchViewController {
    func showAlert(passedTitle: String, passedMessage: String ) {
        let alert = UIAlertController(title: passedTitle, message: passedMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("Pressed Alert Button")
        }))
        
        present(alert, animated: true)    }
    func showAction() {
        
    }
}
