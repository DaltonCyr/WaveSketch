//
//  ImportErrorHandle.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/28/21.
//

import Foundation
import UIKit

extension ImportSketchViewController {
    
    
    
    func errorFinder(HeaderInformation: [String], pointCount: Int) -> (Bool, String) {
        
        
        
        //MARK: Check For Header
        if (HeaderInformation.count < 9) || (HeaderInformation.count > 9) {
            compundingMessage += "Number Of Header Entries Is Incorrect. Correct Number is 9 and the File Has \(HeaderInformation.count-1) \n"
            continueChecking += 1
            return(false, compundingMessage)
            
        }else{
            
        
            //MARK: Check For Letters And Foreign Chars
                    
            //MARK: Check For Voltage Values
            
            
            
            
            
            //MARK: Check For Actual Voltage Values
            if HeaderInformation[0] == " " || HeaderInformation[0] == ""{
                continueChecking += 1
                compundingMessage += "Error Missing Max V Value \n"
                
            }
            if HeaderInformation[2] == " " || HeaderInformation[2] == ""{
                continueChecking += 1
                compundingMessage += "Error Missing Min V Value \n"
                
            }
            //MARK: Check For Actual Frequency Value
            if HeaderInformation[4] == " " || HeaderInformation[4] == ""{
                continueChecking += 1
                compundingMessage += "Error Missing Frequency Value \n"
                
            }
                    
            //MARK: Check For Actual Shift Value
            if HeaderInformation[6] == " " || HeaderInformation[6] == ""{
                continueChecking += 1
                compundingMessage += "Error Missing Shift Value \n"
                
            }
            
            //MARK: Check V Range
            if abs((HeaderInformation[0] as NSString).doubleValue) > 5 || abs((HeaderInformation[0] as NSString).doubleValue) < 0.00001  {
                continueChecking += 1
                compundingMessage += "Error With Max Voltage Range \n"
            }
            
            if abs((HeaderInformation[2] as NSString).doubleValue) > 5 || (abs((HeaderInformation[2] as NSString).doubleValue) - 0.000001) < -0.000001 {
                continueChecking += 1
                compundingMessage += "Error With Min Voltage Range \n"
            }
            //MARK: Checking Max V Unit
            
            switch HeaderInformation[1] {
            case "V ":
                continueChecking += 0
            case "- V ":
                continueChecking += 0
            case "mV ":
                continueChecking += 0
            case "- mV ":
                continueChecking += 0
            default:
                continueChecking += 1
                compundingMessage += "Error Reading Max Voltage Unit \n"
            }
            
            //MARK: Checking Min V Unit
            switch HeaderInformation[3] {
            case "V ":
                continueChecking += 0
            case "- V ":
                continueChecking += 0
            case "mV ":
                continueChecking += 0
            case "- mV ":
                continueChecking += 0
            default:
                continueChecking += 1
                compundingMessage += "Error Reading Min Voltage Unit \n"
            }
            
            
            
            //MARK: Checking Frequency Unit
            var frequencyValue = (HeaderInformation[4] as NSString).doubleValue
            switch HeaderInformation[5] {
            case "HZ ":
                continueChecking += 0
                
                
            case "KHZ ":
                continueChecking += 0
                frequencyValue *= 1000
            default:
                continueChecking += 1
                compundingMessage += "Error Reading Frequency Unit \n"
            }
            
            if frequencyValue > 100000 || frequencyValue < 1{
                continueChecking += 1
                compundingMessage += "Error  Frequency Out of Range \n"
            }
            
            //MARK: Checking Shift Range
            let shift = (HeaderInformation[6] as NSString).doubleValue
            
            if shift > 180 || shift < 0 {
                continueChecking += 1
                compundingMessage += "Error Shift Degrees Out of Range \n"
            }
            
            if shift == 0 && (HeaderInformation[7] == "Left " || HeaderInformation[7] == "Right "){
                continueChecking += 1
                compundingMessage += "Error Shift Direction Incorrect for No Shift\n"
            }
            
            switch HeaderInformation[7] {
            case "N/A ":
                continueChecking += 0
            case "Right ":
                continueChecking += 0
            case "Left ":
                continueChecking += 0
            default:
                continueChecking += 1
                compundingMessage += "Error Shift Direction Incorrect \n"

            }
            
            //MARK: Check Channel
            switch HeaderInformation[8] {
            case "BNC Port 1 ":
                continueChecking += 0
            case "BNC Port 2 ":
                continueChecking += 0
                
            default:
                continueChecking += 1
                compundingMessage += "Error Incorrect Channel Declaration \n"
            }
            
            //MARK: Check Number of Inputs
            if pointCount != 15360 && pointCount != -1 {
                continueChecking += 1
                compundingMessage += "Error Number of Point Values Is Incorect, You need 15360 and you have \(pointCount) \n"
            }
            
            //MARK: Check Data Values For Out Of Range Voltage
            
            
            
            
            
            if continueChecking > 0 {
                return (false, compundingMessage)
            }
            else{
            return (true, "Completed Error Check")
            }
        }
    }
    
}
