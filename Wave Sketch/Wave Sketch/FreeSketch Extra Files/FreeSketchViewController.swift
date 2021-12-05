//
//  FreeSketchViewController.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/18/21.
//

import UIKit

class FreeSketchViewController: UIViewController {
   
    

    // MARK: - Free DrawView Definition

    let canvas = FreeDrawVeiw()
    
    
    @IBOutlet var freeDrawView: FreeDrawVeiw!
    
    @IBOutlet weak var SaveWaveButton: UIButton!
    @IBOutlet var ClearFreeSketchButton: UIButton!
    @IBOutlet var FixDrawing: UIButton!

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
    @IBOutlet weak var VoltageUnit2: UIPickerView!
    var minVoltageUnit = ""
    var voltageUnit = ["Volt Unit", "mV", "V", "- mV", "- V"]

    @IBOutlet weak var FrequencyUnit: UIPickerView!
    var frequencyUnit = ["Freq Unit","HZ","kHZ"]

    @IBOutlet weak var ShiftDirection: UIPickerView!
    var shiftOptions = ["Shift","N/A", "Left", "Right"]

    @IBOutlet weak var Channel: UIPickerView!
    var channelOptions = ["Port","CH 1", "CH 2"]
    
    var headerInformation = ["Max V","Max Unit","Min V","Min Unit","Freq","Freq Unit","Shift","Direction","Channel"]
    
    //MARK:Loading View
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // MARK:Loading All Picker Views
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
        
        //MARK:Loading All Text Fields
        MaxVoltage.delegate = self
        MinVoltage.delegate = self
        Frequency.delegate = self
        Phase.delegate = self
        FileName.delegate = self
        
      
        view.didAddSubview(canvas)
        
        canvas.frame = view.frame
    
        //Listening For KeyBoard Events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // MARK: - Clear Drawing Definition


    @IBAction func tapClearFreeSketchButton(){
        print("Clear pressed")
        
        if freeDrawView.linePoint.count == 0 {
         
        //MARK: Sets All Text Feilds to Blank
        MaxVoltage.text = ""
        MinVoltage.text = ""
        Frequency.text = ""
        Phase.text = ""
        FileName.text = ""
        
        //MARK: Set Pickers To Default
        VoltageUnit1.selectRow(0, inComponent: 0, animated: true)
        VoltageUnit2.selectRow(0, inComponent: 0, animated: true)
        FrequencyUnit.selectRow(0, inComponent: 0, animated: true)
        ShiftDirection.selectRow(0, inComponent: 0, animated: true)
        Channel.selectRow(0, inComponent: 0, animated: true)
        }
        
        //MARK: Remove Drawing
        freeDrawView.linePoint = []
        freeDrawView.nonLine = []
        freeDrawView.setNeedsDisplay()
        
    }
    // MARK: - Fix Drawing Deffinition

    @IBAction func tapFixDrawingButton(){
        print(" Contiue Drawing")
        
        if freeDrawView.linePoint.count >= 1 {
            freeDrawView.linePoint.remove(at: freeDrawView.linePoint.count-1)
            freeDrawView.nonLine.remove(at: freeDrawView.nonLine.count-1)
            freeDrawView.setNeedsDisplay()
        }
        if freeDrawView.linePoint.count < 1 {
            freeDrawView.linePoint = []
            freeDrawView.nonLine = []
            freeDrawView.setNeedsDisplay()
            showAlert(passedTitle: "Attention", passedMessage: "All Points Removed")
        }
    }
        
   
    
    // MARK: - Save Drawing Deffinition

    var shouldSaveWave = true
    var errorMessage:String = "Saved Wave"
    @IBAction func tapSaveWaveButton(_ sender: Any) {
    
        //Defined In FreeSaveFile.swift
        saveFile()
    }
}














