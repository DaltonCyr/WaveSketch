//
//  GuideSketch Menu Buttons.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 4/24/22.
//

import Foundation
import UIKit
extension FreeSketchViewController {
    
    //MARK: Frequency Popdown Button Function
    
    func frequencyMenu() {
        
        
        
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.headerInformation[5] = action.title
            
        }
        
        frequencyUnitMenu.menu = UIMenu(children : [
            
            UIAction(title : "HZ", handler: optionClosure ),
            UIAction(title : "KHZ", handler: optionClosure )])
        
        frequencyUnitMenu.showsMenuAsPrimaryAction = true
        frequencyUnitMenu.changesSelectionAsPrimaryAction = true
       
    }
    func maxVoltageMenu() {
        
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.headerInformation[1] = action.title
            
        }
        
        
        maxVoltageUnitMenu.menu = UIMenu(children : [
            
            UIAction(title : "V", handler: optionClosure ),
            UIAction(title : "mV", handler: optionClosure ),
            UIAction(title : "- V", handler: optionClosure ),
            UIAction(title : "- mV", handler: optionClosure )])
        
        
        maxVoltageUnitMenu.showsMenuAsPrimaryAction = true
        maxVoltageUnitMenu.changesSelectionAsPrimaryAction = true
       
    }
    
    func minVoltageMenu() {
        
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.headerInformation[3] = action.title
            
        }
        
        minVoltageUnitMenu.menu = UIMenu(children : [
            
            UIAction(title : "V", handler: optionClosure ),
            UIAction(title : "mV", handler: optionClosure ),
            UIAction(title : "- V", state: .on, handler: optionClosure ),
            UIAction(title : "- mV", handler: optionClosure )])
        
        minVoltageUnitMenu.showsMenuAsPrimaryAction = true
        minVoltageUnitMenu.changesSelectionAsPrimaryAction = true
       
    }
    
    func channelMenu() {
        
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.headerInformation[8] = action.title
            
        }
        
        outputChannelMenu.menu = UIMenu(children : [
           
            UIAction(title : "BNC Port 1", handler: optionClosure ),
            UIAction(title : "BNC Port 2", handler: optionClosure )])
        
        outputChannelMenu.showsMenuAsPrimaryAction = true
        outputChannelMenu.changesSelectionAsPrimaryAction = true
       
    }
    
}
