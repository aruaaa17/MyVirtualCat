//
//  ModelPicker.swift
//  MyVirtualCat
//
//  Created by April (Huaiyu) Zhang on 8/8/23.
//

import Foundation
import SwiftUI
import UIKit
import RealityKit
import ARKit

struct ModelPickerView: View {
    
    var models: [Model]
//    let vm: IconViewModel
    @Binding var isPlacementEnable: Bool
    @Binding var selectedModel: Model?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
//                Spacer()
                ForEach(0 ..< self.models.count, id: \.self) { index in
                    Button(action: {
                        print("DEBUG : selected model with name : \(self.models[index].modelName)")
                        self.selectedModel = self.models[index]
                        self.isPlacementEnable = true
                        
                    }, label: {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 80, height: 80)
                            .aspectRatio(1/1,contentMode: .fill)
                            .background(Color.white)
                    })
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}
