//
//  Coordinator.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/27/23.
//

import Foundation
import RealityKit
import ARKit
import Combine

class Coordinator {
    
    var arView: ARView?
    var catAnchor: AnchorEntity?
    let catEntity = try! Experience.loadCat()
    
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
            let lightEntity = Lighting().light
            
            catEntity.components.set(lightEntity)
            arView.scene.addAnchor(anchor)
            arView.scene.anchors.append(catEntity)
            
            // Save new cat model
            catAnchor = anchor
           
            // Gen collision shapes
            catEntity.generateCollisionShapes(recursive: true)
            // Install gestures
//            arView.installGestures([.all], for: catEntity as! any Entity & HasCollision))
            
        }
    }
    
}

class Lighting: Entity, HasDirectionalLight {
    
    required init() {
        super.init()
        
        self.light = DirectionalLightComponent(color: .orange, intensity: 4500, isRealWorldProxy: true)
    }
}
