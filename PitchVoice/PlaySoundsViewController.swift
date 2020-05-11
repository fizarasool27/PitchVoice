//
//  PlaySoundsViewController.swift
//  PitchVoice
//
//  Created by Fiza Rasool on 10/06/19.
//  Copyright © 2019 Fiza Rasool. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL : URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var timer : Timer!
    var stopTimer : Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fastButton.imageView?.contentMode = .scaleAspectFit
        slowButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit

        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func playSoundForButton(_ sender: Any) {
      
        switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
        case .slow :
            playSound(rate: 0.5)
        case .fast :
            playSound(rate : 1.5)
        case .highPitch :
            playSound(pitch : 1000)
        case .lowPitch :
            playSound(pitch : -1000)
        case .echo :
            playSound(echo : true)
        case .reverb :
            playSound(reverb : true)
        }
        
        configureUI(.playing)
        
    }

    
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopAudio()
    }
    
    


}
