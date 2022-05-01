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
    
    //MARK: Menu Button Outlets
    @IBOutlet weak var maxVoltageUnitMenu: UIButton!
    @IBOutlet weak var minVoltageUnitMenu: UIButton!
    @IBOutlet weak var frequencyUnitMenu: UIButton!
    @IBOutlet weak var outputChannelMenu: UIButton!

    //MARK: Text Feild Declarations
    @IBOutlet weak var MaxVoltage: UITextField!
    @IBOutlet weak var MinVoltage: UITextField!
    @IBOutlet weak var Frequency: UITextField!
    @IBOutlet weak var Phase: UITextField!
    @IBOutlet weak var FileName: UITextField!
    var currentTextFeildTag = -1
    
    
    var headerInformation = ["Max V","V","Min V","- V","Frequency","HZ","0","N/A","BNC Port 1"]
    
    //MARK:Loading View
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // MARK:Loading All Menu Buttons
        frequencyMenu()
        minVoltageMenu()
        maxVoltageMenu()
        channelMenu()
        //MARK:Loading All Text Fields
        MaxVoltage.delegate = self
        MinVoltage.delegate = self
        Frequency.delegate = self
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
        freeDrawView.trackedBackwardsDraw = false
        if freeDrawView.linePoint.count == 0 {
         
        //MARK: Sets All Text Feilds to Blank
        MaxVoltage.text = ""
        MinVoltage.text = ""
        Frequency.text = ""
        
        FileName.text = ""
    
        }
        
        //MARK: Remove Drawing
        freeDrawView.linePoint = []
        freeDrawView.nonLine = []
        freeDrawView.setNeedsDisplay()
        
    }
    // MARK: - Fix Drawing Deffinition

    @IBAction func tapFixDrawingButton(){
        print(" Contiue Drawing")
        freeDrawView.trackedBackwardsDraw = false
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














