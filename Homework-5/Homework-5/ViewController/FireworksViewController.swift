//
//  FireworksViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class FireworksViewController: ParticleViewController {

    // MARK: - Variables

    lazy var skyView: UIView = {
        let view = GradientView()

        view.colors = [
            UIColor.black.cgColor,
            UIColor(red: 0.29, green: 0.07, blue: 0.31, alpha: 1.00).cgColor,
            UIColor(red: 0.79, green: 0.29, blue: 0.29, alpha: 1.00).cgColor
        ]

        view.locations = [0, 0.5, 1]

        return view
    }()

    lazy var cityImageView: UIImageView = {
        let image = UIImage(named: "city")

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.contentScaleFactor = 2

        return imageView
    }()

    // MARK: - Lifecycle

    convenience init() {
        let fireworksView = FireworksView()
        self.init(title: "Fireworks Animation", particleView: fireworksView)
    }

    // MARK: - Methods

    // Setup View
    override func setupViews() {

        super.setupViews()

        view.insertSubview(skyView, at: 0)
        view.addSubview(cityImageView)

        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        skyView.translatesAutoresizingMaskIntoConstraints = false

        let width = cityImageView.image?.size.width ?? 1
        let height = cityImageView.image?.size.height ?? 1
        let imageRatio = height / width

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),

            skyView.topAnchor.constraint(equalTo: view.topAnchor),
            skyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            cityImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cityImageView.heightAnchor.constraint(
                equalTo: cityImageView.widthAnchor,
                multiplier: imageRatio)
        ])
    }
}
