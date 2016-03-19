//
//  PlayAudioViewController.swift
//  VaderVoice
//
//  Created by Antonio Sejas on 19/3/16.
//  Copyright © 2016 Antonio Sejas. All rights reserved.
//

import UIKit

class PlayAudioViewController: UIViewController {

    @IBOutlet weak var btnSnail: UIButton!
    @IBOutlet weak var btnFast: UIButton!
    @IBOutlet weak var btnChipmunk: UIButton!
    @IBOutlet weak var btnVader: UIButton!
    @IBOutlet weak var btnParrot: UIButton!
    @IBOutlet weak var btnReverb: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    var urlAudio = NSURL()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
