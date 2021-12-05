//
//  GuidedDrawView.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/19/21.
//

import UIKit

// MARK: - GuideDraw Definition

class GuidedDrawView: UIView {

//MARK: States of Wave Selection
    var SquareWave = false
    var TriangleWave = false
    var SawtoothWave = false
    var TrapazoidalWave = false
    var DCWave = false
    var SinusoidalWave = false
    
   
    var linePoint = [CGPoint]()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        
        
        
        //MARK: Drawing Selected Wave
        if SquareWave {
            linePoint = drawSquareWave()
        }
        if TriangleWave {
            linePoint = drawTriangleWave()
            
        }
        if SawtoothWave {
            linePoint = drawSawtoothWave()            
        }
        if TrapazoidalWave {
            linePoint = drawTrapazoidalWave()
        }
        if DCWave {
            linePoint = drawDCWave()
        }
        if SinusoidalWave {
            linePoint = drawSinusoidalWave()
        }
        
        
       //MARK: Draw Wave
        for (i, p) in linePoint.enumerated(){
            if i == 0 {
                context.move(to: p)
            } else{
                
                context.addLine(to: p)
            
            }
        }
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(3)
        context.strokePath()

    }
    


}
