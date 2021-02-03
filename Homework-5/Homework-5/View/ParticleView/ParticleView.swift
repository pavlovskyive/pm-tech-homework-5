//
//  ParticleView.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 30.01.2021.
//

import UIKit

class ParticleView: UIView {

    internal var emitterShape: CAEmitterLayerEmitterShape?
    internal var emitterPosition: CGPoint?
    internal var emitterSize: CGSize?

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
        setEmitter()
    }

    private func setEmitter() {

        guard let emitter = layer as? CAEmitterLayer else {
            return
        }

        emitter.emitterCells = emitterCells

        if let emitterShape = emitterShape {
            emitter.emitterShape = emitterShape
        }

        if let emitterPosition = emitterPosition {
            emitter.emitterPosition = emitterPosition
        }

        if let emitterSize = emitterSize {
            emitter.emitterSize = emitterSize
        }
    }

    internal var emitterCells: [CAEmitterCell] {
        fatalError("Must override var emitterCells")
    }
}
