//
//  SpotlightNode.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

public struct SpotlightNode {
    var title: String?
    var text: String
    var view: UIView?
    var target: SpotlightTarget
    var roundedCorners: Bool
    var image: UIImage? = nil

    public init(title: String? = nil, text: String, target: SpotlightTarget, roundedCorners: Bool = true) {
        self.title = title
        self.text = text
        self.view = nil
        self.target = target
        self.roundedCorners = roundedCorners
    }
    
    public init(view: UIView) {
        self.title = nil
        self.text = ""
        self.view = view
        self.target = .none
        self.roundedCorners = false
    }
    
    public init(image: UIImage? = nil, title: String? = nil, text: String) {
        self.title = title
        self.text = text
        self.image = image
        self.view = nil
        self.target = .none
        self.roundedCorners = false
    }
}
