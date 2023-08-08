//
//  ContentView.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/25/23.
//

import ARKit
import SwiftUI
import RealityKit
import AVFoundation
import FocusEntity
import Combine

// view protocol
struct ContentView : View {
    
    @State private var isPlacementEnable = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    
    var models : [Model] = {
            let fileManager = FileManager.default
            
            guard let path = Bundle.main.resourcePath,let files = try? fileManager.contentsOfDirectory(atPath: path)else{
                return []
            }
            
            var availableModels : [Model] = []
            for filename in files where
                filename.hasSuffix("usdz"){
                let modelname = filename.replacingOccurrences(of: ".usdz", with: "")
                
                let model = Model(modelName: modelname)
                availableModels.append(model)
            }
            return availableModels
        }()
    
//    @StateObject private var vm = IconViewModel()
    
//    func test() -> some View {
//        print(isPlacementEnable)
//        return Text("test")
//    }
    
//    var models:[String] = ["Heart","Fish","Ball"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmForPlacement: self.$modelConfirmedForPlacement)
            
            if self.isPlacementEnable {
                PlacementButtonView(isPlacementEnable: self.$isPlacementEnable, selectedModel: self.$selectedModel, modelConfirmForPlacement: self.$modelConfirmedForPlacement)
//                test()
            } else {
                ModelPickerView(models: self.models, isPlacementEnable: self.$isPlacementEnable, selectedModel: self.$selectedModel)}
            
        }
    }
}



struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelConfirmForPlacement: Model?
    
//    let vm: IconViewModel

    
    // Set up basic ARView
    func makeUIView(context: Context) -> CustomARView {
//        let arView = ARView(frame: .zero)
//        let arView = CustomARView(frame: .zero)
        CustomARView(frame: .zero)
        
//        return arView
        // Add ARWorld config
//        let session = arView.session
//        let config = ARWorldTrackingConfiguration()
//        config.planeDetection = .horizontal
//        config.environmentTexturing = .automatic
//        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
//            config.sceneReconstruction = .mesh
//        }
//        arView.session.run(config)
//
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
//        context.coordinator.arView = arView
        
//        let scene = try! Experience.loadFish()
//        _ = scene.actions.feed.onAction
        
//        arView.addCoachingOverlay()
//        let arConfig = ARWorldTrackingConfiguration()
//        arConfig.planeDetection = [.horizontal, .vertical]
//        arView.session.run(arConfig)
//        _ = FocusEntity(on: arView, style: .classic())
//        return arView
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        if let model =
            self.modelConfirmForPlacement{
            
            if let modelEntity  = model.modelEntity{
                print("DEBUG adding model to scene = \(model.modelName)")
                
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                
                uiView.scene.addAnchor(anchorEntity)
            }else{
                print("DEBUG unable to load  model to scene for \(model.modelName)")
            }
            
            
            DispatchQueue.main.async {
                self.modelConfirmForPlacement = nil
            }
        }
//        if let modelName = self.confirmModel{
//            print("DEBUG modelName \(modelName)")
//            let filename = modelName + ".usdz"
//            let modelEntity = try!ModelEntity.load(named: filename)
//
//            let anchorEntity = AnchorEntity(plane: .any)
//            anchorEntity.addChild(modelEntity)
//            uiView.scene.addAnchor(anchorEntity)
//
//            DispatchQueue.main.async {
//                self.confirmModel = nil
//            }
//        }
    }
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(vm: vm)
//    }
}

class CustomARView: ARView{
    var focusEntity: FocusEntity?
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
//        self.setupConfig()
        focusEntity = FocusEntity(on: self, focus: .plane)
//        focusSquare.viewDelegate = self
//        focusSquare.delegate = self
//        focusSquare.setAutoUpdate(to: true)
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupARView(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        self.session.run(config)
    }
}

//extension CustomARView: FEDelegate{
//    func toTrackingState() {
//        print("tracking")
//    }
//
//    func toInitializingState() {
//        print("iniitializing")
//    }
//}



struct PlacementButtonView: View {
    @Binding var isPlacementEnable: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmForPlacement: Model?
    var body: some View {
        HStack{
        // cancel button
        Button(action: {
            print("DEBUG : Cancel model placement cancel ")
            self.resetPlacementParameters()
            }){
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
        }
        
        //Confirm Button
        Button(action: {
            print("DEBUG : Cancel model placement confirmed")
            self.modelConfirmForPlacement = self.selectedModel
            self.resetPlacementParameters()
            }){
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    func resetPlacementParameters() {
        self.isPlacementEnable = false
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea()
    }
}
#endif
