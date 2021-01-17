//
//  ViewController.swift
//  Umodoro
//
//  Created by UMUR on 27.12.2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let durations = ["Study": 1500, "Rest":300]
    var timer = Timer()
    var player : AVAudioPlayer?
    var totalTime = 0
    var secondsPassed = 0

    @IBAction func button(_ sender: UIButton) {
        
        player?.stop()
        timer.invalidate()
        let duration = sender.currentTitle!
        totalTime = durations[duration]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = duration
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        player?.stop()
        timer.invalidate()
        titleLabel.text = "Let's Start!"
        totalTime = 0
        secondsPassed = 0
        progressBar.progress = 0.0
    }
    
    @objc func updateTimer() {

        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "Great!"
            
            let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }
}
