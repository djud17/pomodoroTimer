//
//  PlayerButton.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit

enum PlayerButtonType {
    case play
    case pause
}

final class PlayerButton: UIButton {
    private var playerButtonType: PlayerButtonType
    
    // MARK: - Inits
    
    init(playerButtonType: PlayerButtonType) {
        self.playerButtonType = playerButtonType
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupView() {
        let normalImage: UIImage?
        let highlightedImage: UIImage?
        switch playerButtonType {
        case .play:
            normalImage = Constants.Image.playImage
            highlightedImage = Constants.Image.playFillImage
        case .pause:
            normalImage = Constants.Image.pauseImage
            highlightedImage = Constants.Image.pauseFillImage
            isEnabled = false
        }
        
        setImage(normalImage, for: .normal)
        setImage(highlightedImage, for: .highlighted)
        tintColor = Constants.Color.white
    }
}
