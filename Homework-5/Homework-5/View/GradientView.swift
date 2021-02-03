//
//  GradientView.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 30.01.2021.
//

import UIKit

class GradientView: UIView {

    var colors: [CGColor] = [UIColor.white.cgColor, UIColor.white.cgColor]

    var locations: [NSNumber] = [0, 1]

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {

        guard let layer = layer as? CAGradientLayer else {
            return
        }

        layer.colors = colors
        layer.locations = locations
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
}
