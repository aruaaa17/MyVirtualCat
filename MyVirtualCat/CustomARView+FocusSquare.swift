//
//  CustomARView.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 8/8/23.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView{
    var focusEntity: FocusEntity?
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusEntity = FocusEntity(on: self, focus: .classic)
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupARView(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        self.session.run(config)
    }
}
