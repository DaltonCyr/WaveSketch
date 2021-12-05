//
//  GuidedSketchViewController.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/18/21.
//

import UIKit

class GuidedSketchViewController: UIViewController {
    
    
    
    
    //MARK: Importing Guide Draw View
    
    let canvas = GuidedDrawView ()
    
    @IBOutlet var guideDrawView: GuidedDrawView!
    
    
    //MARK: Button Outlets
    
    @IBOutlet weak var SquareWaveButton: UIButton!
    @IBOutlet weak var TriangleWaveButton: UIButton!
    @IBOutlet weak var SawtoothWaveButton: UIButton!
    @IBOutlet weak var TrapzoidalWaveButton: UIButton!
    @IBOutlet weak var SinusoidalWaveButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var DCWaveButton: UIButton!
    @IBOutlet weak var ClearButton: UIButton!
    
    
    //MARK: Text Feild Declarations
    @IBOutlet weak var MaxVoltage: UITextField!
    @IBOutlet weak var MinVoltage: UITextField!
    @IBOutlet weak var Frequency: UITextField!
    @IBOutlet weak var Phase: UITextField!
    @IBOutlet weak var FileName: UITextField!
    
    var currentTextFeildTag = -1
    //MARK: - Picker View Declarations
    ///Max Voltage Unit Picker
    @IBOutlet weak var VoltageUnit1: UIPickerView!
    var maxVoltageUnit = ""
    ///Min Voltage Unit Picker
    @IBOutlet weak var VoltageUnit2: UIPickerView!
    var minVoltageUnit = ""
    var voltageUnit = ["Volt Unit", "mV", "V", "- mV", "- V"]
    ///Frequency Unit Picker
    @IBOutlet weak var FrequencyUnit: UIPickerView!
    var frequencyUnit = ["Freq Unit","HZ","kHZ"]
    ///Shift Unit Picker
    @IBOutlet weak var ShiftDirection: UIPickerView!
    var shiftOptions = ["Shift","N/A", "Left", "Right"]
    ///Channel Picker
    @IBOutlet weak var Channel: UIPickerView!
    var channelOptions = ["Port","CH 1", "CH 2"]
    
    ///Header Informtion For File and Error Handle
    var headerInformation = ["Max V","Max Unit","Min V","Min Unit","Freq","Freq Unit","Shift","Direction","Channel"]
    
    
    //MARK: - Loading ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading All Picker Views
        VoltageUnit1.delegate = self
        VoltageUnit1.dataSource = self
        VoltageUnit2.delegate = self
        VoltageUnit2.dataSource = self
        FrequencyUnit.delegate = self
        FrequencyUnit.dataSource = self
        ShiftDirection.delegate = self
        ShiftDirection.dataSource = self
        Channel.delegate = self
        Channel.dataSource = self
        
        //Loading All Text Fields
        MaxVoltage.delegate = self
        MinVoltage.delegate = self
        Frequency.delegate = self
        Phase.delegate = self
        FileName.delegate = self
        
        //Loading GuideDraw View
        view.didAddSubview(canvas)
        canvas.frame = view.frame
       
        //Listening For KeyBoard Events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
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
    
    //MARK: Square Wave Button
    
    @IBAction func tapSquareWaveButton(_ sender: Any) {
        
        guideDrawView.SquareWave =      true
        guideDrawView.TriangleWave =    false
        guideDrawView.SawtoothWave =    false
        guideDrawView.TrapazoidalWave = false
        guideDrawView.DCWave =          false
        guideDrawView.SinusoidalWave =  false
        
        guideDrawView.setNeedsDisplay()
        
    }
    
    //MARK: Triangle Wave Button
    @IBAction func tapTriangleWaveButton(_ sender: Any) {

        guideDrawView.TriangleWave =    true
        guideDrawView.SquareWave =      false
        guideDrawView.SawtoothWave =    false
        guideDrawView.TrapazoidalWave = false
        guideDrawView.DCWave =          false
        guideDrawView.SinusoidalWave =  false
        
        guideDrawView.setNeedsDisplay()
    }
    
