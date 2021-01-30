//
//  ProgressViewController.swift
//  Homework5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class ProgressViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
    
        titleLabel.font = .rounded(ofSize: 48, weight: .bold)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .systemBlue
        
        titleLabel.text = "Progress Bar Circle"
        
        return titleLabel
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.minimumTrackTintColor = .systemBlue
        
        slider.addTarget(self, action: #selector(handleSlider(_:)), for: .valueChanged)
        
        slider.value = 0.7
        
        return slider
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me to animate progress bar", for: .normal)
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
    
    
    // MARK: - Methods

    // Setup View
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(slider)
        view.addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            slider.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10)
        ])
        
        setupShapeLayer()
    }
    
    @objc private func handleSlider(_ sender: UISlider) {
        
        shapeLayer.strokeStart = 1 - CGFloat(sender.value)
    }
    
    @objc private func animate() {
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.duration = 1
//        animation.isRemovedOnCompletion = false
        animation.fromValue = shapeLayer.strokeStart
        animation.toValue = 0
        
        shapeLayer.strokeStart = 0
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.slider.setValue(1, animated:true)
                       })
        
        shapeLayer.add(animation, forKey: "shapeAnimation")
        
        CATransaction.commit()
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
        shapeLayer.strokeStart = CGFloat(1 - slider.value)
        shapeLayer.strokeEnd = 1
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
    }
}
