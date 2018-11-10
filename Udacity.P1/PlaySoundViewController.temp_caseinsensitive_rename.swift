//
//  playSoundViewController.swift
//  Udacity.P1
//
//  Created by Brian Diego De Souza on 24/09/2018.
//  Copyright © 2018 Array App. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    @IBOutlet weak var btnHighPitch: UIButton!
    @IBOutlet weak var btnLowPitch: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case chipmunk = 0, vader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
}
