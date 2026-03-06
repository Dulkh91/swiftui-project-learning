//
//  PlaySound.swift
//  Slot Machine
//
//  Created by Ros Dul on 6/3/26.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playerAudio(soundName: String, type: String){
    guard let path = Bundle.main.path(forResource: soundName, ofType: type) else {return}
    
    do{
        audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
        audioPlayer?.play()
    }catch let error{
        print("Error play sound \(error.localizedDescription)")
    }
    
}

