//
//  ViewController.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    private var timer: Timer?
    private var clockTime: UInt = 0
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
    
    // MARK: - VC Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelText(withTime: clockTime)
        playTimerButton.addTarget(self, action: #selector(playTimer), for: .touchUpInside)
        pauseTimerButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
    }
    
    // MARK: - Setups
    
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
