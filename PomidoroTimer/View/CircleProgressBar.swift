//
//  CircleProgressBar.swift
//  PomidoroTimer
//
//  Created by Давид Тоноян  on 23.12.2022.
//

import UIKit

final class CircleProgressBar: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCircularPath() {
        let circleCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let circularPath = UIBezierPath(arcCenter: circleCenter,
                                        radius: 160,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        configurateCircleLayer()
        layer.addSublayer(circleLayer)

        progressLayer.path = circularPath.cgPath
        configurateProgressLayer()
        layer.addSublayer(progressLayer)
    }
    
    private func configurateCircleLayer() {
        circleLayer.fillColor = Constants.Color.clear
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 2
        circleLayer.strokeEnd = 1
        circleLayer.strokeColor = Constants.Color.alphaWhite.cgColor
    }
    
    private func configurateProgressLayer() {
        progressLayer.fillColor = Constants.Color.clear
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = Constants.Color.white.cgColor
    }
    
    func progress(value: CGFloat) {
        progressLayer.strokeEnd += value
    }
    
    func resetBar() {
        progressLayer.strokeEnd = 0
    }
}
