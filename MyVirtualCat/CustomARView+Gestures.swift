//
//  CustomARView+Gestures.swift
//  MyVirtualCat
//
//  Created by April (Huaiyu) Zhang on 8/10/23.
//

/// Pause to use
import Foundation
import ARKit
import RealityKit

extension CustomARView {


    func enableObjectRemoval() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))

        tapGestureRecognizer.numberOfTapsRequired = 2

        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func handleTap(recognizer: UIGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location) {
            entity.removeFromParent()
        }
    }

}
