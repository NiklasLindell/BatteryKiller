import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {
    
    var torchLevel = 0.0
    var vibrationTimer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        startTorch()
        
        vibrationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startVibration), userInfo: nil, repeats: true)
        
        
    }
    
    
    // Function to start vibration
    
    @objc func startVibration(){
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
//    func to start flashlight/torch
    func startTorch(){
        var repeatLight = true
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                while true {
                    try device.lockForConfiguration()
                    if repeatLight == true {
                        device.torchMode = .on
                        repeatLight = false
                    }
                    if repeatLight == false {
                        device.torchMode = .off
                        repeatLight = true
                    }
                }
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
   

    
    
    
    


}

