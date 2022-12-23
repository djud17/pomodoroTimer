//
//  MainView.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit
import SnapKit

final class MainView: UIView {
    let secondsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.FontSize.largeSize)
        label.textColor = Constants.Color.white
        return label
    }()
    
    let playerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.layer.cornerRadius = 20
        stackView.layer.borderColor = Constants.Color.white.cgColor
        stackView.layer.borderWidth = 5
        
        return stackView
    }()
    
    let playTimerButton = PlayerButton(playerButtonType: .play)
    let pauseTimerButton = PlayerButton(playerButtonType: .pause)
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupHierachy()
        setupLayout()
        setupPlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Constants.Color.red
        
    }
    
    private func setupHierachy() {
        addSubview(secondsLabel)
        addSubview(playerStackView)
    }
    
    private func setupLayout() {
        secondsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        playerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(secondsLabel.snp.bottom).offset(Constants.Offset.mediumOffset)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    private func setupPlayer() {
        playerStackView.addArrangedSubview(playTimerButton)
        playerStackView.addArrangedSubview(pauseTimerButton)
    }
}
