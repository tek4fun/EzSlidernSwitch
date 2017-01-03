//
//  ViewController.swift
//  EzSlidernSwitch
//
//  Created by iOS Student on 1/3/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audio = AVAudioPlayer()
    var toggleState = 1
    
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var sld_Vol: UISlider!
    @IBOutlet weak var lbl_TimeLeft: UILabel!
    @IBOutlet weak var sw_Repeat: UISwitch!
    
    @IBOutlet weak var sld_Duration: UISlider!
    @IBOutlet weak var lbl_TotalTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!) as URL)
        audio.prepareToPlay()
        addThumbIMgForSlider()
        lbl_TotalTime.text = String(format: "%2.2f",audio.duration/60)
        audio.delegate = self
        audio.currentTime = 290
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
    }
    
    func updateTimeLeft() {
        self.lbl_TimeLeft.text = String(format: "%2.2f",audio.currentTime/60)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
    }
    
    
    
    func addThumbIMgForSlider()
    {
        sld_Vol.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        sld_Vol.setThumbImage(UIImage(named:"thumbHightLight.png"), for: .highlighted)
        sld_Duration.setThumbImage(UIImage(named:"duration.png"), for: .normal)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if sw_Repeat.isOn{
            audio.play()
        } else{
            toggleState = 2
            btn_Play.setImage(UIImage(named:"play.png"), for: .normal)
        }
    }
    
    
    @IBAction func sld_DurationAction(_ sender: UISlider) {
        
        audio.currentTime = TimeInterval(sender.value)*audio.duration
    }
    
    
    @IBAction func sld_Volume(_ sender: UISlider) {
        audio.volume = sender.value
    }
    
    @IBAction func action_Play(_ sender: AnyObject) {
        if toggleState == 1 {
            audio.pause()
            toggleState = 2
            btn_Play.setImage(UIImage(named:"play.png"), for: .normal)
        } else {
            audio.play()
            toggleState = 1
            btn_Play.setImage(UIImage(named:"pause.png"), for: .normal)
        }
        
    }
    
}

