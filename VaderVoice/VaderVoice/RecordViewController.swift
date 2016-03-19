//
//  ViewController.swift
//  VaderVoice
//
//  Created by Antonio Sejas on 18/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var btnMic: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecord: UILabel!
    
    var oldTextLblRecord = ""
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        btnStop.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recordAudio(sender:AnyObject){
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }


    @IBAction func actionMic(sender: AnyObject) {
        oldTextLblRecord = lblRecord.text!
        lblRecord.text = "Recording..."
        btnStop.enabled = true
        btnMic.enabled = false
        
        recordAudio(sender)
        
    }
    @IBAction func actionStop(sender: AnyObject) {
        lblRecord.text = oldTextLblRecord
        btnStop.enabled = false
        btnMic.enabled = true
        
        audioRecorder.stop()
        
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if  (flag){
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else{
            print("Error audioRecorderDidFinishRecording, error saving")
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "stopRecording" == segue.identifier {
            if let playAudioVC = segue.destinationViewController as? PlayAudioViewController {
                playAudioVC.urlAudio = sender as! NSURL
            }
        }
    }
}

