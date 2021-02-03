//
//  SnowViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class SnowViewController: ParticleViewController {

    // MARK: - Variables

    lazy var skyView: UIView = {
        let view = GradientView()

        view.colors = [
            UIColor(red: 0.1, green: 0.25, blue: 0.5, alpha: 1).cgColor,
            UIColor(red: 0.75, green: 0.8, blue: 0.9, alpha: 1).cgColor
        ]

        return view
    }()

    // MARK: - Lifecycle

    convenience init() {
        let snowView = SnowView()
        self.init(title: "Snow Animation", particleView: snowView)
    }

    // MARK: - Methods

    // Setup View
    override func setupViews() {

        super.setupViews()

        view.insertSubview(skyView, at: 0)

        skyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            skyView.topAnchor.constraint(equalTo: view.topAnchor),
            skyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
