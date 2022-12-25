//
//  ViewController.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit

enum Mode {
    case work
    case rest
}

final class MainViewController: UIViewController {
    private let mainView = MainView()
    private var timer: Timer?
    private var clockTime: (minutes: UInt, seconds: UInt) = (0, 0) {
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
    private var currentMode: Mode = .work {
        didSet {
            mainView.viewMode = currentMode
            
            switch currentMode {
            case .work:
                currentMaxTimerDuration = Constants.Time.workDuration
            case .rest:
                currentMaxTimerDuration = Constants.Time.restDuration
            }
        }
    }
    private var currentMaxTimerDuration: UInt = Constants.Time.workDuration {
        didSet {
            currentTimerStep = 1.0 / (Double(Constants.Time.workDuration) * 60.0)
        }
    }
    private var currentTimerStep: CGFloat = 1.0 / (Double(Constants.Time.workDuration) * 60.0)
    
    // MARK: - UI Elements
    
    private lazy var secondsLabel = mainView.secondsLabel
    private lazy var minutesLabel = mainView.minutesLabel
    
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
        
        setupInitial()
        setupButtonsTargets()
    }
    
    // MARK: - Setups
    
    private func setupLabelText(withTime time: (UInt, UInt)) {
        let (minutes, seconds) = time
        
        let textMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let textSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"

        minutesLabel.text = textMinutes
        secondsLabel.text = textSeconds
    }
    
    private func setupInitial() {
        // Uncomment to test
        // clockTime = (24, 30)
        
        let currentProgress = CGFloat(clockTime.minutes) * currentTimerStep
        progressStep(withStep: currentProgress)
        setupLabelText(withTime: clockTime)
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
        clockTime = (0, 0)
        stopTimer()
        stopTimerButton.isEnabled = false
        mainView.resetProgress()
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
        clockTime.seconds += 1
        
        progressStep(withStep: currentTimerStep)
        checkTime()
        checkDuration()
    }
    
    private func checkTime() {
        if clockTime.seconds >= 60 {
            clockTime.minutes += 1
            clockTime.seconds = 0
        }
    }
    
    private func checkDuration() {
        if clockTime.minutes >= currentMaxTimerDuration {
            changeMode()
            clockTime = (0, 0)
            mainView.resetProgress()
        }
    }
    
    // MARK: - Helper funcs
    
    private func changeMode() {
        switch currentMode {
        case .work:
            currentMode = .rest
        case .rest:
            currentMode = .work
        }
    }
    
    private func progressStep(withStep step: CGFloat) {
        mainView.progressStep(withStep: step)
    }
}
