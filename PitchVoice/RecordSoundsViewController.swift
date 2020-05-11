//
//  RecordSoundsViewController.swift
//  PitchVoice
//
//  Created by Fiza Rasool on 08/06/19.
//  Copyright © 2019 Fiza Rasool. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
   
    
    @IBAction func recordAudio(_ sender: Any) {
        
        configureUI(recordingState: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord , with : .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings : [:])
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stoRecording(_ sender: Any) {
        
        configureUI(recordingState: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func configureUI(recordingState : Bool) {
        
        if recordingState {
            recordingLabel.text = "Recording in Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        } else {
            recordButton.isEnabled = true
            recordingLabel.text = "Tap to record"
            stopRecordingButton.isEnabled = false
        }
    }
    
    
    // MARK : - Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Recording unsuccessful")
        }
    }
    
    
    //Segue to go to PlaySoundsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stopRecording" {
            let destinationVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            destinationVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
    
}

