import Foundation
import UIKit

extension ImportSketchViewController {
    func showAlert(passedTitle: String, passedMessage: String ) {
        let alert = UIAlertController(title: passedTitle, message: passedMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("Pressed Alert Button")
        }))
        
        present(alert, animated: true)    }
    func showAction() {
        
    }
}
