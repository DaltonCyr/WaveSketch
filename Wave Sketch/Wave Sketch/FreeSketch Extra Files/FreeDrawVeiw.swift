//
//  FreeDrawVeiw.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/18/21.
//

import UIKit

class FreeDrawVeiw: UIView {

// MARK: - FreeDrawView Definition

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        

        
// MARK: - Guide Line Definition

        
        var guideLine = [CGPoint]()
        ///Top Horizontal Line
        
        guideLine.append(CGPoint(x: 190, y: 100))
        guideLine.append(CGPoint(x: 0, y: 100))
        guideLine.append(CGPoint(x: 400, y: 100))
        guideLine.append(CGPoint(x: 190, y: 100))
        ///Bottom Horzontal Line
        guideLine.append(CGPoint(x: 190, y: 300))
        guideLine.append(CGPoint(x: 0, y: 300))
        guideLine.append(CGPoint(x: 400, y: 300))
        guideLine.append(CGPoint(x: 190, y: 300))
        ///Middle Hirizintal Line
       
        guideLine.append(CGPoint(x: 190, y: 200))
        guideLine.append(CGPoint(x: 400, y: 200))
        guideLine.append(CGPoint(x: 0, y: 200))
        
        for (i, p) in guideLine.enumerated(){
            if i == 0 {
                context.move(to: p)
            } else{
                
                context.addLine(to: p)
            
            }
        }
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineCap(.butt)

        context.setLineWidth(2)
       
    
     
        context.strokePath()
// MARK: - Drawing Users Line

        
        for (i, p) in linePoint.enumerated(){
            if i == 0 {
                context.move(to: p)
            } else{
                
                context.addLine(to: p)
            
            }
        }
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(4)
        context.setLineCap(.butt)
    
     
        context.strokePath()
    }

    
    var nonLine = [CGPoint]()
    
    var linePoint = [CGPoint]()
// MARK: - Tracking User Touches

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard var newLoc = touches.first?.location(in: nil) else { return }
        
        newLoc.x = newLoc.x - 20
        newLoc.y = newLoc.y - 235
        
        if nonLine.count-2 <= 0{
            nonLine.append(newLoc)
        }else if nonLine[nonLine.count-1].x >= nonLine[nonLine.count-2].x {
            nonLine.append(newLoc)
            linePoint.append(nonLine[nonLine.count-1])
        }else{
            setNeedsDisplay()
          
        }
       print(newLoc)
        print(linePoint.count)

        setNeedsDisplay()
        
        }



}
