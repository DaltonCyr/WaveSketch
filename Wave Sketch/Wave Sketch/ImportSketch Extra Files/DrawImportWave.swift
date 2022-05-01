//
//  ImportHeaderFormater.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/28/21.
//

import Foundation
import UIKit

extension ImportSketchViewController {
    func drawImportWave() -> ([String], Int) {
        
        //Error Message
        compundingMessage = ""
        continueChecking = 0
        // MARK: - Formatting Read Data
        
        //Header Information
        var HeaderData = dataInFile.components(separatedBy: "$")
       
        //Cleaning Header Info
        if HeaderData.count == 11 {
            HeaderData.remove(at: 10)
            HeaderData.remove(at: 0)
            
        }else{
            compundingMessage += "Error With Header \n"
            continueChecking += 1
            return (HeaderData, 1)
            
        }
        //Formating Header Data
        var maxVoltage = (HeaderData[0] as NSString).doubleValue
        var minVoltage = (HeaderData[2] as NSString).doubleValue
        let maxVoltageSign = HeaderData[1]
        let minVoltageSign = HeaderData[3]
        
        // MARK: - Max Voltage Sign
        switch maxVoltageSign {
        case "- V ":
            maxVoltage = maxVoltage * (-1)
            HeaderData[0] = "\(maxVoltage)"

        case "- mV ":
            maxVoltage = maxVoltage * (-0.001)
            HeaderData[0] = "\(maxVoltage)"
        case "mV ":
            maxVoltage = maxVoltage * (0.001)
            HeaderData[0] = "\(maxVoltage)"
        case "V ":
            maxVoltage = maxVoltage * (1)
            HeaderData[0] = "\(maxVoltage)"
        default:
           print("ERROR WITH MAX VOLTAGE")
        }
        // MARK: - Min Voltage Sign
        switch minVoltageSign {
        case "- V ":
            
            minVoltage = minVoltage * (-1)
            HeaderData[2] = "\(minVoltage)"
         
        case "- mV ":
            minVoltage = minVoltage * (-0.001)
            HeaderData[2] = "\(minVoltage)"
        case "mV ":
            minVoltage = minVoltage * (0.001)
            HeaderData[2] = "\(minVoltage)"
        case "V ":
            minVoltage = minVoltage * (1)
            HeaderData[2] = "\(minVoltage)"
        default:
           print("ERROR WITH MIN VOLTAGE")
        }
        
        
        
        //MARK: Wave Point Information
        var dataPointArray = dataInFile.components(separatedBy: ":")
        dataPointArray.remove(at: 0)
        
        //Testing All Point Values for Letters and Foreign Chars
        
        var lettersInData = 0
        var foreignCharInData = 0
        
        //MARK: Data Point Testing
        for i in stride(from: 1, through: dataPointArray.count-1, by: 1) {
            //Letter Test
            let letters = CharacterSet.letters

            let phrase = dataPointArray[i]

            let range = phrase.rangeOfCharacter(from: letters)

            if range != nil {
                print("Letters Found")
                lettersInData += 1
                
            }
            
            //Foreign Char Test
            let charset = NSCharacterSet(charactersIn: "!@#%^&*()_=+}]{[;'?/><,~`|")
            if let _ = phrase.rangeOfCharacter(from: charset as CharacterSet, options: .caseInsensitive) {
               print("Foriegn Chars")
                foreignCharInData += 1
            }
        }
        
        if lettersInData > 0 && foreignCharInData > 0 {
            compundingMessage += "There Are Letters and Foreign Chars In Voltage Data \n"
            continueChecking += 1
        }
        if lettersInData > 0 && foreignCharInData == 0 {
            compundingMessage += "There Are Letters In Voltage Data \n"
            continueChecking += 1
        }
        if foreignCharInData > 0 && lettersInData == 0 {
            compundingMessage += "There Are Foreign Chars In Voltage Data \n"
            continueChecking += 1
        }
        
        
        
        //MARK: - Isolating The Voltage from the Values
        var maxVoltageError = 0
        var minVoltageError = 0
        var missingVoltageCount = 0
        voltageArray = []
        
        for i in stride(from: 2, through: dataPointArray.count-1, by: 3) {
            
            if dataPointArray[i] == "" {
                missingVoltageCount += 1
            }
            
            let voltageValue = (dataPointArray[i] as NSString).doubleValue
            
            //THROW ERROR IF A VOLT DATA POINT LARGER THAN MAX VOLTAGE
            if voltageValue > (maxVoltage + 0.0001) {
                maxVoltageError += 1
            
            }
            //THROW ERROR IF A VOLT DATA POINT SMALLER THAN MIN VOLTAGE

            if voltageValue < (minVoltage - 0.0001)  {
                minVoltageError += 1
                print(voltageValue)
                print("----------")
                print(minVoltage)
            
            }
            //NO ERROR STORE THE POINT
            voltageArray.append(voltageValue)
            
        }
        
        if missingVoltageCount > 0 {
            compundingMessage += "There Are \(missingVoltageCount) Voltage Data Points Missing  \n"
            continueChecking += 1
        }
        
        if maxVoltageError > 0 {
            compundingMessage += "There Are Voltage Data Values Larger Than The Declared Max V \n"
            continueChecking += 1
        }
        
        if minVoltageError > 0{
            compundingMessage += "There Are Voltage Data Values Smaller Than The Declared Min V \n"
            continueChecking += 1
        }
        
        var xCount:Double = 0
        //MARK: - Test For X Axis Numbering Error
        
        var xAxisError = 0
        for i in stride(from: 1, through: dataPointArray.count-1, by: 3){
            let xAxisValue = (dataPointArray[i] as NSString).doubleValue
            if xAxisValue != xCount {
                xAxisError += 1
                
            }
            xCount += 1
            
        }
        
        if xAxisError > 0 {
            compundingMessage += "There Are X Axis Data Points Out Of Order \n"
            continueChecking += 1
        }
        
        var channelValue:Double = 0
        if HeaderData[8] == "CH 1 "{
            channelValue = 1
        }else if HeaderData[8] == "CH 2 "{
            channelValue = 2
        }else{
            
        }
        
        print("\(channelValue) = Channel Value")
        
        var channelDeclarationError = 0
        for i in stride(from: 0, through: dataPointArray.count-1, by: 3){
            let readChannelValue = (dataPointArray[i] as NSString).doubleValue
            if readChannelValue != channelValue || channelValue == 0 {
                channelDeclarationError += 1
            }
        }
        

        
        if voltageArray.count != 15360 {
            compundingMessage += "Missing \(15360 - voltageArray.count) Data Values"
            continueChecking += 1
        }
        
        
        if continueChecking > 0 {
            return (HeaderData, -1)
        }
        
        //MARK: Volt To Y Point
        var yAxisArray = [Double]()
        ///Volt to Y Value Function Defined in VoltageListConverter.swift
        
        //This if is for DC wave
        if maxVoltage == minVoltage {
            for _ in 0...65535 {
                yAxisArray.append(200)
            }
            
            let xIncrement:Double = 0.00457764
           
            for i in 0...65535 {
                xAxisArray.append(50 + (xIncrement * Double(i)))
            }
            //Else if for all other options
        }else{
            
            yAxisArray = VoltageToYValue(HeaderInformation: HeaderData, ListOfVoltages: voltageArray)
            
            if yAxisArray == [] {
                continueChecking += 1
                
            }else{
            
            let xIncrement:Double = 300 / Double(yAxisArray.count)
            
            for i in 0...yAxisArray.count-1 {
                xAxisArray.append(50 + (xIncrement * Double(i)))
            }
        }
        }
        
        
        //Creating Drawing
        
            for i in stride(from: 0, through: yAxisArray.count-1, by: 1){
                importDrawView.linePoint.append(CGPoint(x: xAxisArray[i], y: yAxisArray[i]))
            }
        
        
        
        importDrawView.setNeedsDisplay()
        
        endActivityIndicator = true
        
        if endActivityIndicator {
            ActivityIndicator.stopAnimating()
        }
        return (HeaderData, voltageArray.count)
    }
    
}
