//
//  ParticleViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 03.02.2021.
//

import UIKit
import Homework

class ParticleViewController: UIViewController {

    // MARK: - Variables

    private var particleView: ParticleView

    lazy var titleLabel = TitleLabel(text: "Snow Animation", color: UIColor.white)

    // MARK: - Lifecycle

    init(title: String, particleView: ParticleView) {

        self.particleView = particleView

        super.init(nibName: nil, bundle: nil)

        titleLabel.text = title
    }

    init(title: NSAttributedString, particleView: ParticleView) {

        self.particleView = particleView

        super.init(nibName: nil, bundle: nil)

        titleLabel.attributedText = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    // Setup View
    internal func setupViews() {

        if #available(iOS 13, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        particleView.frame = view.bounds

        view.addSubview(titleLabel)

        particleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(particleView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),

            particleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            particleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            particleView.topAnchor.constraint(equalTo: view.topAnchor),
            particleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
