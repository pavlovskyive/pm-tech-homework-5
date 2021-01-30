//
//  ParticleView.swift
//  Homework5
//
//  Created by Vsevolod Pavlovskyi on 30.01.2021.
//

import UIKit

class ParticleView: UIView {
    
    var emitterType: EmitterType? {
        didSet {
            setNeedsLayout()
        }
    }
    
    enum EmitterType {
        case snow,
             confetti,
             firework
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override func layoutSubviews() {
        let emitter = layer as! CAEmitterLayer

        switch emitterType {
        case .snow:
            emitter.emitterShape = .line
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -10)
            emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)

            let near = generateSnowEmitterCell(imageName: "circle", color: UIColor(white: 1, alpha: 1), velocity: 100, scale: 0.4)
            let middle = generateSnowEmitterCell(imageName: "snowParticle", color: UIColor(white: 1, alpha: 0.5), velocity: 80, scale: 0.2)
            let far = generateSnowEmitterCell(imageName: "snowParticle", color: UIColor(white: 1, alpha: 0.2), velocity: 60, scale: 0.1)

            emitter.emitterCells = [near, middle, far]
            
        case .confetti:
            emitter.emitterShape = .line
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -10)
            emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
            
            var emitterCells = [CAEmitterCell]()

            emitterCells = generateConfettiEmitterCells()
            
            emitter.emitterCells = emitterCells
            
        case .firework:
            emitter.emitterShape = .point
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY - 100)
            
            emitter.emitterCells = [generateFireworksEmitterCell()]
            
        default:
            break
        }
        

    }
    
    private func generateSnowEmitterCell(imageName: String, color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
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
    
    private func generateConfettiEmitterCells() -> [CAEmitterCell] {
        
        let images = [
            UIImage(named: "circle"),
            UIImage(named: "confettiParticle"),
            UIImage(named: "star")
        ]
        
        var cells = [CAEmitterCell]()
        for _ in 0...20 {
            let cell = CAEmitterCell()

            cell.birthRate = 2
            cell.lifetime = 30
            cell.lifetimeRange = 0
            cell.velocity = 50
            cell.yAcceleration = 90
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 1
            cell.spin = 0
            cell.spinRange = 4
            cell.color = UIColor.randomConfettiColor().cgColor
            cell.scaleRange = 0.5
            cell.scale = 0.8
            cell.contents = images.randomElement()!?.cgImage
            
            cell.setValue("plane", forKey: "particleType")
            cell.setValue(Double.pi, forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")
            
            cells.append(cell)
        }
        
        return cells
    }
    
    private func generateFireworksEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()

        cell.birthRate = 1.0
        cell.lifetime = 4
        cell.lifetimeRange = 0
        cell.velocity = 250
        cell.velocityRange = 150
        cell.yAcceleration = 80
        cell.emissionLongitude = -90 * (.pi / 180)
        cell.emissionRange = 30 * (.pi / 180)
        cell.scale = 0
        cell.color = UIColor.white.cgColor
        cell.redRange = 0.9
        cell.greenRange = 0.9
        cell.blueRange = 0.9
        
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
}
