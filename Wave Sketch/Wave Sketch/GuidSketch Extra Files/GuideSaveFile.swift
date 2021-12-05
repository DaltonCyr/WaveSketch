//
//  GuideSaveFile.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit
extension GuidedSketchViewController {
    
    func saveFile() {
        // MARK: - Getting Values in Text Fields
        let drawingPoints = guideDrawView.linePoint
        
        let maxVoltageText = MaxVoltage.text
        let minVoltageText = MinVoltage.text
        let frequencyValue = Frequency.text
        let shiftDegrees = Phase.text
        
        // This is for error Handle
        headerInformation[0] = maxVoltageText ?? "No Max Voltage"
        headerInformation[2] = minVoltageText ?? "No Min Voltage"
        headerInformation[4] = frequencyValue ?? "No Frequency Value"
        headerInformation[6] = shiftDegrees ?? "No Shift Value"
        
        var maxVoltage = (headerInformation [0] as NSString).doubleValue
        let maxVoltageSign = headerInformation [1]
        var minVoltage = (headerInformation [2] as NSString).doubleValue
        let minVoltageSign = headerInformation [3]
        var channelNumber = 0
        if headerInformation[8] == "CH 1"{
            channelNumber = 1
        }
        if headerInformation[8] == "CH 2"{
            channelNumber = 2
        }
        
        
        var numOfPointsPerSection = [Float]()
        var sectionLengthList = [Float]()
        var percentageList = [Float]()
        
        // MARK: - Max Voltage Sign
        switch maxVoltageSign {
        case "- V":
            maxVoltage = maxVoltage * (-1)

        case "- mV":
            maxVoltage = maxVoltage * (-0.001)

        case "mV":
            maxVoltage = maxVoltage * (0.001)
        case "V":
            maxVoltage = maxVoltage * (1)
        default:
           print("ERROR WITH MAX VOLTAGE")
        }
        // MARK: - Min Voltage Sign
        switch minVoltageSign {
        case "- V":
            minVoltage = minVoltage * (-1)
         
        case "- mV":
            minVoltage = minVoltage * (-0.001)

        case "mV":
            minVoltage = minVoltage * (0.001)
            
        case "V":
            minVoltage = minVoltage * (1)
        default:
           print("ERROR WITH MIN VOLTAGE")
        }

        // Error Handle For Voltage Input - Do cases
        
        
        (shouldSaveWave, errorMessage) = ErrorFinder(HeaderInformation: headerInformation)
        
        if drawingPoints.count == 0 {
            showAlert(passedTitle: "Error", passedMessage: "Must Draw A Wave")
            shouldSaveWave = false
        }
        
        if drawingPoints.count > 3 && drawingPoints[drawingPoints.count-1].x < drawingPoints[drawingPoints.count-2].x  {
            showAlert(passedTitle: "Error", passedMessage: "Recorded Backwards Draw \n Press Fix Drawing And Try Redrawing")
            shouldSaveWave = false
        }
        // MARK: - Save Starting
        
        // MARK: - Defining The Percentages and Points per Section
        if shouldSaveWave == true {
            
        let xAxisSlots = 65536
        let totalLengthOfDraw = Float(drawingPoints[drawingPoints.count - 1].x - drawingPoints[0].x)
        let singlePointPercentage: Float = 100 / Float(xAxisSlots)
        let percentageLeftToBeFilled = (Float(xAxisSlots) - Float(drawingPoints.count)) * singlePointPercentage

        //Filling The Legth List with length between the Drawn Points
        for i in 0...drawingPoints.count - 2 {
            let lengthBetweenTwoPoints = abs(Float(drawingPoints[i + 1].x - drawingPoints[i].x))
            
            sectionLengthList.append(lengthBetweenTwoPoints)
            }

        //Filling The Percentage List to determine how much percentage each section gets of the avaliable points
        for i in 0...sectionLengthList.count-1 {
            let percentageRatioOfLength = (sectionLengthList[i] / totalLengthOfDraw) * percentageLeftToBeFilled
            percentageList.append(percentageRatioOfLength)
            }
        //print(numOfPointsPerSection)

        // Modulating percentages to round up or down to nearest point
        for i in 0...percentageList.count-1 {
            let numOfPoints = Int(percentageList[i] / singlePointPercentage)
            numOfPointsPerSection.append(Float(numOfPoints))
            
        }
        
         

        // MARK: - Fixing Number of Points


        var pointCountCheck = 0
        for i in 0...numOfPointsPerSection.count-1 {
            pointCountCheck = pointCountCheck + Int(numOfPointsPerSection[i])

        }
        pointCountCheck = pointCountCheck + drawingPoints.count
        
        var lowestValueIndex = 0
        var copyOfPercentageList = percentageList
        var lowestPercentage = copyOfPercentageList[0]
        
        // MARK: - Not Enough Points

        //Will Always be not enough points because always rounded down percentages
        while(pointCountCheck < xAxisSlots) {
            
                for i in 0...copyOfPercentageList.count-1 {
                    if copyOfPercentageList[i] < lowestPercentage {
                        lowestValueIndex = i
                    }
                }
                
                numOfPointsPerSection[lowestValueIndex] = numOfPointsPerSection[lowestValueIndex] + 1
                pointCountCheck = pointCountCheck + 1
                
                //Stopping the array from being out of bounds
                if copyOfPercentageList.count < lowestValueIndex {
                    copyOfPercentageList = percentageList
                }
                //Removing the sections that have already had points removed
                else {
                copyOfPercentageList.remove(at: lowestValueIndex)
                }
                lowestPercentage = copyOfPercentageList[0]
                
            }



        // MARK: - Filling The points between drawn points with values
        var alteredDrawnPoints = [CGPoint] ()
        alteredDrawnPoints.append(CGPoint(x: drawingPoints[0].x, y: drawingPoints[0].y))
        for i in 0...numOfPointsPerSection.count-1 {
            
            
            
            let slopeOfTwoPoints = Float(drawingPoints[i+1].y - drawingPoints[i].y) / (Float(drawingPoints[i+1].x - drawingPoints[i].x) + 0.00001)
            let xIncrement = Float(drawingPoints[i+1].x - drawingPoints[i].x) / (numOfPointsPerSection[i] + 1)
            let yIncrement = slopeOfTwoPoints * xIncrement
            let numberOfPoints = Int(numOfPointsPerSection[i])
           
            // MARK: - Truncating
            for _ in 0...numberOfPoints {
                ///Truncating the X and Y values decrease size of the file
                let xValue = round((alteredDrawnPoints[alteredDrawnPoints.count-1].x + CGFloat(xIncrement)) * 10000) / 10000
                let yValue = round((alteredDrawnPoints[alteredDrawnPoints.count-1].y + CGFloat(yIncrement)) * 10000) / 10000
                alteredDrawnPoints.append(CGPoint(x: xValue, y: yValue))
            }
        }
        
        // MARK: - Change points to (CH,X,V)
        ///Getting Data Input
         
        //Finding Max Voltage iPhone point and Min voltage iPhone point and Ranges
        var maxVoltage_yPoint:CGFloat = 1000
        var minVoltage_yPoint:CGFloat = -1
        for i in 0...alteredDrawnPoints.count - 1 {
            ///inverted due to the iphone graph being top y=0 bottom y= 800
            if alteredDrawnPoints[i].y > minVoltage_yPoint {
                minVoltage_yPoint = alteredDrawnPoints[i].y
            }
            if alteredDrawnPoints[i].y < maxVoltage_yPoint {
                maxVoltage_yPoint = alteredDrawnPoints[i].y
            }
            
        }
        
        
        
        let point_yRange:CGFloat = (minVoltage_yPoint - maxVoltage_yPoint)
        let voltageRange = CGFloat(maxVoltage - minVoltage)
       
        // MARK: - Y to Voltage
        if guideDrawView.DCWave == true {
            for i in 0...65535 {
                let xValue = CGFloat(i)
                let yValue = CGFloat(maxVoltage)
                alteredDrawnPoints[i] = CGPoint(x: xValue, y: yValue)
                
            }
        }else{
        
            for i in 0...alteredDrawnPoints.count-1 {
            
                let voltageRatio = ((minVoltage_yPoint - alteredDrawnPoints[i].y) / point_yRange) * voltageRange
                        
                alteredDrawnPoints[i] = CGPoint(x: CGFloat(i), y: round((CGFloat(minVoltage) + voltageRatio) * 10000) / 10000)
           // print(alteredDrawnPoints[i])
        }
    }

        
        // MARK: - This creates a uniuqe file name so nothing is over written
        
        let fileDescription: String = chooseWaveFileName() + "  : GuideSketch - ID :"
        print(fileDescription)
        let file = "\(fileDescription) " + " \(UUID().uuidString) .txt"
        
        //filling the contnents string full of all the CGPoints from the graph
        var contenets = ""
        
        for i in 0...8 {
            
            contenets = contenets + "$\(headerInformation[i]) "
        }
            
            contenets = contenets + "$\n"
        
        for i in 0...alteredDrawnPoints.count-1 {
            let intVersionX = Int(alteredDrawnPoints[i].x)
            contenets = contenets + ":\(channelNumber):\(intVersionX):\(alteredDrawnPoints[i].y) \n"        }
        
        // MARK: - File Directory
                        ///opening file manager to give directory the url location of the documents location
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        //creating the file URL by appending (going a sub section) of the documents directory
        let fileURL = directory.appendingPathComponent(file)
        
        
        // Do catch block to try writing
        do{
            
            try contenets.write(to: fileURL, atomically: false, encoding: .utf8)     }
        catch{
        }
            
        showAlert(passedTitle: "Complete", passedMessage: errorMessage)
            print(alteredDrawnPoints.count)

        }
        else{
            showAlert(passedTitle: "Error", passedMessage: errorMessage)
            print("DIDNT SAVE WAVE")
        }
        
    }
    
    // MARK: - File Name Definition
    func chooseWaveFileName() -> String {
        let chosenFileName = FileName.text ?? "GuideSketch"
        print(chosenFileName)
        return chosenFileName
    }
        
}


    
    

