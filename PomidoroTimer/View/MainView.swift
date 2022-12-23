//
//  MainView.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit
import SnapKit

final class MainView: UIView {
    var viewMode: Mode = .work {
        didSet {
            selectMode()
            updateModeLabelText()
        }
    }
    
    // MARK: - UI Elements
    
    private let modeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSize.mediumSize)
        label.textColor = Constants.Color.white
        return label
    }()
    
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
    
    var circularProgressBarView = CircleProgressBar(frame: .zero)
    
    let playTimerButton = PlayerButton(playerButtonType: .play)
    let pauseTimerButton = PlayerButton(playerButtonType: .pause)
    let stopTimerButton = PlayerButton(playerButtonType: .stop)
    
    // MARK: - Inits
    
    init() {
        super.init(frame: .zero)
        
        selectMode()
        updateModeLabelText()
        setupHierachy()
        setupLayout()
        setupPlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func selectMode() {
        let selectedColor: UIColor
        switch viewMode {
        case .work:
            selectedColor = Constants.Color.red
        case .rest:
            selectedColor = Constants.Color.green
        }
        
        backgroundColor = selectedColor
    }
    
    private func setupHierachy() {
        addSubview(modeLabel)
        addSubview(secondsLabel)
        addSubview(circularProgressBarView)
        addSubview(playerStackView)
    }
    
    private func setupLayout() {
        modeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Offset.topOffset)
            make.centerX.equalToSuperview()
        }
        
        secondsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        circularProgressBarView.snp.makeConstraints { make in
            make.center.equalTo(secondsLabel.snp.center)
        }
        
        playerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(secondsLabel.snp.bottom).offset(100)
            make.width.equalTo(Constants.Size.stackWidth)
            make.height.equalTo(Constants.Size.stackHeight)
        }
    }
    
    private func setupPlayer() {
        playerStackView.addArrangedSubview(playTimerButton)
        playerStackView.addArrangedSubview(pauseTimerButton)
        playerStackView.addArrangedSubview(stopTimerButton)
    }
    
    private func updateModeLabelText() {
        let labelText: String
        switch viewMode {
        case .work:
            labelText = "It`s time to work!"
        case .rest:
            labelText = "Let`s have a rest!"
        }
        modeLabel.text = labelText
    }
    
    func progressStep(withStep step: CGFloat) {
        circularProgressBarView.progress(value: step)
    }
    
    func resetProgress() {
        circularProgressBarView.resetBar()
    }
}
