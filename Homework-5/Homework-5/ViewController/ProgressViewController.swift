//
//  ProgressViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit
import Homework

class ProgressViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var titleLabel = TitleLabel(text: "Circle Progress Bar Animation", color: UIColor.systemBlue)
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap to animate progress bar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        
        return button
    }()
    
    let shapeLayer = CAShapeLayer()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        shapeLayer.frame = view.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

    }
    
    // MARK: - Methods

    // Setup View
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        ])
        
        setupShapeLayer()
    }
    
    @objc private func animate() {
        
        shapeLayer.strokeStart = 1
        
        var animations = [CABasicAnimation]()
        
        let strokeAnimation = CASpringAnimation(keyPath: "strokeStart")
        strokeAnimation.damping = 30
        strokeAnimation.duration = strokeAnimation.settlingDuration
        strokeAnimation.fromValue = shapeLayer.strokeStart
        strokeAnimation.toValue = 0
        
        shapeLayer.strokeStart = 0
        
        animations.append(strokeAnimation)
        
        let colorChangeAnimation = CABasicAnimation(keyPath: "strokeColor")
        colorChangeAnimation.duration = 1
        colorChangeAnimation.toValue = UIColor.systemGreen.cgColor
        colorChangeAnimation.fillMode = .forwards
        colorChangeAnimation.isRemovedOnCompletion = false
        
        animations.append(colorChangeAnimation)
        
        let decreaseAnimation = CASpringAnimation(keyPath: "transform.scale")
        decreaseAnimation.damping = 5
        decreaseAnimation.duration = decreaseAnimation.settlingDuration
        decreaseAnimation.beginTime = strokeAnimation.duration + 1
        decreaseAnimation.fromValue = 1
        decreaseAnimation.toValue = 0.7
        decreaseAnimation.fillMode = .forwards
        decreaseAnimation.isRemovedOnCompletion = false
        
        animations.append(decreaseAnimation)
        
        let increaseAnimation = CABasicAnimation(keyPath: "transform.scale")
        increaseAnimation.duration = 0.2
        increaseAnimation.beginTime = strokeAnimation.duration + decreaseAnimation.duration
        increaseAnimation.fromValue = 0.7
        increaseAnimation.toValue = 10
        increaseAnimation.fillMode = .forwards
        increaseAnimation.isRemovedOnCompletion = false
        
        animations.append(increaseAnimation)
        
        let group = CAAnimationGroup()
        group.animations = animations
        group.duration = (group.animations?.last?.beginTime ?? 0) + (group.animations?.last?.duration ?? 0)
        group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        
        group.delegate = self
        
        shapeLayer.add(group, forKey: "groupAnimation")
    }
    
    private func setupShapeLayer() {
        
        let trackPath = UIBezierPath(
            arcCenter: view.center,
            radius: 70,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true)
        
        // Track layer.
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = trackPath.cgPath
        
        trackLayer.fillColor = UIColor.black.cgColor
        
        // Progress bar layer.
        
        let circularPath = UIBezierPath(
            arcCenter: view.center,
            radius: 30,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.fillColor = .none
        shapeLayer.lineWidth = 60
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.strokeStart = 1
        shapeLayer.strokeEnd = 1
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        
        view.layer.masksToBounds = true
    }
}

extension ProgressViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        button.isEnabled = false
        
        titleLabel.alpha = 0
        titleLabel.textColor = UIColor.white
        
        UIView.transition(
            with: titleLabel,
            duration: 0.5,
            options: .curveEaseInOut,
            animations: {
                self.view.bringSubviewToFront(self.titleLabel)
                self.titleLabel.text = "Progress Bar\nCompleted"
                self.titleLabel.alpha = 1
            })
    }
}