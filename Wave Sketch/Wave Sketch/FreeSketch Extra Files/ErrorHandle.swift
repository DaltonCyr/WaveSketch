//
//  ErrorHandle.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit

extension FreeSketchViewController {
    
    func ErrorFinder(HeaderInformation: [String] ) -> (Bool, String) {
        
        var errorMessage: String
        
        //MARK: - Error Checking Voltage Values Entered
        if HeaderInformation[0] == ""{
            errorMessage = "No Max Voltage Entered"
            return (false, errorMessage)
            
        }
        
        if HeaderInformation[2] == ""{
            errorMessage = "No Min Voltage Entered"
            return (false, errorMessage)
            
        }

        //MARK: - Checking Voltages For Multiple Decimals
            let maxNumberOfDecimals = HeaderInformation[0].components(separatedBy: ".")
            if maxNumberOfDecimals.count > 2{
                errorMessage = "Max Voltage Values Can Only Have One Decmial Point"
                return (false, errorMessage)
            }
        
            let minNumberOfDecimals = HeaderInformation[2].components(separatedBy: ".")
            if minNumberOfDecimals.count > 2{
                errorMessage = "Min Voltage Values Can Only Have One Decmial Point"
                return (false, errorMessage)
            }
        
        //MARK: - Error Checking For Entered Unit
        if HeaderInformation[1] == "Max Unit" || HeaderInformation[1] == "Volt Unit"{
            errorMessage = "No Max Voltage Unit Entered"
            return (false, errorMessage)
            
        }
        
        if HeaderInformation[3] == "Min Unit"  || HeaderInformation[3] == "Volt Unit"{
            errorMessage = "No Min Voltage Unit Entered"
            return (false, errorMessage)
            
        }
        
        
        //MARK: - Error Checking Max Voltage Unit With Values
        
        var maxVoltage = (HeaderInformation[0] as NSString).doubleValue
        print(maxVoltage)
        if maxVoltage > 5 && (HeaderInformation[1] == "V" || HeaderInformation[1] == "- V") {
            if HeaderInformation[1] == "V" {
                errorMessage = "Max Voltage Out Of Range For Selected Unit (Max 5V)"
                return (false, errorMessage)
            } else{
                errorMessage = "Max Voltage Out Of Range For Selected Unit (Max -5V)"
                return (false, errorMessage)
            }
            
        }
        if maxVoltage > 5000 && (HeaderInformation[1] == "mV" || HeaderInformation[1] == "- mV") {
            if HeaderInformation[1] == "mV" {
                errorMessage = "Max Voltage Out Of Range For Selected Unit (Max 5000mV)"
                return (false, errorMessage)
            } else{
                errorMessage = "Max Voltage Out Of Range For Selected Unit (Max -5000mV)"
                return (false, errorMessage)
            }
            
        }
        
    
    //MARK: - Error Checking Min Voltage Unit With Values
        var minVoltage = (HeaderInformation[2] as NSString).doubleValue
        if minVoltage > 5 && (HeaderInformation[3] == "V" || HeaderInformation[3] == "- V") {
            if HeaderInformation[3] == "V" {
                errorMessage = "Min Voltage Out Of Range For Selected Unit (Max 5V)"
                return (false, errorMessage)
            } else{
                errorMessage = "Min Voltage Out Of Range For Selected Unit (Max -5V)"
                return (false, errorMessage)
            }
            
        }
        if minVoltage > 5000 && (HeaderInformation[3] == "mV" || HeaderInformation[3] == "- mV") {
            if HeaderInformation[3] == "mV" {
                errorMessage = "Min Voltage Out Of Range For Selected Unit (Max 5000mV)"
                return (false, errorMessage)
            } else{
                errorMessage = "Min Voltage Out Of Range For Selected Unit (Max -5000mV)"
                return (false, errorMessage)
            }
        }
        
        //MARK: - Error Checking Min V Against Max V
        
        if HeaderInformation[1] == "mV"{
            maxVoltage = maxVoltage * (0.001)
        }
        if HeaderInformation[3] == "mV"{
            minVoltage = minVoltage * (0.001)
        }
        if HeaderInformation[1] == "- mV"{
            maxVoltage = maxVoltage * (-0.001)
        }
        if HeaderInformation[3] == "- mV"{
            minVoltage = minVoltage * (-0.001)
        }
        if HeaderInformation[1] == "- V"{
            maxVoltage = maxVoltage * (-1)
        }
        if HeaderInformation[3] == "- V"{
            minVoltage = minVoltage * (-1)
        }
        
        if minVoltage > maxVoltage {
            errorMessage = "Min Voltage Greater Than Max Voltage"
            return (false, errorMessage)
        }
        
        if maxVoltage != minVoltage && (maxVoltage - minVoltage < 0.01) {
            errorMessage = "Max Voltage And Min Voltage Must Have A Minimun 10mV Difference"
            return (false, errorMessage)
        }
        
        if maxVoltage == minVoltage {
            errorMessage = "Max Voltage And Min Voltage Cant Be Equal. If You Want A DC Voltage Please Go To The Guide Sketch Section"
            return (false, errorMessage)
        }
        
        //MARK: - Error Checking Frequency, Shift Entered
        if HeaderInformation[4] == "" {
            errorMessage = "No Frequency Entered"
            return (false, errorMessage)
        }
        
        //MARK: - Checking Frequency For Multiple Decimals
        let freqNumberOfDecimals = HeaderInformation[4].components(separatedBy: ".")
            if freqNumberOfDecimals.count > 2{
                errorMessage = "Frequency Value Can Only Have One Decmial Point"
                return (false, errorMessage)
            }
        let frequencyValue = (HeaderInformation[4] as NSString).doubleValue
        if frequencyValue == 0 {
            errorMessage = "Frequency Must Be Greater Than 0"
            return (false, errorMessage)
        }
        
        if HeaderInformation[6] == "" {
            errorMessage = "No Shift Entered"
            return (false, errorMessage)
        }
        
        //MARK: - Checking Shift For Multiple Decimals
        let shiftNumberOfDecimals = HeaderInformation[6].components(separatedBy: ".")
            if shiftNumberOfDecimals.count > 2{
                errorMessage = "Shift Values Can Only Have One Decmial Point"
                return (false, errorMessage)
            }
        
        
        //MARK: - Error Checking Frequency, Shift, Channel Unit
        
        if HeaderInformation[5] == "Freq Unit" {
            errorMessage = "No Frequency Unit Entered"
            return (false, errorMessage)
        }
        if HeaderInformation[7] == "Shift" || HeaderInformation[7] == "Direction" {
            errorMessage = "No Shift Unit Entered"
            return (false, errorMessage)
        }
        if HeaderInformation[8] == "Channel" || HeaderInformation[8] == "Port" {
            errorMessage = "No Port Channel Selected"
            return (false, errorMessage)
        }
        
        //MARK: - Error Checking Frequency, Shift Ranges
        var frequency = (HeaderInformation[4] as NSString).doubleValue
        let shift = (HeaderInformation[6] as NSString).doubleValue
        
        if HeaderInformation[5] == "kHZ" {
            frequency = frequency * 1000
            if frequency > 100000 {
                errorMessage = "Frequency Out Of Range (Max 100kHz)"
                return (false, errorMessage)
                
            }
            if frequencyValue < 0.001 {
                errorMessage = "Frequency Must Be Greater Than 0.001 KHZ"
                return (false, errorMessage)
            }
        }
        
        if HeaderInformation[5] == "HZ" {
            if frequency > 100000 {
                errorMessage = "Frequency Out Of Range \n (Max 100,000 HZ)"
                return (false, errorMessage)
            }
            if frequencyValue < 1 {
                errorMessage = "Frequency Must Be Greater Than 1 HZ"
                return (false, errorMessage)
            }
        }
        
        
        
        if shift > 180 {
            errorMessage = "Shift Out Of Range \n (Max 180 Degrees)"
            return (false, errorMessage)
        }
        
        if shift > 0 && HeaderInformation[7] == "N/A" {
            errorMessage = "Need Direction For A Non-Zero Shift"
            return (false, errorMessage)
        }
        if shift == 0 && (HeaderInformation[7] == "Left" || HeaderInformation[7] == "Right") {
            errorMessage = "No Shift Direction For 0 Shift"
            return (false, errorMessage)
        }
        
        print(headerInformation)
        return (true, "Saved Wave")
    }
}
