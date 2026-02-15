//
//  PlaySound.swift
//  Start-project-learnning-demo
//
//  Created by Ros Dul on 15/2/26.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playAudio(soundName: String, type: String) {
    guard let path = Bundle.main.path(forResource: soundName, ofType: type)else {return}
    do{
        audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
        audioPlayer?.play()
    }catch let error{
        print("Error play sound \(error.localizedDescription)")
    }
}

