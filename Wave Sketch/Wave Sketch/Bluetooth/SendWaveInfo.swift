//
//  SendWaveInfo.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 1/28/22.
//

import Foundation
import UIKit
import CoreBluetooth
import UniformTypeIdentifiers

extension ConnectAWGViewController {
    
    func infoDisplay(WavePropertiesArray: [String])  {
        
        WaveInfoDisplay.text = ""
        
        WaveInfoDisplay.text = "Wave Properties \n \n"
        
        //Fist Header Information Voltage
        if WavePropertiesArray[1] == "- V " && WavePropertiesArray[3] == "- V "{
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Max Voltage: -\(WavePropertiesArray[0])V\n"
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Min Voltage: -\(WavePropertiesArray[2])V\n"
        }
        else if WavePropertiesArray[1] == "V " && WavePropertiesArray[3] == "- V "{
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Max Voltage: \(WavePropertiesArray[0])V\n"
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Min Voltage: -\(WavePropertiesArray[2])V\n"
        }else if WavePropertiesArray[1] == "- V " && WavePropertiesArray[3] == "V "{
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Max Voltage: -\(WavePropertiesArray[0])V\n"
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Min Voltage: \(WavePropertiesArray[2])V\n"
        }
        else{
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Max Voltage: \(WavePropertiesArray[0])V\n"
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Min Voltage: \(WavePropertiesArray[2])V\n"
        }
        //Second Header Information is Frequency
        WaveInfoDisplay.text = WaveInfoDisplay.text + "Frequency: \(WavePropertiesArray[4]) \(WavePropertiesArray[5]) \n"
        
        //Third Header Information is shift and direction
        if WavePropertiesArray[7] == "N/A "{
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Phase Shift: 0 Degrees \nChannel: \(WavePropertiesArray[8]) "
        }else {
            WaveInfoDisplay.text = WaveInfoDisplay.text + "Phase Shift: \(WavePropertiesArray[6]) Degree Shift \(WavePropertiesArray[7])\nChannel: \(WavePropertiesArray[8]) "
            
        }
    }
    
}
