//
//  FreeSaveFile.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit

extension FreeSketchViewController {

    
    func saveFile() {
    
    print("Saved Wave")
    
    // MARK: - Getting Values in Text Fields
    let drawingPoints = freeDrawView.linePoint
    
    let maxVoltageText = MaxVoltage.text
    let minVoltageText = MinVoltage.text
    let frequencyValue = Frequency.text
    let shiftDegrees = "0"
    
    // This is for error Handle
    headerInformation[0] = maxVoltageText ?? "No Max Voltage"
    headerInformation[2] = minVoltageText ?? "No Min Voltage"
    headerInformation[4] = frequencyValue ?? "No Frequency Value"
    headerInformation[6] = shiftDegrees
    
    var maxVoltage = (headerInformation [0] as NSString).doubleValue
    let maxVoltageSign = headerInformation [1]
    var minVoltage = (headerInformation [2] as NSString).doubleValue
    let minVoltageSign = headerInformation [3]
    var channelNumber = 0
        if headerInformation[8] == "BNC Port 1"{
            channelNumber = 1
        }
        if headerInformation[8] == "BNC Port 1"{
            channelNumber = 2
        }


    
    
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
        
    
        let X_AXIS_POINTS = 15360
        // Need to determine the number of sections this wave has
                    ///Number of sections is fingerPoints.count -1

        let numberOfSectionsToFill = drawingPoints.count-1


        //Need to Determine the percentage of the points that fill each section
        ///Total Wave Distance = fingerPoint[fingerPoint.count-1] - fingerPoint[0]
        ///use the total distace to come up with a percentage for each section

        let totalWaveDistance = drawingPoints[drawingPoints.count-1].x - drawingPoints[0].x
        var percentagePerSectionList = [Double]()
        for i in 0...drawingPoints.count-2{
            
            let sectionDistance = drawingPoints[i+1].x - drawingPoints[i].x
            percentagePerSectionList.append(sectionDistance / totalWaveDistance)
        }

        //Percentage points per section will not divide evenly thus must round and insert more in the larger percetage sections

        var exactPointsPerSectionList = [Double]()

        for i in 0...percentagePerSectionList.count-1{
            
            let percentage = percentagePerSectionList[i]
            exactPointsPerSectionList.append(percentage * (Double(X_AXIS_POINTS) - Double(drawingPoints.count)))
            
        }

        //All Points are rounded down so we stay below the x axis limit
        var roundedDownPointsPerSectionList = [Int]()
        var remainingPointsLeft  = X_AXIS_POINTS - drawingPoints.count
        for i in 0...exactPointsPerSectionList.count-1{
            
            let exactPointsValue = exactPointsPerSectionList[i]
            let roundedPointsValue = exactPointsValue.rounded(.down)
            remainingPointsLeft = remainingPointsLeft - Int(roundedPointsValue)
            roundedDownPointsPerSectionList.append(Int(roundedPointsValue))
            
            
        }

        
        //Need to distrubute the extra points that we have due to the rounding down
        ///Sections with the larger percentages will get more points

        var extraPointsPerSectionListDependentOnSectionLength = [Double]()

        for i in 0...numberOfSectionsToFill-1{
            
            let percentageOfRemaingPointsToBeInserted = percentagePerSectionList[i] * Double(remainingPointsLeft)
            extraPointsPerSectionListDependentOnSectionLength.append(percentageOfRemaingPointsToBeInserted)
            
            
        }

        //Need to sort the list from largest to smallest so larger sections get extra points first
        let sortedListFromGreatestToLeastOfExtraPointsPerSection = extraPointsPerSectionListDependentOnSectionLength.sorted(by: >)

        while(Int(remainingPointsLeft) > 0){
            for i in 0...extraPointsPerSectionListDependentOnSectionLength.count-1{
                

                let currentLargestSectionToGetExtraPoints = sortedListFromGreatestToLeastOfExtraPointsPerSection[i]
                if Int(remainingPointsLeft) > 0 {
                    for j in 0...extraPointsPerSectionListDependentOnSectionLength.count-1{ ///This for loop is matching the index with the current largest selected section to be able to add a point to its count
                        if currentLargestSectionToGetExtraPoints == extraPointsPerSectionListDependentOnSectionLength[j]{
                            roundedDownPointsPerSectionList[j] = roundedDownPointsPerSectionList[j] + 1
                            break
                        }
                        
                    }
                remainingPointsLeft -= 1
                
                }
            }
        }
        var sum1 = 0
        print("SUM 1 is ")
        for i in 0...roundedDownPointsPerSectionList.count-1{
            sum1 = sum1 + roundedDownPointsPerSectionList[i]
        
        }
        print(sum1)
        print(drawingPoints.count)
        print(sum1 + drawingPoints.count)


// MARK: - Filling The points between drawn points with values
        var alteredDrawingPoint = [CGPoint]()
        alteredDrawingPoint.append(drawingPoints[0])
        for i in 0...drawingPoints.count-2{
            
            //Find the length between the two points
            let sectionDistanceX = Double(drawingPoints[i+1].x - drawingPoints[i].x)
            let sectionDistanceY = Double(drawingPoints[i+1].y - drawingPoints[i].y)
            
            //Find Increment Lengths for points to be equal distance from eachother
            let distanceBetweenInsertedPoints = sectionDistanceX / (Double(roundedDownPointsPerSectionList[i]) + 1)
            
            //Find Slope
            let slope = sectionDistanceY / (sectionDistanceX + 0.0000001)
            
            //Find Y axis Crossing
            let yAxisCrossing = drawingPoints[i].y - (slope * drawingPoints[i].x)
            
            //Insert Points for this specific section, iterate for the number of points in that section
            for j in 0...roundedDownPointsPerSectionList[i] {
                let currentInsertedPointXLocation = (drawingPoints[i].x) + (Double(j) * distanceBetweenInsertedPoints + distanceBetweenInsertedPoints)
                
                let currentInsertedPointYLocation = (slope * currentInsertedPointXLocation) + yAxisCrossing
               
                let truncatedXPointLocation = round(currentInsertedPointXLocation * 10000) / 10000
                
                let truncatedYPointLocation = round(currentInsertedPointYLocation * 10000) / 10000
                
                alteredDrawingPoint.append(CGPoint(x: truncatedXPointLocation, y: truncatedYPointLocation))
            }
            
            
        }
//        print("Altered Drawing Points Printed = \(alteredDrawingPoint.count)")
//        for i in 0...alteredDrawingPoint.count-1{
//            print(alteredDrawingPoint[i].y * -1)
//        }
           
        
        
        // MARK: - Change points to (CH,X,V)
        ///Getting Data Input
         
        //Finding Max Voltage iPhone point and Min voltage iPhone point and Ranges
        var maxVoltage_yPoint:CGFloat = 1000
        var minVoltage_yPoint:CGFloat = -1
        for i in 0...alteredDrawingPoint.count - 1 {
            ///inverted due to the iphone graph being top y=0 bottom y= 800
            if alteredDrawingPoint[i].y > minVoltage_yPoint {
                minVoltage_yPoint = alteredDrawingPoint[i].y
            }
            if alteredDrawingPoint[i].y < maxVoltage_yPoint {
                maxVoltage_yPoint = alteredDrawingPoint[i].y
            }
            
        }
        
            

        let point_yRange:CGFloat = (minVoltage_yPoint - maxVoltage_yPoint)
        let voltageRange = CGFloat(maxVoltage - minVoltage)
       
        // MARK: - Y to Voltage
        for i in 0...alteredDrawingPoint.count-1 {
            
            let voltageRatio = ((minVoltage_yPoint - alteredDrawingPoint[i].y) / point_yRange) * voltageRange
                        
            alteredDrawingPoint[i] = CGPoint(x: CGFloat(i), y: round((CGFloat(minVoltage) + voltageRatio) * 10000) / 10000)
            print(alteredDrawingPoint[i].y)
        }

        
        // MARK: - This creates a uniuqe file name so nothing is over written
        
        let fileDescription: String = chooseWaveFileName() + "  : FreeSketch - ID :"
        print(fileDescription)
        let file = "\(fileDescription) " + "\(UUID().uuidString) .txt"
        
        //filling the contnents string full of all the CGPoints from the graph
        var contenets = ""
        
        for i in 0...8 {
                
                contenets = contenets + "$\(headerInformation[i]) "
            }
                
            contenets = contenets + "$\n"
        
        for i in 0...alteredDrawingPoint.count-1 {
            let intVersionX = Int(alteredDrawingPoint[i].x)
            contenets = contenets + ":\(channelNumber):\(intVersionX):\(alteredDrawingPoint[i].y) \n"
        }
        
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
            print(alteredDrawingPoint.count)
        }
        else{
            showAlert(passedTitle: "Error", passedMessage: errorMessage)
            print("DIDNT SAVE WAVE")
        }
        
    }
    // MARK: - End Save Button



    // MARK: - File Name Definition
    func chooseWaveFileName() -> String {
        let chosenFileName = FileName.text ?? "FreeSketch"
        print(chosenFileName)
        return chosenFileName
    }

    
}


