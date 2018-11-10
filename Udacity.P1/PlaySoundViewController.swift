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
    @IBOutlet weak var btnSlow: UIButton!
    @IBOutlet weak var btnFast: UIButton!
    @IBOutlet weak var btnEcho: UIButton!
    @IBOutlet weak var btnReverb: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        configureButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    func configureButton()
    {
        btnHighPitch.imageView?.contentMode = .scaleAspectFit
        btnLowPitch.imageView?.contentMode = .scaleAspectFit
        btnStop.imageView?.contentMode = .scaleAspectFit
        btnSlow.imageView?.contentMode = .scaleAspectFit
        btnFast.imageView?.contentMode = .scaleAspectFit
        btnEcho.imageView?.contentMode = .scaleAspectFit
        btnReverb.imageView?.contentMode = .scaleAspectFit
    }
}
