//
//  TitleLabel.swift
//  Homework5
//
//  Created by Vsevolod Pavlovskyi on 31.01.2021.
//

import UIKit

class TitleLabel: UILabel {
    
    var titleText: String?

    convenience init(text: String?, color: UIColor?) {
        self.init(frame: .zero)
        
        self.text = text
        self.textColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        font = .rounded(ofSize: 48, weight: .bold)
        numberOfLines = 3
    }
}
