//
//  ImportSaveFile.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/28/21.
//

import Foundation
import UIKit

extension ImportSketchViewController {
    
    func saveImportWave() -> Bool {
        
        var channelNumber = 0
        var xArray = [Double]()
        
        //MARK: Header Information
        var HeaderData = dataInFile.components(separatedBy: "$")
       
        //Cleaning Header Info
        HeaderData.remove(at: HeaderData.count-1)
        HeaderData.remove(at: 0)
        
       
        if HeaderData[8] == "BNC Port 1 "{
            channelNumber = 1
        }
        if HeaderData[8] == "BNC Port 2 "{
            channelNumber = 2
        }
        
        //MARK: Wave Point Information
        var dataPointArray = dataInFile.components(separatedBy: ":")
        dataPointArray.remove(at: 0)
        
        //Isolating The Voltage from the Values
        for i in stride(from: 0, through: dataPointArray.count-1, by: 3) {
            
            let xValue = (dataPointArray[i+1] as NSString).doubleValue
            xArray.append(xValue)
        }
        
        var contents = ""
        
        for i in 0...8 {
            contents = contents + "$\(HeaderData[i])"
        }
        contents = contents + "$\n"
        
        for i in 0...voltageArray.count-1 {
            contents = contents + ":\(channelNumber):\(xArray[i]):\(voltageArray[i]) \n"
        }
        
        
        let fileDescription: String = chooseWaveFileName() + "  : ImportSketch - ID :"
        
        let file = "\(fileDescription) " + " \(UUID().uuidString) .txt"
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        //creating the file URL by appending (going a sub section) of the documents directory
        let fileURL = directory.appendingPathComponent(file)
        
        
        // Do catch block to try writing
        do{
            
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)     }
        catch{
            return false
        }
        
        return true
    }
    
    // MARK: - File Name Definition
    func chooseWaveFileName() -> String {
        let chosenFileName = FileName.text ?? "ImportSketch"
        print(chosenFileName)
        return chosenFileName
    }
    
}
