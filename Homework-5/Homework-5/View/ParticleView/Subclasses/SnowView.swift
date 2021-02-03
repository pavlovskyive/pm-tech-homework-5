//
//  SnowView.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 03.02.2021.
//

import UIKit

class SnowView: ParticleView {

    override func layoutSubviews() {

        self.emitterShape = .line
        self.emitterPosition = CGPoint(x: frame.midX, y: -10)
        self.emitterSize = CGSize(width: frame.size.width, height: 1)

        super.layoutSubviews()
    }

    override var emitterCells: [CAEmitterCell] {

        let near = generateSnowEmitterCell(
            imageName: "circle",
            color: UIColor(white: 1, alpha: 1),
            velocity: 100,
            scale: 0.4)

        let middle = generateSnowEmitterCell(
            imageName: "snowParticle",
            color: UIColor(white: 1, alpha: 0.5),
            velocity: 80,
            scale: 0.2)

        let far = generateSnowEmitterCell(
            imageName: "snowParticle",
            color: UIColor(white: 1, alpha: 0.2),
            velocity: 60,
            scale: 0.1)

        return [near, middle, far]
    }

    private func generateSnowEmitterCell(
        imageName: String,
        color: UIColor,
        velocity: CGFloat,
        scale: CGFloat) -> CAEmitterCell {

        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 20
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = velocity
        cell.velocityRange = velocity / 4
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = scale
        cell.scaleRange = scale / 3

        cell.contents = UIImage(named: imageName)?.cgImage
        return cell
    }
}
