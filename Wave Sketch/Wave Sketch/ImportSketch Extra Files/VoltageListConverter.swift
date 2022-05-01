//
//  VoltageListConverter.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/25/21.
//

import Foundation
import UIKit

extension ImportSketchViewController {
    
    func VoltageToYValue(HeaderInformation: [String], ListOfVoltages: [Double]) -> [Double] {
        
        print("\(ListOfVoltages.count) = The Count -----")
        
        var alteredVoltageList = ListOfVoltages
        var yAxisPoints = [Double]()
        
        if ListOfVoltages.count < 15360 || ListOfVoltages.count > 15360{
            print("Returned")
            continueChecking += 1
            compundingMessage += "Error Number of Voltage Values Is Incorect, You need 5210 and you have \(ListOfVoltages.count) \n"
            return []
            
        }
        
        
        var maxVoltageValue = (HeaderInformation[0] as NSString).doubleValue
        var minVoltageValue = (HeaderInformation[2] as NSString).doubleValue
        
        //MARK: Shifting Voltage Values to go from zero up
       
        if minVoltageValue <= 0{
            for i in 0...alteredVoltageList.count-1{
                alteredVoltageList[i] = alteredVoltageList[i] + ((-1) * minVoltageValue)
                
            }
            maxVoltageValue += ((-1) * minVoltageValue)
            minVoltageValue += ((-1) * minVoltageValue)
            
            print(maxVoltageValue)
        }
        
        for i in 0...alteredVoltageList.count-1{
            let percentageVoltageMax = (alteredVoltageList[i]) / maxVoltageValue
            let yValue = 300 - (200 * percentageVoltageMax)
            yAxisPoints.append(yValue)
            
        }
       
        return yAxisPoints
    }
}
