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

    var titleLabel = TitleLabel()

    var button = UIButton()

    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()

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
    @objc private func setupViews() {

        if !titleLabel.isDescendant(of: view) {
            view.addSubview(titleLabel)
        }

        if !button.isDescendant(of: view) {
            view.addSubview(button)
        }

        titleLabel.text =  "Circle Progress Bar Animation"
        titleLabel.textColor = .systemBlue

        button.setTitle("Tap to animate progress bar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.5), for: .disabled)

        button.addTarget(self, action: #selector(animate), for: .touchUpInside)

        if #available(iOS 13, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50)
        ])

        setupShapeLayer()
    }

    // swiftlint:disable function_body_length
    @objc private func animate() {

        button.isEnabled = false

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
        decreaseAnimation.damping = 10
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
    // swiftlint:enable function_body_length

    private func setupShapeLayer() {

        let trackPath = UIBezierPath(
            arcCenter: view.center,
            radius: 70,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true)

        // Track layer.

        trackLayer.path = trackPath.cgPath

        if #available(iOS 13.0, *) {
            trackLayer.fillColor = UIColor.quaternaryLabel.cgColor
        } else {
            trackLayer.fillColor = UIColor.black.cgColor
        }

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

        titleLabel.alpha = 0
        titleLabel.textColor = UIColor.white
        view.bringSubviewToFront(self.titleLabel)

        button.alpha = 0
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.removeTarget(self, action: #selector(animate), for: .touchUpInside)
        self.button.addTarget(self, action: #selector(self.setupViews), for: .touchUpInside)
        view.bringSubviewToFront(self.button)

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.titleLabel.text = "Progress Bar\nCompleted"
                self.titleLabel.alpha = 1
            })

        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: .curveEaseInOut,
            animations: {
                self.button.setTitle("Reset animation", for: .normal)
                self.button.alpha = 1
            }, completion: {_ in
                self.button.isEnabled = true
            })
    }
}
