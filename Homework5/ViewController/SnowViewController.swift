//
//  SnowViewController.swift
//  Homework5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class SnowViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var skyView: UIView = {
        let view = GradientView()
        
        view.colors = [
            UIColor(red: 0.1, green: 0.25, blue: 0.5, alpha: 1).cgColor,
            UIColor(red: 0.75, green: 0.8, blue: 0.9, alpha: 1).cgColor
        ]
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
    
        titleLabel.font = .rounded(ofSize: 48, weight: .bold)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .white
        
        titleLabel.text = "Snow Animation"
        
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
        view.insertSubview(skyView, at: 0)
        view.addSubview(titleLabel)
        
        let snowView = ParticleView()
        snowView.emitterType = .snow
        snowView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snowView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        skyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            skyView.topAnchor.constraint(equalTo: view.topAnchor),
            skyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            snowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snowView.topAnchor.constraint(equalTo: view.topAnchor),
            snowView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
