//
//  RecordViewController.swift
//  Homework5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class RecordViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var circleShapeLayers = createCircleShapeLayer(numberOfLayers: 3)
    
    lazy var titleLabel = TitleLabel(text: "Record Animation", color: .systemRed)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAnimations()
    }
    
    // Add notification on app enters foreground.
    // Because: CABasicAnimation is removed when application enters background mode
    // and we need to reasign animations.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }
    
    // Remove notification.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        circleShapeLayers.forEach { $0.frame = view.bounds}
        circleShapeLayers.forEach { $0.anchorPoint = CGPoint(x: 0.5, y: 0.5) }

    }
    
    // MARK: - Methods

    // Setup View
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10)
        ])

        circleShapeLayers.forEach { view.layer.addSublayer($0) }
    }
    
    // Create circle-shaped layers of given number.
    private func createCircleShapeLayer(numberOfLayers number: Int) -> [CALayer] {
        
        var layers = [CALayer]()
        
        for _ in 1...number {
            let shapeLayer = CAShapeLayer()
            
            let circlePath = UIBezierPath(
                arcCenter: view.center,
                radius: 100,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true)
            
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.systemRed.cgColor
            // Opacity is zero for animation to begin seamlessly.
            shapeLayer.opacity = 0
            
            layers.append(shapeLayer)
        }
        
        return layers
    }
    
    private func setupAnimations() {
        
        circleShapeLayers.enumerated().forEach { (index, layer) in
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0
            scaleAnimation.toValue = 1
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [opacityAnimation, scaleAnimation]

            animationGroup.duration = 1.2
            animationGroup.repeatCount = .infinity
            animationGroup.beginTime = CACurrentMediaTime() + 0.2 * Double(index)
            
            layer.add(animationGroup, forKey: "animationGroup")
        }
    }
    
    // Handle application enters foreground.
    @objc private func applicationWillEnterForeground(_ notification: NSNotification) {
        setupAnimations()
    }
    
}
