//
//  DrawingFunctions.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit
extension GuidedDrawView {
    
    //MARK: Drawing Square
    func drawSquareWave() -> [CGPoint] {
        var drawingPoints = [CGPoint]()
        
        drawingPoints.append(CGPoint(x: 100, y: 250))
        drawingPoints.append(CGPoint(x: 101, y: 150))
        drawingPoints.append(CGPoint(x: 200, y: 150))
        drawingPoints.append(CGPoint(x: 201, y: 250))
        drawingPoints.append(CGPoint(x: 300, y: 250))
        
        
        return drawingPoints
    }
    //MARK: Drawing Triangle
    func drawTriangleWave() -> [CGPoint] {
        var drawingPoints = [CGPoint]()
        
        drawingPoints.append(CGPoint(x: 50, y: 200))
        drawingPoints.append(CGPoint(x: 125, y: 100))
        drawingPoints.append(CGPoint(x: 200, y: 200))
        drawingPoints.append(CGPoint(x: 275, y: 300))
        drawingPoints.append(CGPoint(x: 350, y: 200))
        
        
        return drawingPoints
    }
    //MARK: Drawing Swatooth
    func drawSawtoothWave() -> [CGPoint] {
        var drawingPoints = [CGPoint]()
        
        drawingPoints.append(CGPoint(x: 125, y: 275))
        drawingPoints.append(CGPoint(x: 250, y: 125))
        drawingPoints.append(CGPoint(x: 251, y: 275))
        
        
        
        return drawingPoints
    }
    //MARK: Drawing Trapazoidal
    func drawTrapazoidalWave() -> [CGPoint] {
        var drawingPoints = [CGPoint]()
        
        drawingPoints.append(CGPoint(x: 50, y: 200))
        drawingPoints.append(CGPoint(x: 100, y: 100))
        drawingPoints.append(CGPoint(x: 150, y: 100))
        drawingPoints.append(CGPoint(x: 200, y: 200))
        drawingPoints.append(CGPoint(x: 250, y: 300))
        drawingPoints.append(CGPoint(x: 300, y: 300))
        drawingPoints.append(CGPoint(x: 350, y: 200))

        return drawingPoints
    }
    
    func drawDCWave() -> [CGPoint] {
        var drawingPoints = [CGPoint]()
        
        drawingPoints.append(CGPoint(x: 50, y: 200))
        drawingPoints.append(CGPoint(x: 350, y: 200))

        return drawingPoints
    }
    //MARK: Drawing Sine
    func drawSinusoidalWave() -> [CGPoint] {
        var drawingPoints = [CGPoint]()
        var sinArray = [Double]()
        let PI = 3.1415926535
         
                // First Quarter
                for i in 0...24{
                    sinArray.append(sin(PI / (1 + (Double(i) * 0.04))) * 100)
                }
                // Second Quarter
                for i in 1...25{
                    sinArray.append(sinArray[25 - i])
                }
                //Third Quarter
                for i in 1...25{
                    sinArray.append((-1) * sin(PI / (1 + (Double(i) * 0.04))) * 100)
                }
                //Fourth Quarter
                for i in 1...26{
                    sinArray.append(sinArray[75 - i])
                }
        
        for i in 0...100 {
            drawingPoints.append((CGPoint(x: Double(50 + 3 * i), y: 200 - sinArray[i])))
        }

        return drawingPoints
    }
}
