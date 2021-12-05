//
//  HelpViewController.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/19/21.
//

import UIKit
import SafariServices

class HelpViewController: UIViewController, UITextViewDelegate, SFSafariViewControllerDelegate {

    
    @IBOutlet weak var WaveInputHelp: UITextView!
    @IBOutlet weak var FreeSketchHelp: UITextView!
    @IBOutlet weak var GuideSketchHelp: UITextView!
    @IBOutlet weak var ImportSketchHelp: UITextView!
    @IBOutlet weak var WebSiteHelpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WaveInputHelp.delegate = self
        WaveInputHelp.text = readFile(FileName: "InputHelpTxt")
        FreeSketchHelp.delegate = self
        FreeSketchHelp.text = readFile(FileName: "FreeSketchHelpTxt")
        GuideSketchHelp.delegate = self
        GuideSketchHelp.text = readFile(FileName: "GuideHelpTxt")
        ImportSketchHelp.delegate = self
        ImportSketchHelp.text = readFile(FileName: "ImportSketchHelpTxt")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    @IBAction func tapWebsiteButton(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://howdy.tamu.edu/uPortal/normal/render.uP")!)
        
        present(vc, animated: true, completion: nil)
    }
    
    
    func readFile(FileName: String) -> String {
        let fileURL = Bundle.main.path(forResource: FileName, ofType: "txt")
        var readFileString = ""
        do {
            readFileString = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
            
        } catch let error as NSError{
            print("Failed")
            print(error)
        }
        
        return readFileString
    }
    

}
