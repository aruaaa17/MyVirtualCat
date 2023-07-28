//
//  Coordinator.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/27/23.
//

import Foundation
import RealityKit
import ARKit

class Coordinator {
    
    var arView: ARView?
    var catAnchor: AnchorEntity?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let arView = arView else {
            return
        }

        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
            
            // Remove old cat model
            if let catAnchor = catAnchor {
                arView.scene.removeAnchor(catAnchor)
            }
            
           
            let anchor = AnchorEntity(raycastResult: result)
            
            let catEntity = try! Experience.loadCat()
                        anchor.addChild(catEntity)
            // Add light to cat model
            let lightEntity = PointLight()
            lightEntity.light.color = .orange
            lightEntity.light.intensity = 1000
            lightEntity.light.attenuationRadius = 0.5

            lightEntity.look(at: [0.05, 0.05, 0.05], from: [0.1, 0.1, 0.1], relativeTo: catEntity)
            
            catEntity.addChild(lightEntity)
            arView.scene.addAnchor(anchor)
            
            // Save new cat model
            catAnchor = anchor
           
            // Gen collision shapes
            catEntity.generateCollisionShapes(recursive: true)
            // Install gestures
//            arView.installGestures([.all], for: catEntity as! any Entity & HasCollision))
            
        }
    }
    
}
