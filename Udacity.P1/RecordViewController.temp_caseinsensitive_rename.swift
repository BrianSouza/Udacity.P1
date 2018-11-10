//
//  ViewController.swift
//  Udacity.P1
//
//  Created by Brian Diego De Souza on 20/09/2018.
//  Copyright © 2018 Array App. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var btnGravar: UIButton!
    @IBOutlet weak var lblGravacao: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var gravando: Bool = false
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func gravar(_ sender: AnyObject){
        gravando = gravando ? parandoGravacao() : iniciandoGravacao()
        
    }
    func parandoGravacao() -> Bool{
        lblGravacao.text = "Iniciar gravação"
        btnGravar.setImage(UIImage(named:"Record.png"), for: UIControlState.normal)
        stopRecorder()
        return false
    }
    
    func  iniciandoGravacao() -> Bool{
        lblGravacao.text = "Parar gravação"
        btnGravar.setImage(UIImage(named:"Stop.png"), for: UIControlState.normal)
        recorderAudio()
        return true
    }
    
    func recorderAudio(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func stopRecorder(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag
        {
            performSegue(withIdentifier: "playRecord", sender: audioRecorder.url)
        }
        else
        {
            print("Erro ao gravar arquivo")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playRecord"
        {
            let playSoundsVC = segue.destination as! playSoundViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

