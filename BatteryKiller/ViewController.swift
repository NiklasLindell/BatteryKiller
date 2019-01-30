import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {
    
    
    var vibrationTimer : Timer!
    var soundTimer : Timer!
    var torchTimer : Timer!
    
    var batteryLevel : Float{
        return UIDevice.current.batteryLevel
    }
    
    var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
         NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)

        
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
    
    //func to start sound
    @objc func startSound(){
        AudioServicesPlaySystemSound(1005)
        print("SOUND")
        
    }
    
    //func to start flash background
    func startFlashBackground(){
        UIView.animate(withDuration: 0.1, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse], animations: {
            self.view.backgroundColor = UIColor.yellow
            //self.view.backgroundColor = UIColor.green
            self.view.backgroundColor = UIColor.blue
            //self.view.backgroundColor = UIColor.red
        }, completion: nil)
        print("BACKGROUND")
    }
    
    
    //func to see batterylevel
    @objc func batteryLevelDidChange(_ notification: Notification) {
        print(batteryLevel)
        print("battery level")
    }
    
    //func to see battery state
    @objc func batteryStateDidChange(_ notification: Notification) {
        switch batteryState {
        case .unplugged, .unknown:
            print("not charging")
        case .charging, .full:
            print("charging or full")
        }
    }
}

