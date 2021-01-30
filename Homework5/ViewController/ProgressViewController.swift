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
        
        titleLabel.text = "Progress Bar Circle Animation"
        
        return titleLabel
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.minimumTrackTintColor = .systemBlue
        
        slider.addTarget(self, action: #selector(handleSlider(_:)), for: .valueChanged)
        
        return slider
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
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            slider.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -50)
        ])
        
        setupShapeLayer()
    }
    
    @objc private func handleSlider(_ sender: UISlider) {
        
        shapeLayer.strokeEnd = CGFloat(sender.value)
    }
    
    private func setupShapeLayer() {
        
        let circularPath = UIBezierPath(
            arcCenter: view.center,
            radius: 100,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true)
        
        // Track layer.
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.systemBlue.withAlphaComponent(0.2).cgColor
        trackLayer.fillColor = .none
        trackLayer.lineWidth = 20
        
        // Progress bar layer.
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.fillColor = .none
        shapeLayer.lineWidth = 20
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
    }
}
