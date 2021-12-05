//
//  ImportSketchViewController.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/19/21.
//

import UIKit
import UniformTypeIdentifiers
// MARK: - Import ViewCont Definition

class ImportSketchViewController: UIViewController, UITextViewDelegate {
    
    var currentTextFeildTag = -1
    var selectFileTapped = false
    var endActivityIndicator = false
    var dataInFile = ""
    var voltageArray = [Double]()
    var xAxisArray = [Double]()
    var shouldSaveWave = false
    var compundingMessage = ""
    var continueChecking = 0
    var errorMessage = "No information"

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var importDrawView: ImportDrawVeiw!
    @IBOutlet weak var SaveWavebutton: UIButton!
    @IBOutlet weak var WavePropertiesTextView: UITextView!
    @IBOutlet weak var FileName: UITextField!
    
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .gray
        progressView.tintColor = .white
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityIndicator.stopAnimating()
    
        WavePropertiesTextView.delegate = self
        WavePropertiesTextView.isEditable = false
        
        FileName.delegate = self
        view.addSubview(progressView)
        progressView.frame = CGRect(x: 10, y: 100, width: view.frame.size.width-20, height: 20)
        progressView.setProgress(0, animated: true)
        
        //Listening For KeyBoard Events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    // MARK: - Clear Button Definition

    @IBAction func tapClearButton(_ sender: Any) {
        print("Pressed Clear")
        importDrawView.selectFileTapped = false
        
        importDrawView.linePoint = []
        WavePropertiesTextView.text = ""
        ActivityIndicator.stopAnimating()
        
        
        importDrawView.setNeedsDisplay()
        viewDidLoad()
    }
    
    //MARK: - Moving Text View When Keyboar Up
    @objc func keyboardWillShow(notification: NSNotification){
        
        if currentTextFeildTag == 4 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
                
                
                let keyboardHeight = keyboardFrame.cgRectValue.height
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y -= 0
                }
                else{
                self.view.frame.origin.y -= keyboardHeight - 30
                }
            }
        }
        
    }
    
    @objc func keyboardWillHide(){
        
        self.view.frame.origin.y = 0
        currentTextFeildTag = -1
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Select File Button Definition

    @IBAction func tapSelectFileButton(_ sender: Any) {
        print("Select File pressed")
        
        // MARK: - Clear Old Drawings
        importDrawView.selectFileTapped = false
        
        importDrawView.linePoint = []
        WavePropertiesTextView.text = ""
                
        importDrawView.setNeedsDisplay()
        viewDidLoad()
        
        //MARK: - Start File Pick
        importDrawView.selectFileTapped = true
        ActivityIndicator.startAnimating()
        // Setting up the document picking window that shows the file folder when wanting to import a file
        let selectingDocument = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.text], asCopy: true)
        
        // Extrenous settings to get the picker to show
        selectingDocument.delegate = self
        selectingDocument.allowsMultipleSelection = false
        present(selectingDocument, animated: true, completion: nil)
        
       
        
    }
    //MARK: Save File Button
    @IBAction func tapSaveWaveButton(_ sender: Any) {
        ///SaveImportWave function defined in ImportSaveFile.swift
        if shouldSaveWave{
                if saveImportWave() {
                    showAlert(passedTitle: "Complete", passedMessage: "Saved Wave")
                }
                else{
                    showAlert(passedTitle: "Failed", passedMessage: "Please Check File Format Against The Required Format")
                }
        }else {
            showAlert(passedTitle: "Error Saving", passedMessage: errorMessage)
        }
        
    }

}
// MARK: - Document Picker Definition

extension ImportSketchViewController: UIDocumentPickerDelegate{
    //
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        ActivityIndicator.stopAnimating()

    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])  {
        //MARK: Initialize Global Vars
        dataInFile = ""
        voltageArray = []
        xAxisArray = []
        importDrawView.linePoint = []
        

        
        guard let selectedFileURL = urls.first else {
            return
        }
      
        //MARK: Read File Data
        do {
            
            let contents = try String(contentsOf: selectedFileURL)
            
            for data in contents.split(separator: "\n") {
                
                dataInFile = dataInFile + "\(data)"
               
            }
        }
        catch {
           
        }
        
        
        //MARK: Draw Wave From File
        
        ///Defined in DrawImportWave.swift
        let (headerInformation, voltageDataCount) = drawImportWave()
    
        
        
        print(headerInformation)
        //MARK: Checking For Errors
        (shouldSaveWave, errorMessage) = errorFinder(HeaderInformation: headerInformation, pointCount: voltageDataCount)
       
        if shouldSaveWave {
            showAlert(passedTitle: "File Read Success", passedMessage: errorMessage)
            infoDisplay(WavePropertiesArray: headerInformation)
        }else{
            showAlert(passedTitle: "Error Reading", passedMessage: errorMessage)
            //MARK: - Clear Drawing Attempt
            importDrawView.selectFileTapped = false
            
            importDrawView.linePoint = []
            WavePropertiesTextView.text = ""
            ActivityIndicator.stopAnimating()
            
            importDrawView.setNeedsDisplay()
            viewDidLoad()

        }
        
        //MARK: Wave Property Display
     
            
    }
}



