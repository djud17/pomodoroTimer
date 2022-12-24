//
//  TimeLabel.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 24.12.2022.
//

import UIKit

final class TimeLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: Constants.FontSize.largeSize)
        textColor = Constants.Color.white
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
