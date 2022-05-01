//
//  Bluetooth.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 1/28/22.
//

import Foundation
import UIKit
import CoreBluetooth
import UniformTypeIdentifiers

extension ConnectAWGViewController: CBCentralManagerDelegate {
    
    //Making Sure the phones bluetooth is on
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: [esp32UUID])
        @unknown default:
            fatalError()
        }
        ConnectionDisplay.text = "Connection Status: Disconnected... "
        ConnectionActivityIndicator.color = .red
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print(peripheral)
        esp32Peripheral = peripheral
        esp32Peripheral.delegate = self
        centralManager.stopScan()
        centralManager.connect(esp32Peripheral)
        ConnectionDisplay.text = "Connection Status: Connected... "
        ConnectionActivityIndicator.color = .systemGreen
        
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        esp32Peripheral.discoverServices([esp32UUID])
        print(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected")
        ConnectionDisplay.text = "Connection Status: Disconnected... "
        ConnectionActivityIndicator.color = .red
        
    }
      
}

extension ConnectAWGViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            print(service)
        
        if service.uuid == esp32UUID {
            //discovery of characteristics
            peripheral.discoverCharacteristics([characteristicMessageUUID], for: service)
                                return
                        }
                    }
            }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        //print("****\(service.characteristics)*****")
        guard let characteristics = service.characteristics else {
            print("Did not find services")
            return }

        for characteristic in characteristics {
        print(characteristic)
            
            if characteristic.properties.contains(.write) && characteristic.properties.contains(.read){
            print("\(characteristic.uuid): properties contains .write .read")
            
            messageCharacteristic = characteristic
            }
            
        }
        
        esp32Peripheral.setNotifyValue(true, for: messageCharacteristic)
    }
    
   
}

extension ConnectAWGViewController: CBPeripheralManagerDelegate {

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    switch peripheral.state {
    case .poweredOn:
        print("Peripheral Is Powered On.")
    case .unsupported:
        print("Peripheral Is Unsupported.")
    case .unauthorized:
    print("Peripheral Is Unauthorized.")
    case .unknown:
        print("Peripheral Unknown")
    case .resetting:
        print("Peripheral Resetting")
    case .poweredOff:
      print("Peripheral Is Powered Off.")
    @unknown default:
      print("Error")
    }
  }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        var characteristicASCIIValue = NSString()

        guard characteristic == characteristic,

        let characteristicValue = characteristic.value,
        let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }

        characteristicASCIIValue = ASCIIstring
        characteristicReadValue = "\((characteristicASCIIValue as String))"
        readValueInteger = (characteristicReadValue as NSString).doubleValue
        print("Value Recieved: \((readValueInteger))")
        percentageComplete = round((readValueInteger / 62) * 100)
        
        BluetoothLoadingPercentage.text = "\(percentageComplete) % Loaded"
        
        if percentageComplete == 100 {
            showAlert(passedTitle: "Complete", passedMessage: "Wave Contents Sent")
        }
        if percentageComplete > 101{
            showAlert(passedTitle: "sRAM Done Loading", passedMessage: "Wave is presenting")
        }
        
    }
    
    func readPeripherialValue(){
        esp32Peripheral.readValue(for: messageCharacteristic)
        
    }
    
    
    
    func writeOutgoingValue(data: String){
        print("In Writing Function")
          
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        
        if let esp32Peripheral = esp32Peripheral {
              
          if let messageCharacteristic = messageCharacteristic {
                  
            esp32Peripheral.writeValue(valueString!, for: messageCharacteristic, type: CBCharacteristicWriteType.withResponse)
              }
          }
      }
}