    //MARK: Sawtooth Wave Button
    @IBAction func tapSawtoothWaveButton(_ sender: Any) {
        
        guideDrawView.SawtoothWave =    true
        guideDrawView.SquareWave =      false
        guideDrawView.TriangleWave =    false
        guideDrawView.TrapazoidalWave = false
        guideDrawView.DCWave =          false
        guideDrawView.SinusoidalWave =  false
        
        guideDrawView.setNeedsDisplay()
    }
    
    //MARK: Trapazoidal Wave Button
    
    @IBAction func tapTrapazoidalWaveButton(_ sender: Any) {
        
        guideDrawView.TrapazoidalWave = true
        guideDrawView.SquareWave =      false
        guideDrawView.TriangleWave =    false
        guideDrawView.SawtoothWave =    false
        guideDrawView.SinusoidalWave =  false
        guideDrawView.DCWave =          false

        guideDrawView.setNeedsDisplay()
    }
    //MARK: DC Wave Button

    @IBAction func tapDCWaveButton(_ sender: Any) {
        
        guideDrawView.DCWave =          true
        guideDrawView.SquareWave =      false
        guideDrawView.TriangleWave =    false
        guideDrawView.SawtoothWave =    false
        guideDrawView.TrapazoidalWave = false
        guideDrawView.SinusoidalWave =  false

        guideDrawView.setNeedsDisplay()
    }
    //MARK: Sine Wave Button
    
    @IBAction func tapSineWaveButton(_ sender: Any) {
        
        guideDrawView.SinusoidalWave =  true
        guideDrawView.SquareWave =      false
        guideDrawView.TriangleWave =    false
        guideDrawView.SawtoothWave =    false
        guideDrawView.TrapazoidalWave = false
        guideDrawView.DCWave =          false
        
        guideDrawView.setNeedsDisplay()
    }
    
    // Current State of Wave Properties Indicating If Errors Are Present to Prevent Saving
    var shouldSaveWave = true
    var errorMessage:String = "Saved Wave"
    
    //MARK: Save Button
    @IBAction func tapSaveWaveButton(_ sender: Any) {
        let maxVoltageText = MaxVoltage.text
        let minVoltageText = MinVoltage.text
        let frequencyValue = Frequency.text
        let shiftDegrees = Phase.text
        
        // Updating Header Information - HeaderInformation 1,3,5,7,8 are updated within the picker functions
        headerInformation[0] = maxVoltageText ?? "No Max Voltage"
        headerInformation[2] = minVoltageText ?? "No Min Voltage"
        headerInformation[4] = frequencyValue ?? "No Frequency Value"
        headerInformation[6] = shiftDegrees ?? "No Shift Value"
        
        (shouldSaveWave, errorMessage) = ErrorFinder(HeaderInformation: headerInformation)
        
        
        
        if shouldSaveWave {
            saveFile()
            showAlert(passedTitle: "Complete", passedMessage: errorMessage)
        }else{
            showAlert(passedTitle: "Error", passedMessage: errorMessage)
        }
        
    }
    
    @IBAction func tapClearButton(_ sender: Any) {
        if guideDrawView.linePoint.count == 0 {
         
        //MARK: Sets All Text Feilds to Blank
        MaxVoltage.text = ""
        MinVoltage.text = ""
        Frequency.text = ""
        Phase.text = ""
        
        //MARK: Set Pickers To Default
        VoltageUnit1.selectRow(0, inComponent: 0, animated: true)
        VoltageUnit2.selectRow(0, inComponent: 0, animated: true)
        FrequencyUnit.selectRow(0, inComponent: 0, animated: true)
        ShiftDirection.selectRow(0, inComponent: 0, animated: true)
        Channel.selectRow(0, inComponent: 0, animated: true)
        }
        
        //MARK: Remove Wave Drawing
        guideDrawView.linePoint = []
        guideDrawView.SinusoidalWave =  false
        guideDrawView.SquareWave =      false
        guideDrawView.TriangleWave =    false
        guideDrawView.SawtoothWave =    false
        guideDrawView.DCWave =          false
        guideDrawView.TrapazoidalWave = false
        guideDrawView.setNeedsDisplay()
    }
    
}

 
    
    
        
 


