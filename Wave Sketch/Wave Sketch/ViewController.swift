//
//  ViewController.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/13/21.
//

import UIKit
import SafariServices

// Create a canvas class to make drawing


class ViewController: UIViewController, SFSafariViewControllerDelegate {

    
    @IBOutlet weak var FreeSketchModeButton: UIButton!
    @IBOutlet weak var WebSiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapWebSiteButton(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://howdy.tamu.edu/uPortal/normal/render.uP")!)
        
        present(vc, animated: true, completion: nil)
    }
    
    
}





