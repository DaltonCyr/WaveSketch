//
//  FreeSketchPickers.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 10/24/21.
//

import Foundation
import UIKit

extension FreeSketchViewController: UIPickerViewDelegate, UIPickerViewDataSource {

// Voltage Unit Tag = 0    Voltage Unit2 Tag = 1     Frequency Unit Tag = 2      Shift Direction Tag = 3     Channel Tag = 4
    
    /// How Many selections returned
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    /// Defining how many rows are in each picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ///Voltage Unit Picker Num Rows
        if pickerView.tag == 0{
            return voltageUnit.count
            
        }
        ///Voltage  Unit2 Picker Num Rows
        else if pickerView.tag == 1{
            return voltageUnit.count

        }
        ///Frequency Unit Picker Num Rows
        else if pickerView.tag == 2{
            return frequencyUnit.count

        }
        ///Shift  Picker Num Rows
        else if pickerView.tag == 3{
            return shiftOptions.count

        }
        ///Channel Picker Num Rows
        else {
            return channelOptions.count

        }
    }
    /// Defining Height of each row in the picker for view formatting
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    // MARK: - Picker Views Customization
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        ///Voltage Unit 1 Picker Num Rows
        if pickerView.tag == 0{
            let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 186, height: 33))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 186, height: 33))
            
            label.text = voltageUnit[row]
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            view1.addSubview(label)
            return view1
        }
        ///Voltage Unit 2 Picker Num Rows
        else if pickerView.tag == 1{
            let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 92, height: 33))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 92, height: 33))
            
            label.text = voltageUnit[row]
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            view2.addSubview(label)
            return view2
        }
        ///Frequency Unit Picker Num Rows
        else if pickerView.tag == 2{
            let view3 = UIView(frame: CGRect(x: 0, y: 0, width: 92, height: 33))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 92, height: 33))
            
            label.text = frequencyUnit[row]
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            view3.addSubview(label)
            return view3
        }
        ///Shift  Picker Num Rows
        else if pickerView.tag == 3{
            let view4 = UIView(frame: CGRect(x: 0, y: 0, width: 92, height: 33))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 92, height: 33))
            
           
            label.text = shiftOptions[row]
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            view4.addSubview(label)
            return view4
        }
        ///Channel Picker Num Rows
        else {
            let view5 = UIView(frame: CGRect(x: 0, y: 0, width: 374, height: 33))
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 374, height: 33))
            
            
            label.text = channelOptions[row]
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            view5.addSubview(label)
            return view5
        }
    }
    
    // MARK: - Header Picker Info
    /// Allows the accuarate reading of the row the picker ends on
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ///Voltage Unit Picker Num Rows
        if pickerView.tag == 0{
            headerInformation[1] = voltageUnit[row]
        }
        ///Voltage  Unit 2 Picker Num Rows
        else if pickerView.tag == 1{
            headerInformation[3] = voltageUnit[row]
         
        }
        ///Freq  Picker Num Rows
        else if pickerView.tag == 2{
            headerInformation[5] = frequencyUnit[row]

        }
        ///Shift  Picker Num Rows
        else if pickerView.tag == 3{
            headerInformation[7] = shiftOptions[row]

        }
        ///Channel  Picker Num Rows
        else{
            headerInformation[8] = channelOptions[row]

        }
    }
}
