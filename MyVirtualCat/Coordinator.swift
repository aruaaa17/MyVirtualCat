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
//    let catEntity = try! Experience.loadCat()
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let touchInView = sender?.location(in: self.arView) else {
          return
        }
        
        if let result = arView?.raycast(from: touchInView,
          allowing: .existingPlaneGeometry, alignment: .horizontal
        ).first {
            print(result.worldTransform)
            // Remove old cat model
            if let catAnchor = catAnchor {
                arView?.scene.removeAnchor(catAnchor)
            }
            let anchor = AnchorEntity(raycastResult: result)
            let catEntity = try! Experience.loadCat()
            anchor.addChild(catEntity)
            
            let lightEntity = Lighting().light
            catEntity.components.set(lightEntity)
            
            arView?.scene.addAnchor(anchor)
            arView?.scene.anchors.append(anchor)
            
            catAnchor = anchor
            
        }
        
    }
    
}

class Lighting: Entity, HasDirectionalLight {
    
    required init() {
        super.init()
        
        self.light = DirectionalLightComponent(color: .orange, intensity: 4500, isRealWorldProxy: true)
    }
}
