//
//  Extension.swift
//  Slot Machine
//
//  Created by Ros Dul on 3/3/26.
//

import SwiftUI

extension Text{
    func scoreLabelStyle()->Text{
        self
            .foregroundColor(.white)
            .font(.system(size: 10,weight: .bold, design: .rounded))
    }
    
    func scoreNumberStyle()->Text{
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
