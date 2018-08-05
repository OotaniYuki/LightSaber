//
//  ViewController.swift
//  LightSaber
//
//  Created by Ootani Yuki on 2018/08/05.
//  Copyright © 2018年 yppbp. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    let motionManager:CMMotionManager = CMMotionManager()
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var startAudioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    var startAccel:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSound()
    }

    @IBAction func UIStartButton(_ sender: UIButton) {
        startAudioPlayer.play()
        startGetAccelerometer()
    }
    func setupSound() {
        if let sound = Bundle.main.path(forResource: "light_saber1",ofType: ".mp3") {
            startAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            startAudioPlayer.prepareToPlay()
        }
        
        if let sound = Bundle.main.path(forResource: "light_saber3",ofType: ".mp3"){
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
            
        }
    }
    func startGetAccelerometer(){
        motionManager.accelerometerUpdateInterval = 1/100
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData:CMAccelerometerData?,error: Error?) in
            
            if let acc = accelerometerData{
                let x = acc.acceleration.x
                let y = acc.acceleration.y
                let z = acc.acceleration.z
                
                
                let synthetic = (x * x ) + (y * y) + (z * z)
                
                if self.startAccel  == false && synthetic >= 8{
                    self.startAccel = true
                    self.audioPlayer.currentTime = 0
                    self.audioPlayer.play()
                }
                
                if  self.startAccel == true && synthetic < 1{
                    self.startAccel = false
                }
            
            
            }
        }
}
}
