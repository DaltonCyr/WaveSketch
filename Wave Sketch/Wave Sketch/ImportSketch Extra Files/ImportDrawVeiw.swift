//
//  ImportDrawVeiw.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 9/19/21.
//

import UIKit

// MARK: - DrawView Definition

class ImportDrawVeiw: UIView {
    var linePoint = [CGPoint]()
    var selectFileTapped = false
    let importViewController = ImportSketchViewController()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        
    //Need to put in marks for the voltages and periods
// MARK: -Drawing Imported wave

        if selectFileTapped == true{
           
            //print(linePoint)
            
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
    }
    
  
}
