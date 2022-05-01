//
//  DataSeperation.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 1/28/22.
//

import Foundation
import UIKit
import CoreBluetooth
import UniformTypeIdentifiers

extension ConnectAWGViewController {
    
    func getHeader(dataInFile : String) -> [String] {
        var HeaderData = dataInFile.components(separatedBy: "$")
        HeaderData.remove(at: 10)
        HeaderData.remove(at: 0)
        return HeaderData
    }
    
    func getWaveValues(dataInFile : String) ->[String] {
        var waveValues = dataInFile.components(separatedBy: ":")
        waveValues.remove(at: 0)
        var voltageValues = [String]()
        var xValues = [String]()
        
        
        for i in stride(from: 1, through: waveValues.count-1, by: 3){
            
            xValues.append(waveValues[i])
            
        }
        
        for i in stride(from: 2, through: waveValues.count-1, by: 3){
            
            voltageValues.append(waveValues[i])
            
        }
    return voltagetToDecimalBitValue(voltageArray: voltageValues)
                
    }
    
    func voltagetToDecimalBitValue (voltageArray: [String] ) -> [String] {
        var wavePoints = [String]()
        let bitVoltageStep:Double = 5 / 32767
        var listprinter = ""
        
        for i in 0...voltageArray.count-1 {
             
            let doubleVoltageValue = (voltageArray[i] as NSString).doubleValue
            
            let convertedVoltageDecimal = round(doubleVoltageValue / bitVoltageStep)
            
            let shiftedConvertedVoltageDecimal = Int(convertedVoltageDecimal) + 32767
            
            wavePoints.append("\(shiftedConvertedVoltageDecimal),")
            listprinter = listprinter + "\(wavePoints[i])"
            //print(wavePoints[i])
            
        }
    print(listprinter)
        
        return wavePoints
        
    }
    
    
    
}
