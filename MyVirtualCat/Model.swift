//
//  Model.swift
//  MyVirtualCat
//
//  Created by April (Huaiyu) Zhang on 8/8/23.
//

import UIKit
import RealityKit
import Combine

class Model{
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    @Published var position: SIMD3<Float> = SIMD3<Float>(0, 0, 0)
    @Published var scale: SIMD3<Float> = SIMD3<Float>(0.005, 0.005, 0.005)

    init(modelName: String) {
        
        self.modelName = modelName
        
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion:{
                loadCompletion in
                // handle error
                print("DEBUG Unable to load modelENtity for modelname : \(self.modelName)")
            },receiveValue: {
                modelEntity in
                // get out modelEntity
                modelEntity.transform.translation = self.position
                modelEntity.scale = self.scale
                let lightEntity = Lighting().light
                modelEntity.components.set(lightEntity)
                self.modelEntity = modelEntity
                
                print("DEBUG : successfully loaded modelEnity for modelName :\(self.modelName)")
            })
        
    }

}

