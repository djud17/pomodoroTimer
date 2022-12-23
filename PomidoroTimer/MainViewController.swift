//
//  ViewController.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private var timer: Timer?
    private var clockTime: UInt = 0
    private var isTimerStarted = false {
        didSet {
            playTimerButton.isEnabled = !isTimerStarted
            pauseTimerButton.isEnabled = isTimerStarted
        }
    }
    
    // MARK: - UI Elements
    
    private let secondsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.FontSize.largeSize)
        label.textColor = Constants.Color.white
        return label
    }()
    
    private let playerStackView: UIStackView = {
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
    
    private let playTimerButton = PlayerButton(playerButtonType: .play)
    private let pauseTimerButton = PlayerButton(playerButtonType: .pause)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupHierachy()
        setupPlayer()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = Constants.Color.red
        
        setupLabelText(withTime: clockTime)
    }
    
    private func setupHierachy() {
        view.addSubview(secondsLabel)
        view.addSubview(playerStackView)
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
        playTimerButton.addTarget(self, action: #selector(playTimer), for: .touchUpInside)
        pauseTimerButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        
        playerStackView.addArrangedSubview(playTimerButton)
        playerStackView.addArrangedSubview(pauseTimerButton)
    }
    
    // MARK: - Actions
    
    @objc private func playTimer() {
        setupTimer()
        isTimerStarted = true
    }
    
    @objc private func pauseTimer() {
        isTimerStarted = false
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private funcs
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func updateTimer() {
        clockTime += 1
        setupLabelText(withTime: clockTime)
    }
    
    private func setupLabelText(withTime time: UInt) {
        let textTime: String
        if time < 10 {
            textTime = "0\(time)"
        } else {
            textTime = "\(time)"
        }
        secondsLabel.text = textTime
    }
}
