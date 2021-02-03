//
//  ConfettiView.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 03.02.2021.
//

import UIKit

class ConfettiView: ParticleView {

    override func layoutSubviews() {

        self.emitterShape = .line
        self.emitterPosition = CGPoint(x: frame.midX, y: -10)
        self.emitterSize = CGSize(width: frame.size.width, height: 1)

        super.layoutSubviews()
    }

    override var emitterCells: [CAEmitterCell] {

        let images = [
            UIImage(named: "circle"),
            UIImage(named: "confettiParticle"),
            UIImage(named: "star")
        ]

        var cells = [CAEmitterCell]()
        for _ in 0...20 {
            let cell = CAEmitterCell()

            cell.birthRate = 5
            cell.lifetime = 30
            cell.lifetimeRange = 0
            cell.velocity = 50
            cell.yAcceleration = 90
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 3
            cell.spin = 0
            cell.spinRange = 4
            cell.color = UIColor.randomConfettiColor().cgColor
            cell.scaleRange = 0.7
            cell.scale = 0.8
            cell.alphaRange = 0.3
            cell.contents = images.randomElement()!?.cgImage

            cell.setValue("plane", forKey: "particleType")
            cell.setValue(Double.pi, forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")

            cells.append(cell)
        }

        return cells
    }
}
