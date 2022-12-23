//
//  Constants.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit

enum Constants {
    enum Color {
        static let red = UIColor(red: 0.61, green: 0.11, blue: 0.09, alpha: 1)
        static let green = UIColor(red: 0, green: 0.57, blue: 0.14, alpha: 1)
        static let white = UIColor.white
    }
    
    enum Offset {
        static let mediumOffset: CGFloat = 20
    }
    
    enum FontSize {
        static let largeSize: CGFloat = 80
    }
    
    enum Size {
        static let buttonSize: CGFloat = 40
    }
    
    enum Image {
        static let playImage = UIImage(systemName: "play")
        static let playFillImage = UIImage(systemName: "play.fill")
        
        static let pauseImage = UIImage(systemName: "pause")
        static let pauseFillImage = UIImage(systemName: "pause.fill")
        
        static let stopImage = UIImage(systemName: "stop")
        static let stopFillImage = UIImage(systemName: "stop.fill")
    }
    
    enum Time {
        static let workDuration: UInt = 5 // 25
        static let restDuration: UInt = 3 // 10
    }
}
