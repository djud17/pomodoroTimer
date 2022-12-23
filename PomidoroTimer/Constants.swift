//
//  Constants.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit

enum Constants {
    enum Color {
        static let red = UIColor.red
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
}
