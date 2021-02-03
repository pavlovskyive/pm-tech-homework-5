//
//  FireworksView.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 03.02.2021.
//

import UIKit

class FireworksView: ParticleView {

    override func layoutSubviews() {

        self.emitterShape = .point
        self.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY - 100)

        super.layoutSubviews()
    }

    override var emitterCells: [CAEmitterCell] {

        return [
            generateFireworksEmitterCell(birthRate: 0.7),
            generateFireworksEmitterCell(birthRate: 1.7)
        ]
    }

    // swiftlint:disable function_body_length
    private func generateFireworksEmitterCell(birthRate: Float) -> CAEmitterCell {
        let cell = CAEmitterCell()

        cell.birthRate = birthRate
        cell.lifetime = 4
        cell.lifetimeRange = 0
        cell.velocity = 250
        cell.velocityRange = 150
        cell.yAcceleration = 80
        cell.emissionLongitude = -90 * (.pi / 180)
        cell.emissionRange = 30 * (.pi / 180)
        cell.scale = 0
        cell.color = UIColor.white.cgColor
        cell.redRange = 1
        cell.greenRange = 1
        cell.blueRange = 1

        let trailCell = CAEmitterCell()
        trailCell.contents = UIImage(named: "circle")?.cgImage
        trailCell.birthRate = 45
        trailCell.lifetime = 0.5
        trailCell.beginTime = 0
        trailCell.duration = 2
        trailCell.velocity = 80
        trailCell.velocityRange = 50
        trailCell.velocityRange = 100
        trailCell.xAcceleration = 100
        trailCell.yAcceleration = 350
        trailCell.emissionLongitude = -360 * (.pi / 180)
        trailCell.emissionRange = 10 * (.pi / 180)
        trailCell.scale = 1
        trailCell.scaleSpeed = 0.3
        trailCell.alphaSpeed = -1

        let explosionCell = CAEmitterCell()
        explosionCell.contents = UIImage(named: "circle")?.cgImage
        explosionCell.birthRate = 10000
        explosionCell.lifetime = 15
        explosionCell.beginTime = 2
        explosionCell.duration = 0.1
        explosionCell.velocity = 150
        explosionCell.velocityRange = 70
        explosionCell.yAcceleration = 80
        explosionCell.emissionRange = 360 * (.pi / 180)
        explosionCell.spin = 100 * (.pi / 180)
        explosionCell.scale = 1.5
        explosionCell.scaleSpeed = 0.15
        explosionCell.alphaSpeed = -0.7

        cell.emitterCells = [trailCell, explosionCell]

        return cell
    }
    // swiftlint:enable function_body_length
}
