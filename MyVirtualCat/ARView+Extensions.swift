//
//  ARView+Extensions.swift
//  MyVirtualCat
//
//  Created by April (Huaiyu) Zhang on 7/27/23.
//

import Foundation
import RealityKit
import ARKit
import UIKit

extension ARView {
    
    func addCoachingOverlay() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        self.addSubview(coachingOverlay)
        
    }
    

    
}
