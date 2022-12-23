//
//  ViewController.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    private var timer: Timer?
    private var clockTime: UInt = 0 {
        didSet {
            setupLabelText(withTime: clockTime)
        }
    }
    private var isTimerStarted = false {
        didSet {
            playTimerButton.isEnabled = !isTimerStarted
            pauseTimerButton.isEnabled = isTimerStarted
        }
    }
    
    // MARK: - UI Elements
    
    private lazy var secondsLabel = mainView.secondsLabel
    
    private lazy var playerStackView = mainView.playerStackView
    
    private lazy var playTimerButton = mainView.playTimerButton
    private lazy var pauseTimerButton = mainView.pauseTimerButton
    private lazy var stopTimerButton = mainView.stopTimerButton
    
    // MARK: - VC Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelText(withTime: clockTime)
        setupButtonsTargets()
    }
    
    // MARK: - Setups
    
    private func setupLabelText(withTime time: UInt) {
        let textTime: String
        if time < 10 {
            textTime = "0\(time)"
        } else {
            textTime = "\(time)"
        }
        secondsLabel.text = textTime
    }
    
    private func setupButtonsTargets() {
        playTimerButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        pauseTimerButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        stopTimerButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func playButtonTapped() {
        setupTimer()
        isTimerStarted = true
        stopTimerButton.isEnabled = true
    }
    
    @objc private func pauseButtonTapped() {
        stopTimer()
    }
    
    @objc private func stopButtonTapped() {
        clockTime = 0
        stopTimer()
        stopTimerButton.isEnabled = false
    }
    
    // MARK: - Timer funcs
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func stopTimer() {
        isTimerStarted = false
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        clockTime += 1
    }
}
