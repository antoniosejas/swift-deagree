//
//  PlayAudioViewController.swift
//  VaderVoice
//
//  Created by Antonio Sejas on 19/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit
import AVFoundation
class PlayAudioViewController: UIViewController {

    @IBOutlet weak var btnSnail: UIButton!
    @IBOutlet weak var btnFast: UIButton!
    @IBOutlet weak var btnChipmunk: UIButton!
    @IBOutlet weak var btnVader: UIButton!
    @IBOutlet weak var btnParrot: UIButton!
    @IBOutlet weak var btnReverb: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    var urlAudio = NSURL()
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    enum ButtonType: Int {case Slow = 0, Fast, Chipmunk, Vader, Parrot, Reverb}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
    }
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    override func viewWillDisappear(animated: Bool) {
        //Stop audio when user leaves the screen
        stopAudio()
    }

    @IBAction func playSoundForButtom(sender: UIButton) {
        print("playsound",sender)
        //Important unwrap the ButtonType
        switch(ButtonType(rawValue: sender.tag)!){
        case.Slow:
            playSound(rate: 0.5)
        case.Fast:
            playSound(rate: 1.5)
        case.Chipmunk:
            playSound(pitch: 1000)
        case.Vader:
            playSound(pitch: -1000)
        case.Parrot:
            playSound(echo:true)
        case.Reverb:
            playSound(reverb:true)
        }
        
        configureUI(.Playing)

    }
    
    @IBAction func stopSoundForButtom(sender: AnyObject) {
        print("stopsound",sender)
        stopAudio()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
