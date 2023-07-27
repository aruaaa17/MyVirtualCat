//
//  Coordinater.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/27/23.
//

import Foundation
import ARKit
import RealityKit
import Combine


class Coordinator: NSObject, ARSessionDelegate {
    
    weak var view: ARView?
    var cancellable: AnyCancellable?
   
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        let tapLocation = recognizer.location(in: view)
        
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
            
            // create an anchor entity
            let anchor = AnchorEntity(raycastResult: result)
            
            // async load model
            cancellable = ModelEntity.loadAsync(named: "Cat")
                .sink { loadCompletion in
                    if case let .failure(error) = loadCompletion {
                        print("Unable to find Cat \(error)")
                    }
                    
                    self.cancellable?.cancel()
                    
                } receiveValue: { entity in
                    anchor.addChild(entity)
                }
//            guard let entity = try? ModelEntity.load(named: "Cat") else {
//                fatalError("Please help me find the Cat!")
//            }
//
//            Add entity to the anchor
//            anchor.addChild(entity)
            
            // add anchor to the scene
            view.scene.addAnchor(anchor)
        }
    }
}
