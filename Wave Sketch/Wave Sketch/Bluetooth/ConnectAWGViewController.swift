//
//  ConnectAWGViewController.swift
//  Wave Sketch
//
//  Created by Dalton Cyr on 11/16/21.
//

import UIKit
import CoreBluetooth
import UniformTypeIdentifiers

class ConnectAWGViewController: UIViewController, UITextViewDelegate {

    var centralManager: CBCentralManager!
    var esp32Peripheral: CBPeripheral!
    var messageCharacteristic: CBCharacteristic!
    let esp32UUID = CBUUID(string:"AB0828b1-198E-4351-B779-901FA0E0371F")
    let characteristicMessageUUID = CBUUID(string: "4ac8a682-9736-4e5d-932b-e9b31405049d")
    var characteristicReadValue = ""
    var readValueInteger: Double = 0
    var percentageComplete: Double = 0
    
    var dataInFile = ""
    var headerData = [String]()
    var wavePointValue = [String]()
    
    
    @IBOutlet weak var SendMessageButton: UIButton!
    
    @IBOutlet weak var SelectFileButton: UIButton!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var ConnectionActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var WaveInfoDisplay: UITextView!
    
    @IBOutlet weak var ConnectionDisplay: UITextView!
    
    @IBOutlet weak var BluetoothLoadingPercentage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ActivityIndicator.stopAnimating()
        centralManager = CBCentralManager(delegate: self, queue: nil)
       
        WaveInfoDisplay.delegate = self
        WaveInfoDisplay.isEditable = false
        
        ConnectionDisplay.delegate = self
        ConnectionDisplay.isEditable = false
        
        BluetoothLoadingPercentage.delegate = self
        BluetoothLoadingPercentage.isEditable = false

        WaveInfoDisplay.text = "Wave Properties \n \n"
        BluetoothLoadingPercentage.text = "0% Loaded"
    }
    
    @IBAction func SendMessageButtonTapped(_ sender: Any) {
        
        percentageComplete = 0
        var waveInformation = ""
        
        if dataInFile == "" {
            print("Cant Send Without Selected File")
            showAlert(passedTitle: "Error", passedMessage: "Cant Send Without Selected File")
        }
        else if ConnectionDisplay.text == "Connection Status: Disconnected... " {
            showAlert(passedTitle: "Error", passedMessage: "Cant Send Without Connected BLE Device")
        
        }

        else{
           let packets = 60
            
            for i in 0...packets-1{
                for j in 1...256{
                    let temp = i * 256 + j
                    if j == 256 && i != packets - 1 {
                        waveInformation = waveInformation + "\(wavePointValue[temp])"
                    }else if j == 256 && i == packets - 1{
                        print("/n reached very last value /n")
                        print(temp)
                    }else{
                    waveInformation = waveInformation + "\(wavePointValue[temp])"
                    }
                }

                writeOutgoingValue(data: waveInformation)
//                for i in 0...1000000{
//
//                }
                print(waveInformation)
                print("\n Loop Count: \(i))")
                waveInformation = ""


            }
        
        var fileFrequencyValue = (headerData[4] as NSString).doubleValue
        //var fileFrequencyAsInt = Int(fileFrequencyValue)
        print("Header Data is -\(headerData[5])-")
        if headerData[5] == "KHZ "{
            fileFrequencyValue = fileFrequencyValue * 1000
        }
        print("The the frequency is: \(fileFrequencyValue)")
        
        writeOutgoingValue(data: "\(fileFrequencyValue)")
        
        
        // writeOutgoingValue(data: "-1")
            
        //print(stringPacket)
        
        
//        while (characteristicReadValue != "10"){
//            print("STILL LOADING WAVE")
//            readPeripherialValue()
//        }
            showAlert(passedTitle: "Sending Data", passedMessage: "Do Not Exit Page While Loading Or Data Will Be Lost")
        }
    }
    
    @IBAction func SelectFileTapped(_ sender: Any) {
        
        dataInFile = ""
        ActivityIndicator.startAnimating()
        // Setting up the document picking window that shows the file folder when wanting to import a file
        let selectingDocument = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.text], asCopy: true)
        // Extrenous settings to get the picker to show
        selectingDocument.delegate = self
        selectingDocument.allowsMultipleSelection = false
        present(selectingDocument, animated: true, completion: nil)
        
    }
    
    @IBAction func ReconnectBluetoothTapped(_ sender: Any) {
        if esp32Peripheral != nil{
            centralManager?.cancelPeripheralConnection(esp32Peripheral)
            centralManager.stopScan()
            print("Disconnected from peripheral ")
        }
        centralManager.scanForPeripherals(withServices: [esp32UUID])
        
    }
    @IBAction func BackButtonTapped(_ sender: Any) {
        if esp32Peripheral != nil{
            centralManager?.cancelPeripheralConnection(esp32Peripheral)
            centralManager.stopScan()
            print("Disconnected from peripheral ")
        }
    }
    
    
    func showAlert(passedTitle: String, passedMessage: String ) {
        let alert = UIAlertController(title: passedTitle, message: passedMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("Pressed Alert Button")
        }))
        
        present(alert, animated: true)    }
    
    
}
extension ConnectAWGViewController: UIDocumentPickerDelegate{
    //
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        ActivityIndicator.stopAnimating()

    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])  {
        //MARK: Initialize Global Vars
        dataInFile = ""
        
        

        
        guard let selectedFileURL = urls.first else {
            return
        }
      
        //MARK: Read File Data
        do {
            
            let contents = try String(contentsOf: selectedFileURL)
            
            for data in contents.split(separator: "\n") {
                
                dataInFile = dataInFile + "\(data)"
               
            }
        }
        catch {
           
        }
        
        headerData = getHeader(dataInFile: dataInFile)
        wavePointValue = getWaveValues(dataInFile: dataInFile)
        
        infoDisplay(WavePropertiesArray: headerData)
        
        print("Counts are ****")
        print(wavePointValue.count)
        ActivityIndicator.stopAnimating()
    }
    
    
}


    

   


