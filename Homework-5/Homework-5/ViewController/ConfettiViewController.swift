//
//  ConfettiViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit
import Homework

fileprivate extension String {

    func toRandomColoredString() -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self)

        for index in 0..<attributedString.length {
            let range = NSRange(location: index, length: 1)
            let randomColor = UIColor.randomConfettiColor()

            attributedString.addAttribute(.foregroundColor, value: randomColor, range: range)
        }

        return attributedString
    }
}

class ConfettiViewController: ParticleViewController {

    // MARK: - Lifecycle

    convenience init() {
        let confettiView = ConfettiView()
        self.init(title: "Confetti Animation".toRandomColoredString(), particleView: confettiView)
    }
}
