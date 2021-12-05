//
//  WaveInfoDisplay.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/28/21.
//

import Foundation
import UIKit

extension ImportSketchViewController {
    
    func infoDisplay(WavePropertiesArray: [String])  {
        
        //Fist Header Information Voltage
        WavePropertiesTextView.text = "(" + WavePropertiesArray[0] + "," + WavePropertiesArray[2] + ") V"
        
        //Second Header Information is Frequency
        WavePropertiesTextView.text = WavePropertiesTextView.text + " at \(WavePropertiesArray[4]) \(WavePropertiesArray[5]) \n"
        
        //Third Header Information is shift and direction
        if WavePropertiesArray[7] == "N/A "{
            WavePropertiesTextView.text = WavePropertiesTextView.text + "0 Degree Shift at \(WavePropertiesArray[8]) "
        }else {
            WavePropertiesTextView.text = WavePropertiesTextView.text + "\(WavePropertiesArray[6]) Degree Shift \(WavePropertiesArray[7]) Going to \(WavePropertiesArray[8]) "
            
        }
    }
    
   
    
    
}
