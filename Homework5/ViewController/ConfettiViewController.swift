//
//  ConfettiViewController.swift
//  Homework5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class ConfettiViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
    
        titleLabel.font = .rounded(ofSize: 48, weight: .bold)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .systemRed
        
        titleLabel.text = "Happy Birthday!"
        
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
