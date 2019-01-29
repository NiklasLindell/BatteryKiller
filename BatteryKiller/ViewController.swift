//
//  ViewController.swift
//  BatteryKiller
//
//  Created by Niklas Lindell on 2019-01-29.
//  Copyright © 2019 Niklas Lindell. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startTorch(on: true)
    }
    
    
    // Function to start vibration
    
    func startVibration(){
        
        
    }
    
    //func to start flashlight/torch
    func startTorch(on: Bool){
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
        
    }
    
    
    
    


}

