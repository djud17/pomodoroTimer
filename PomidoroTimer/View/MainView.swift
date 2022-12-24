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
    
    let minutesLabel = TimeLabel()
    let secondsLabel = TimeLabel()
    private let separatorLabel: UILabel = {
        let label = TimeLabel()
        label.text = ":"
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
        
        setupHierachy()
        setupLayout()
        
        selectMode()
        updateModeLabelText()
        
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
        addSubview(minutesLabel)
        addSubview(separatorLabel)
        addSubview(secondsLabel)
        addSubview(circularProgressBarView)
        addSubview(playerStackView)
    }
    
    private func setupLayout() {
        modeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Offset.topOffset)
            make.centerX.equalToSuperview()
        }
        
        separatorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        circularProgressBarView.snp.makeConstraints { make in
            make.center.equalTo(separatorLabel.snp.center)
        }
        
        minutesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(separatorLabel.snp.centerY)
            make.trailing.equalTo(separatorLabel.snp.leading).offset(-10)
            make.leading.equalToSuperview().offset(50)
        }
        
        secondsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(separatorLabel.snp.centerY)
            make.leading.equalTo(separatorLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        playerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(minutesLabel.snp.bottom).offset(150)
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
