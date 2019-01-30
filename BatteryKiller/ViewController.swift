import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {
    
    
    var vibrationTimer : Timer!
    var soundTimer : Timer!
    var torchTimer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        vibrationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startVibration), userInfo: nil, repeats: true)
        
        startFlashBackground()
        
        
        
        soundTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startSound), userInfo: nil, repeats: true)
        
        
        
        torchTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(startTorch), userInfo: nil, repeats: true)
        
        
    }
    
    
    // Function to start vibration
    
    @objc func startVibration(){
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        print("VIBRATION")
    }
    
    //    func to start flashlight/torch
    @objc func startTorch(){
        var repeatLight = true
        var i = 0
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                while i < 5  {
                    try device.lockForConfiguration()
                    if repeatLight == true {
                        device.torchMode = .on
                        repeatLight = false
                    }
                    if repeatLight == false {
                        device.torchMode = .off
                        repeatLight = true
                        i += 1
                    }
                    print("LIGHT")
                }
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    @objc func startSound(){
        AudioServicesPlaySystemSound(1005)
        print("SOUND")
        
    }
    
    func startFlashBackground(){
        UIView.animate(withDuration: 0.1, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse], animations: {
            self.view.backgroundColor = UIColor.yellow
            //self.view.backgroundColor = UIColor.green
            self.view.backgroundColor = UIColor.blue
            //self.view.backgroundColor = UIColor.red
        }, completion: nil)
        print("BACKGROUND")
    }
}

