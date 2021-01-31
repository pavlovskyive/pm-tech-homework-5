//
//  ConfettiViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit
import Homework

class ConfettiViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var titleLabel: TitleLabel = {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Confetti Animation")
        
        for i in 0..<attributedString.length {
            let range = NSRange(location: i, length: 1)
            let randomColor = UIColor.randomConfettiColor()
            
            attributedString.addAttribute(.foregroundColor, value: randomColor, range: range)
        }
        
        let titleLabel = TitleLabel()
        titleLabel.attributedText = attributedString
        
        return titleLabel
    }()
    
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
        
        let confettiView = ParticleView()
        confettiView.emitterType = .confetti
        confettiView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confettiView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
